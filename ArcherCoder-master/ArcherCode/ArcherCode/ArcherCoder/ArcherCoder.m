//
//  ArcherCoder.m
//  Archive
//
//  Created by 王会军 on 2017/6/9.
//  Copyright © 2017年 whj_Object_c. All rights reserved.
//

#import "ArcherCoder.h"
/*
 *  OC底层
 */
#import <objc/message.h>

@implementation ArcherCoder

// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    // 获取 .h 中属性的个数 -- count
    Ivar *ivars = class_copyIvarList([ArcherCoder class], &count);
    for (int index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        // 取出属性名称 并 UTF8
        const char *name = ivar_getName(ivar);
        NSString *keyName = [NSString stringWithUTF8String:name];
        // 归档
        [aCoder encodeObject:[self valueForKey:keyName] forKey:keyName];
    }
    // 释放内存 OC底层手动释放
    free(ivars);
}

// 解档
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        // 获取 .h 中属性的个数 -- count
        Ivar *ivars = class_copyIvarList([ArcherCoder class], &count);
        for (int index = 0; index < count; index ++) {
            Ivar ivar = ivars[index];
            // 取出属性名称 并 UTF8
            const char *name = ivar_getName(ivar);
            NSString *keyName = [NSString stringWithUTF8String:name];
            // 解档
            id value = [coder decodeObjectForKey:keyName];
            // 设置到属性上
            [self setValue:value forKey:keyName];
        }
        // 释放内存 OC底层手动释放
        free(ivars);
    }
    return self;
}

@end

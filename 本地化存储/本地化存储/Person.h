//
//  Person.h
//  本地化存储
//
//  Created by Jeffrey on 2018/11/15.
//  Copyright © 2018年 JeffreyTaiT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic,strong) NSString *name;

@property (nonatomic,assign) NSInteger age;

@property (nonatomic,strong) NSString *sex;

@end

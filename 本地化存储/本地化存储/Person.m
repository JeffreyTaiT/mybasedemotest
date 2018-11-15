//
//  Person.m
//  本地化存储
//
//  Created by Jeffrey on 2018/11/15.
//  Copyright © 2018年 JeffreyTaiT. All rights reserved.
//

#import "Person.h"

#define Name @"name"
#define Age  @"age"
#define Sex  @"sex"

@implementation Person

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        self.name = [aDecoder decodeObjectForKey:Name];
        self.age = [[aDecoder decodeObjectForKey:Age] integerValue];
        self.sex = [aDecoder decodeObjectForKey:Sex];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:Name];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.age] forKey:Age];
    [aCoder encodeObject:self.sex forKey:Sex];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@--%@--%ld岁",self.name,self.sex,(long)self.age];
}

@end

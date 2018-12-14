//
//  UserDefaultModel.m
//  ModelText
//
//  Created by 王会军 on 2017/5/19.
//  Copyright © 2017年 whj_Object_c. All rights reserved.
//

#import "UserDefaultModel.h"

@implementation UserDefaultModel

/*
    NSUserDefaults 轻量级存储数据
 */
// NSUserDefaults 存
+ (void)setUserDefaults_value:(id)_value _key:(NSString *)_key{
    // 定义 轻量级存储 同步数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    // 存储数据 同步数据
    [defaults setObject:_value forKey:_key];
    [defaults synchronize];
}
// NSUserDefaults 取
+ (id)getUserDefaults_key:(NSString *)_key{
    // 定义 轻量级存储 同步数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    // 判断 key 是否存在
    BOOL isKey = [self getBoolValueForConfigurationKey:_key];
    if (isKey) {
        // 用 Key 取出 Vlaue 同步数据
        return [defaults objectForKey:_key];
    } else {
        // 不存在返回空 防止出现 null
        return @"";
    }
}
// NSUserDefaults 删
+ (void)delUserDefaults_key:(NSString *)_key{
    // 定义 轻量级存储 同步数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    // 判断 key 是否存在
    BOOL isKey = [self getBoolValueForConfigurationKey:_key];
    if (isKey) {
        // 删除 key 同步数据
        [defaults removeObjectForKey:_key];
        [defaults synchronize];
    }
}
// NSUserDefaults 判断轻量级中 是否存在 Key
+ (BOOL)getBoolValueForConfigurationKey:(NSString *)_key{
    BOOL isKey = false;
    // 定义 轻量级存储 同步数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    // 判断 key 是否存在
    if ([defaults objectForKey:_key]) {
        isKey = true;
    }
    return isKey;
}

@end

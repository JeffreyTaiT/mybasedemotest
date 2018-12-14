//
//  UserDefaultModel.h
//  ModelText
//
//  Created by 王会军 on 2017/5/19.
//  Copyright © 2017年 whj_Object_c. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultModel : NSObject

/*
 NSUserDefaults 轻量级存储数据
 */
// NSUserDefaults 存
+ (void)setUserDefaults_value:(id)_value _key:(NSString *)_key;
// NSUserDefaults 取
+ (id)getUserDefaults_key:(NSString *)_key;
// NSUserDefaults 删
+ (void)delUserDefaults_key:(NSString *)_key;

@end

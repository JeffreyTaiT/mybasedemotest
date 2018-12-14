//
//  ArcherModel.h
//  ArcherCode
//
//  Created by 王会军 on 2017/12/13.
//  Copyright © 2017年 whj_Object_c. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArcherCoder.h"

@interface ArcherModel : NSObject

// 归档存储用户信息
+ (void)getUserInfoSaveAction:(id)userInfo;

// 解档存储用户信息
+ (ArcherCoder *)getUserInfoTakeAction;

@end

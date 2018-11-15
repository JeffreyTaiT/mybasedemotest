//
//  Car+CoreDataProperties.h
//  本地化存储
//
//  Created by Jeffrey on 2018/11/15.
//  Copyright © 2018年 JeffreyTaiT. All rights reserved.
//
//

#import "Car+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

+ (NSFetchRequest<Car *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *color;
@property (nonatomic) float size;
@property (nullable, nonatomic, copy) NSString *brand;

@end

NS_ASSUME_NONNULL_END

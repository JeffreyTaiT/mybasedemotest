//
//  Car+CoreDataProperties.m
//  本地化存储
//
//  Created by Jeffrey on 2018/11/15.
//  Copyright © 2018年 JeffreyTaiT. All rights reserved.
//
//

#import "Car+CoreDataProperties.h"

@implementation Car (CoreDataProperties)

+ (NSFetchRequest<Car *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Car"];
}

@dynamic color;
@dynamic size;
@dynamic brand;

@end

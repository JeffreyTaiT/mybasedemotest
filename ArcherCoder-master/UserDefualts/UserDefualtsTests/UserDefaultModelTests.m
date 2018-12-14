//
//  UserDefaultModelTests.m
//  UserDefualtsTests
//
//  Created by 王会军 on 2017/12/13.
//  Copyright © 2017年 whj_Object_c. All rights reserved.
//

#import <XCTest/XCTest.h>

// 第一步 导入头文件
#import "UserDefaultModel.h"

@interface UserDefaultModelTests : XCTestCase

@end

@implementation UserDefaultModelTests
{
    // 第二部 创建局部变量
    UserDefaultModel *model;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // 每个test方法执行前调用，在这个测试用例里进行一些通用的初始化工作
    model = [[UserDefaultModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    // 每个test方法执行后调用 释放占用资源
    model = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // 初始为 null -> @"" 判断是否相等
    // 相等 通过 成功
    // 不相等 不通过 失败
    // XCTAssertEqualObjects
    
    // 测试方法样例
    // 验证本地是否存在此键值对
    NSString *textValue1 = [UserDefaultModel getUserDefaults_key:@"textKey"];
    XCTAssertEqualObjects(@"", textValue1);
    
    // 存储键值对
    [UserDefaultModel setUserDefaults_value:@"textValue" _key:@"textKey"];
    // 验证是否存入此键值对
    NSString *textValue2 = [UserDefaultModel getUserDefaults_key:@"textKey"];
    XCTAssertEqualObjects(@"textValue", textValue2);
    
    // 删除键值对
    [UserDefaultModel delUserDefaults_key:@"textKey"];
    // 验证删除是否成功
    NSString *textValue3 = [UserDefaultModel getUserDefaults_key:@"textKey"];
    XCTAssertEqualObjects(@"", textValue3);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
        // 这个方法主要是做性能测试的，所谓性能测试，主要就是评估一段代码的运行时间。该方法就是性能测试方法的样例。
        
        // 规定时间内执行的时间
        for (int i = 0; i < 100; i ++) {
            NSString *textKeyStr = [NSString stringWithFormat:@"textKey%d", i];
            NSString *textValueStr = [NSString stringWithFormat:@"textValue%d", i];
            // 验证是否已存在
            NSString *textValue1 = [UserDefaultModel getUserDefaults_key:textKeyStr];
            XCTAssertEqualObjects(@"", textValue1);
            // 存储
            [UserDefaultModel setUserDefaults_value:textValueStr _key:textKeyStr];
            NSString *textValue2 = [UserDefaultModel getUserDefaults_key:textKeyStr];
            XCTAssertEqualObjects(textValueStr, textValue2);
            // 删除
            [UserDefaultModel delUserDefaults_key:textKeyStr];
            NSString *textValue3 = [UserDefaultModel getUserDefaults_key:textKeyStr];
            XCTAssertEqualObjects(@"", textValue3);
            
        }
        
    }];
}

@end

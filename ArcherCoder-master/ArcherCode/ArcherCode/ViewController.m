//
//  ViewController.m
//  ArcherCode
//
//  Created by 王会军 on 2017/12/13.
//  Copyright © 2017年 whj_Object_c. All rights reserved.
//

#import "ViewController.h"

#import "ArcherModel.h"
#import "ArcherCoder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 增加测试数据
    NSMutableDictionary *testDic = [NSMutableDictionary dictionary];
    // 姓名 年龄 性别 爱好
    [testDic setObject:@"张三" forKey:@"testName"];
    [testDic setObject:@"23"  forKey:@"testAge"];
    [testDic setObject:@"男" forKey:@"testSex"];
    [testDic setObject:@"打游戏" forKey:@"testHabby"];
    // 存储数据
    [ArcherModel getUserInfoSaveAction:testDic];
    // 取出数据
    ArcherCoder *coder = [ArcherModel getUserInfoTakeAction];
    NSLog(@"\n姓名:%@\n年龄:%@\n性别:%@\n爱好:%@", coder.persionDic[@"testAge"], coder.persionDic[@"testName"], coder.persionDic[@"testSex"], coder.persionDic[@"testHabby"]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  UserDefualts
//
//  Created by 王会军 on 2017/6/8.
//  Copyright © 2017年 whj_Object_c. All rights reserved.
//

#import "ViewController.h"

#import "UserDefaultModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 通过 textKey 查看本地是否存在 textValue
    NSString *textValue1 = [UserDefaultModel getUserDefaults_key:@"textKey"];
    NSLog(@"textValue1 = %@", textValue1);
    
    // 存储 textKey + textValue
    [UserDefaultModel setUserDefaults_value:@"textValue" _key:@"textKey"];
    // 再次通过 textKey 查看本地是否存在 textValue
    NSString *textValue2 = [UserDefaultModel getUserDefaults_key:@"textKey"];
    NSLog(@"textValue2 = %@", textValue2);
    
    // 通过 textKey 删除 textValue
    [UserDefaultModel delUserDefaults_key:@"textKey"];
    // 最后通过 textKey 查看本地是否存在 textValue
    NSString *textValue3 = [UserDefaultModel getUserDefaults_key:@"textKey"];
    NSLog(@"textValue3 = %@", textValue3);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

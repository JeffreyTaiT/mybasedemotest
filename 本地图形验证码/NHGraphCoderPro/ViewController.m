//
//  ViewController.m
//  NHGraphCoderPro
//
//  Created by hu jiaju on 16/5/30.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "ViewController.h"
#import "NHGraphCoder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    CGSize size = self.view.bounds.size;
    NSString *url = @"http://www.hinews.cn/pic/003/012/203/00301220348_27c335fb.jpg";
    NHGraphCoder *coder = [NHGraphCoder codeWithURL:url];
    coder.center = CGPointMake(size.width*0.5, size.height*0.5);
    [coder handleGraphicCoderVerifyEvent:^(NHGraphCoder * _Nonnull cd, BOOL success) {
        NSLog(@"验证结果:%d",success);
    }];
    [self.view addSubview:coder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

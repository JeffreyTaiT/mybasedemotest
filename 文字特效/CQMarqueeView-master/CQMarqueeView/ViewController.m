//
//  ViewController.m
//  CQMarqueeView
//
//  Created by 蔡强 on 2017/8/22.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "CQMarqueeView.h"
#import "UIView+frameAdjust.h"

@interface ViewController ()<CQMarqueeViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CQMarqueeView *marqueeView = [[CQMarqueeView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 30)];
    [self.view addSubview:marqueeView];
    marqueeView.marqueeTextArray = @[@"呵呵呵哒🙄", @"串串香😊" ,@"interesting有趣"];
    marqueeView.delegate = self;
}

// 跑马灯view上的关闭按钮点击时回调
- (void)marqueeView:(CQMarqueeView *)marqueeView closeButtonDidClick:(UIButton *)sender {
    NSLog(@"点击了关闭按钮");
    [UIView animateWithDuration:1 animations:^{
        marqueeView.height = 0;
    } completion:^(BOOL finished) {
        [marqueeView removeFromSuperview];
    }];
}

@end

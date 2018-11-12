//
//  ViewController.m
//  scrollowLabel
//
//  Created by Jeffrey on 2018/11/12.
//  Copyright © 2018年 JeffreyTaiT. All rights reserved.
//

#import "ViewController.h"
#import "MSScrollowLabel.h"


@interface ViewController ()<MSScrollowLabelDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MSScrollowLabel *scrollowlabel = [[MSScrollowLabel alloc] initWithFrame:CGRectMake(15, 200, self.view.frame.size.width, 44)];
    scrollowlabel.marqueeTextArray = @[@"这是一条牛逼的系统通知，需要滚动起来的，666啊", @"糖醋排骨😊" ,@"这又是一条牛逼的系统通知，需要滚动起来的，888啊"];
    scrollowlabel.clostButtonHidden = NO;
    scrollowlabel.delegate = self;
    
    [self.view addSubview:scrollowlabel];
}

#pragma mark- MSScrollowLabelDelegate
- (void)scrollowLabelDidClick:(MSScrollowLabel *)scrollowLabel{
    NSLog(@"点击了详情");
}

- (void)labelView:(MSScrollowLabel *)scrollowLabel closeButtonDidClick:(UIButton *)sender{
    NSLog(@"点击了关闭按钮");
    [UIView animateWithDuration:1 animations:^{
        scrollowLabel.hidden = YES;
    } completion:^(BOOL finished) {
        [scrollowLabel removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

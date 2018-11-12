//
//  MSScrollowLabel.m
//  CloudClinic
//
//  Created by Jeffrey on 2018/11/12.
//  Copyright © 2018年 Jeffrey. All rights reserved.
//

#import "MSScrollowLabel.h"
#import "UIView+frameAdjust.h"
#import "UIColor+Util.h"

@implementation MSScrollowLabel{
    UILabel *_marqueeLabel;
    /** 控制跑马灯的timer */
    CADisplayLink *_displayLink;
    UIButton *_closeButton;
    
    NSInteger _count;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI {
    self.backgroundColor = [UIColor colorWithHexString:@"fff4d8"];
//    [UIColor colorWithHexString:@"fff4d8"];
    self.clipsToBounds = YES;
    
    //------- 左边的喇叭 -------//
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (self.frame.size.height-12)*0.5, 16, 12)];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"volume-marquee"];
    
    //------- 右边的关闭按钮 -------//
    _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 33, (self.frame.size.height-30)*0.5, 30, 30)];
    [self addSubview:_closeButton];
    [_closeButton setImage:[UIImage imageNamed:@"close-marquee"] forState:UIControlStateNormal];
    [_closeButton setImageEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];
    [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //------- marquee View -------//
    
    // 背景
    UIView *marqueeBgView = [[UIView alloc] initWithFrame:CGRectMake(41, 0, self.width - 41 - 38, self.height)];
    [self addSubview:marqueeBgView];
    marqueeBgView.clipsToBounds = YES;
    
    UITapGestureRecognizer *reg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollowLabelDidTouch)];
    [marqueeBgView addGestureRecognizer:reg];
    
    // marquee label
    _marqueeLabel = [[UILabel alloc] initWithFrame:marqueeBgView.bounds];
    [marqueeBgView addSubview:_marqueeLabel];
    _marqueeLabel.textColor = [UIColor colorWithHexString:@"ff6666"];
    _marqueeLabel.font = [UIFont systemFontOfSize:15];
}

-(void)setClostButtonHidden:(BOOL)clostButtonHidden{
    _clostButtonHidden = clostButtonHidden;
    _closeButton.hidden = _clostButtonHidden;
}

#pragma mark - 关闭按钮点击
/** 关闭按钮点击 */
- (void)closeButtonClicked:(UIButton *)sender {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
    if ([self.delegate respondsToSelector:@selector(labelView:closeButtonDidClick:)]) {
        [self.delegate labelView:self closeButtonDidClick:sender];
    }
}

/** 通知详情显示 */
- (void)scrollowLabelDidTouch{
    if ([self.delegate respondsToSelector:@selector(scrollowLabelDidClick:)]) {
        [self.delegate scrollowLabelDidClick:self];
    }
}

#pragma mark - 赋值跑马灯文本数组
/** 赋值跑马灯文本数组 */
- (void)setMarqueeTextArray:(NSArray *)marqueeTextArray {
    _marqueeTextArray = marqueeTextArray;
    
    // 默认展示第一条
    [self setMarqueeText:_marqueeTextArray.firstObject];
    // 从最右边开始移动
    _marqueeLabel.x = _marqueeLabel.superview.width;
    
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
    _count = 0;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshMarqueeLabelFrame)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

/** 改变label位置 */
- (void)refreshMarqueeLabelFrame {
    _marqueeLabel.maxX -= 1;
    if (_marqueeLabel.maxX <= 0) { // 当前信息跑完
        _count ++;
        _marqueeLabel.x = self.width - 41 - 38; // 回到最右边
        [self setMarqueeText:_marqueeTextArray[_count % self.marqueeTextArray.count]];
    }
}

/** 赋值跑马灯文本 */
- (void)setMarqueeText:(NSString *)marqueeText {
    _marqueeLabel.text = marqueeText;
    [_marqueeLabel sizeToFit];
    _marqueeLabel.centerY = self.height / 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

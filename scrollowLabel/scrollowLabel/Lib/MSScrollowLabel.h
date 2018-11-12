//
//  MSScrollowLabel.h
//  CloudClinic
//
//  Created by Jeffrey on 2018/11/12.
//  Copyright © 2018年 Jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MSScrollowLabel;

@protocol MSScrollowLabelDelegate <NSObject>

/** 跑马灯view上的详情点击时回调 */
- (void)scrollowLabelDidClick:(MSScrollowLabel *)scrollowLabel;

@optional
/** 跑马灯view上的关闭按钮点击时回调 */
- (void)labelView:(MSScrollowLabel *)scrollowLabel closeButtonDidClick:(UIButton *)sender;

@end

@interface MSScrollowLabel : UIView

/** 跑马灯展示的文本数组 */
@property (nonatomic, strong) NSArray *marqueeTextArray;

@property (nonatomic, weak) id <MSScrollowLabelDelegate> delegate;

@property (nonatomic, assign)BOOL clostButtonHidden;

@end

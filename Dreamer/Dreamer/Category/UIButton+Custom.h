//
//  UIButton+Custom.h
//  Sellermajunliang
//
//  Created by majunliang on 15/11/14.
//  Copyright © 2015年 majunliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)

+ (instancetype)buttonWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;
+ (instancetype)buttonWithFrame:(CGRect)frame image:(UIImage *)image forState:(UIControlState)state;
+ (instancetype)buttonWithFrame:(CGRect)frame backgroundImage:(UIImage *)image forState:(UIControlState)state;

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;


@end

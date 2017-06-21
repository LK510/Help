//
//  UITextField+extension.m
//  yinji
//
//  Created by 叶凤鸣 on 16/7/14.
//  Copyright © 2016年 印记. All rights reserved.
//

#import "UITextField+extension.h"

@implementation UITextField (extension)
- (void)textFieldWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = NO;
}

@end

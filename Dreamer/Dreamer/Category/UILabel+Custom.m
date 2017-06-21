//
//  UILabel+Custom.m
//  SellerDongPi
//
//  Created by majunliang on 14/11/25.
//  Copyright (c) 2014年 DongPi. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor
{
    self = [self initWithFrame:frame];
    if (self) {
        self.text = text;
        self.textColor = textColor;
    }
    return self;
}

@end

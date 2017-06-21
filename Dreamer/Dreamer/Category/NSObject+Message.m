//
//  NSObject+Message.m
//  biaoqian
//
//  Created by majunliang on 16/9/1.
//  Copyright © 2016年 cyb. All rights reserved.
//

#import "NSObject+Message.h"
#import <UIKit/UIKit.h>
#import "YJHUDMessage.h"
#import "UIView+nib.h"
#import "UIView+frame.h"
#import "SystemUtils.h"

//RGB值
#define COLORRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设置状态栏状态
#define SetStatusBarLight \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

#define SetStatusBarDefault \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];


//设备宽高
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height

static CGFloat contetHeight;
static UIView *_messageView;
@implementation NSObject (Message)

- (void) checkNet{
    
    if (![SystemUtils hasInternet]) {
        [[self showMessage:@"请检查网络设置！"] contetHeight:screenWidth];
        return;
    }

}

- (void)contetHeight:(CGFloat)height
{
    contetHeight = height;
    
    if (height) {
        _messageView.bottom = contetHeight - 93/2;
    }
}

- (UIViewController *) currentVc{
    return [self topViewController];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


- (instancetype)showMessage:(NSString *)message
{
	UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
	if (window.bottom == kScreenHeight) {
		YJHUDMessage *messageView = [YJHUDMessage loadFromNib];
		[window addSubview:messageView];
		messageView.backgroundColor = [UIColor whiteColor];
		messageView.layer.cornerRadius = 32/2.0;

		UIFont *font = [UIFont systemFontOfSize:15];
		messageView.message.text = message;
		messageView.message.font = font;
		messageView.backgroundColor = [UIColor colorWithRed:0.302 green:0.322 blue:0.325 alpha:1.000];
		_messageView = messageView;

		messageView.width = [self getLabelWidthWithText:message stringFont:font allowHeight:32]+32 ;

		messageView.bottom =  - 93/2;
		messageView.centerX = kScreenWidth/2.0;

		[UIView animateWithDuration:3 animations:^{
			messageView.alpha = 0;
		} completion:^(BOOL finished) {
			[messageView removeFromSuperview];
		}];

		return messageView;

	}else{
		return nil;
	}
}


- (CGFloat)getLabelWidthWithText:(NSString *)text stringFont:(UIFont *)font allowHeight:(CGFloat)height{
    CGFloat width;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(2000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    width = rect.size.width;
    return width;
}

@end

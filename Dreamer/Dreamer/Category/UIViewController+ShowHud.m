//
//  UIViewController+ShowHud.m
//  SellerDongPi
//
//  Created by majunliang on 14/12/22.
//  Copyright (c) 2014年 DongPi. All rights reserved.
//

#import "UIViewController+ShowHud.h"
#import "MBProgressHUD.h"

@implementation UIViewController (ShowHud)

- (UIWindow *)window
{
    return [UIApplication sharedApplication].keyWindow;
}

- (void)addProgressingViewWithMessage:(NSString *)msg
{

    if (!msg.length) {
        msg = @"请稍候";
    }
    
    if (!self.window) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.window];
    hud.userInteractionEnabled = NO;
    hud.labelText = msg;
    hud.tag = 111110;
    [hud show:YES];
    
    if (msg!=nil&&![msg isEqualToString:@""]) {
        [self.window addSubview:hud];
    }
    
}

- (void)addProgressingViewWithNoUserInterfaceMessage:(NSString *)msg
{
    
    if (!msg.length) {
        msg = @"请稍候";
    }
    
    if (!self.window) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.window];
    hud.userInteractionEnabled = YES;
    hud.labelText = msg;
    hud.tag = 111110;
    [hud show:YES];
    [self.window addSubview:hud];
}

- (void)removeProgressingView
{
    for (UIView *v in self.window.subviews) {
        if (v.tag == 111110) {
            MBProgressHUD *hud = (MBProgressHUD *)v;
            [hud hide:YES];
            [hud removeFromSuperview];
        }
    }
}

- (void)showTextOnly:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 15.f;
    hud.yOffset = -50.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

- (void)showTextOnly:(NSString *)text andDelay:(float)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 15.f;
    hud.yOffset = -50.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
}

- (void)showWithLabelMixed
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.tag = 111110;
    [self.window addSubview:HUD];
    HUD.labelText = @"连接中";
    [HUD show:YES];
}

- (void)myMixedTask:(NSProgress *)uploadProgress
{
    MBProgressHUD *HUD = nil;
    for (UIView *v in self.window.subviews) {
        if (v.tag == 111110) {
            HUD = (MBProgressHUD *)v;
            break;
        }
    }

    // Switch to determinate mode
    float progress = uploadProgress.fractionCompleted;
    if (progress < 1.0f) {
        HUD.mode = MBProgressHUDModeDeterminate;
        HUD.labelText = [NSString stringWithFormat:@"%d%%",(int)progress*100];
        HUD.progress = progress;
    }
    else {
        // Back to indeterminate mode
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"服务器处理中";
    }
}


@end

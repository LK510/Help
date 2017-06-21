//
//  YJNavagaViewController.m
//  yinji
//
//  Created by majunliang on 16/9/7.
//  Copyright © 2016年 印记. All rights reserved.
//

#import "YJNavagaViewController.h"

@interface YJNavagaViewController ()<UIGestureRecognizerDelegate>

@end

@implementation YJNavagaViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
    self.navigationBar.hidden = YES;
}
//设置是否允许返回手势
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count <=1) {
        return NO;
    }
    return YES;
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeProgressingView];
}
@end

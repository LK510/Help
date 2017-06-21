//
//  NavBarView.h
//  yinji
//
//  Created by lufei on 16/8/26.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavBarView;
@protocol NavBarViewDelegate <NSObject>

- (void) navBarView:(NavBarView *)navBarView;

@optional
- (void) saveWithNavBarView:(NavBarView *)navBarView;

@end


@interface NavBarView : UIView

@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,strong) UILabel *titleLab;

@property (nonatomic,weak) id <NavBarViewDelegate> delagate;
- (instancetype)initWithFrame:(CGRect)frame LeftImageName:(NSString *)imageName vcName:(NSString *)vcName andRightImageName:(NSString *)rightImageName;

@end

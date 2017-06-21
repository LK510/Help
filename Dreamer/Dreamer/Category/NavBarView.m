//
//  NavBarView.m
//  yinji
//
//  Created by lufei on 16/8/26.
//  Copyright © 2016年 印记. All rights reserved.
//

#import "NavBarView.h"

@interface NavBarView ()

@end

@implementation NavBarView

- (instancetype)initWithFrame:(CGRect)frame LeftImageName:(NSString *)leftImageName vcName:(NSString *)vcName andRightImageName:(NSString *)rightImageName{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0x80bff5);
        
        //leftbtn
        UIButton *backBtn = [UIButton buttonWithFrame:CGRectMake(0, 20, 44, 44) image:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        //rightBtn
        UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 54, 20, 44, 44)];
        saveBtn.titleLabel.font =  [UIFont systemFontOfSize:15];
        [saveBtn setTitle:rightImageName forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        
        self.saveBtn = saveBtn;
        
        //titleLab
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - 100, 20, 200, 44) text:vcName textColor:COLORRGB(224, 232, 237)];
        titleLab.font = [UIFont systemFontOfSize:18];
        titleLab.textAlignment = NSTextAlignmentCenter;
		_titleLab = titleLab;
        
        [self addSubview:backBtn];
        [self addSubview:saveBtn];
        [self addSubview:titleLab];
        
    }
    return self;
}

- (void) back{

    if ([self.delagate respondsToSelector:@selector(navBarView:)]) {
        [self.delagate navBarView:self];
    }
}

- (void) save{
    
    if ([self.delagate respondsToSelector:@selector(saveWithNavBarView:)]) {
        [self.delagate saveWithNavBarView:self];
    }
}

@end

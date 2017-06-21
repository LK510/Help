//
//  LoginRegisterViewController.m
//  yinji
//
//  Created by yinji_02 on 16/7/13.
//  Copyright © 2016年 印记. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SystemUtils.h"
#import "CocoaSecurity.h"
#import "PhoneNumRegisterViewController.h"

@interface LoginRegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UILabel *wrongTip;
@property (weak, nonatomic) IBOutlet UIButton *hiddenBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic,readonly,strong) NSString *name;
@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UILabel *line2;
@property (weak, nonatomic) IBOutlet UILabel *line3;
@property (weak, nonatomic) IBOutlet UIButton *weixin;
@property (weak, nonatomic) IBOutlet UIButton *qq;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDistance;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoHeight;

@property (weak, nonatomic) IBOutlet UILabel *logTitle;
@property (nonatomic,strong) NSString *accessToken;

@end

@implementation LoginRegisterViewController

- (IBAction)qqLogClick:(id)sender {
    
    //...
}

- (IBAction)weixinLog:(id)sender {
    
   //...
}
- (IBAction)clear:(id)sender {
    self.phoneNumTF.text = nil;
}

- (IBAction)loginBtn:(id)sender {
    
    if (![SystemUtils hasInternet]) {
        
        [[self showMessage:@"请检查网络设置！"] contetHeight:screenWidth];
        
    }else{
    
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userPwd = [CocoaSecurity md5:self.passwordTF.text].hexLower;
        NSString *userName = [self.phoneNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        userInfo.userName = userName;
        
        [self addProgressingViewWithMessage:@"登录中..."];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            BOOL isSuccess = [ModuleNetManager userLogIn:userInfo];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [self removeProgressingView];
//                
//                if (isSuccess) {
//                    
//                    NSString *preAccount = self.phoneNumTF.text.copy;
//
//                    if (![self.preAccounts containsObject: self.phoneNumTF.text]) {
//                        for (NSString *subStr in self.preAccounts) {
//                            preAccount = [preAccount stringByAppendingFormat:@"+%@",subStr];
//                        }
//                        
//                        [[NSUserDefaults standardUserDefaults] setObject:preAccount forKey:@"preaccount"];
//                    }
//                    
//                    [[ModuleUserManager getInstance] loginSuccess:userInfo];
//                    [self.view endEditing:YES];
//                    [noticecenter postNotificationName:@"initVc" object:nil];
//                    
//                } else {
//                    self.wrongTip.text = userInfo.errorMsg;
//                    self.phoneNumTF.layer.borderColor = COLORRGB(241, 104, 104).CGColor;
//                }
//                
//            });
//        });
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumTF){
        [self.passwordTF becomeFirstResponder];
    }else{
        if (self.phoneNumTF.text.length&&self.passwordTF.text.length) {
            [self loginBtn:self.loginBtn];
        }
        [self.view endEditing:YES];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.logoHeight.constant = 90;
}

- (IBAction)hiddenBtnDidClick:(id)sender {
    
    if (self.passwordTF.secureTextEntry) {
        
        self.passwordTF.secureTextEntry = NO;
        [self.hiddenBtn setImage:[UIImage imageNamed:@"btn_password_display"] forState:UIControlStateNormal];

    }else{
    
        self.passwordTF.secureTextEntry = YES;
        [self.hiddenBtn setImage:[UIImage imageNamed:@"btn_password_hidden"] forState:UIControlStateNormal];
    }
}

// 判断手机号是否正确
- (BOOL)isPhoneNum {
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:self.phoneNumTF.text];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:self.phoneNumTF.text];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:self.phoneNumTF.text];
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
//    if (screenWidth == 320) {
//        self.leftDistance.constant = 90;
//        self.rightDistance.constant = 90;
//    }
//    if (![WXApi isWXAppInstalled]){
//    
//        [self.weixin setHidden:YES];
//        self.leftDistance.constant = screenWidth/2-24;
//    }
//    if (![TencentOAuth iphoneQQInstalled]) {
//        [self.qq setHidden:YES];
//        self.rightDistance.constant = screenWidth/2-24;
//    }
//    if (![TencentOAuth iphoneQQInstalled]&&![WXApi isWXAppInstalled]) {
//        self.line1.hidden = YES;
//        self.line2.hidden = YES;
//        self.line3.hidden = YES;
//    }
//    
//    [[ModuleUserManager getInstance] loginOut];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    
}

-(void)setup{

    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    UIColor *heightColor = COLORRGB(82, 160, 226);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [heightColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.loginBtn setBackgroundImage:theImage forState:UIControlStateHighlighted];
    
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(self.phoneNumTF.frame.origin.x,self.phoneNumTF.frame.origin.y,5.0, self.phoneNumTF.frame.size.height)];
    UIView *blankView1 = [[UIView alloc] initWithFrame:CGRectMake(self.passwordTF.frame.origin.x,self.passwordTF.frame.origin.y,5.0, self.passwordTF.frame.size.height)];
    self.phoneNumTF.leftView = blankView;
    self.passwordTF.leftView = blankView1;
    self.passwordTF.leftViewMode =UITextFieldViewModeAlways;
    self.phoneNumTF.leftViewMode =UITextFieldViewModeAlways;
    
    [self.hiddenBtn setImage:[UIImage imageNamed:@"btn_password_hidden"] forState:UIControlStateNormal];
    [self.phoneNumTF textFieldWithCornerRadius:5 borderWidth:1 borderColor:[UIColor clearColor]];
    [self.passwordTF textFieldWithCornerRadius:5 borderWidth:1 borderColor:[UIColor clearColor]];
    self.loginBtn.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

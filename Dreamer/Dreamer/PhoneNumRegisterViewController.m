//
//  PhoneNumRegisterViewController.m
//  yinji
//
//  Created by yinji_02 on 16/7/13.
//  Copyright © 2016年 印记. All rights reserved.
//

#import "PhoneNumRegisterViewController.h"
#import "UITextField+extension.h"
#import "CocoaSecurity.h"
#import "UIButton+Custom.h"

#define loginURL @"http://api.anybeen.com/index.php"

@interface PhoneNumRegisterViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *messageKeyTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *getKeyNum;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *registerLabel;
@property (weak, nonatomic) IBOutlet UIButton *hiddenBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UIButton *mailRegister;
@property (weak, nonatomic) IBOutlet UILabel *userTipLab;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) int time;
@property (nonatomic,assign) BOOL isSuccess;

@end

@implementation PhoneNumRegisterViewController

- (IBAction)hiddenBtn:(id)sender {
    if (self.passWordTF.secureTextEntry) {
        
        self.passWordTF.secureTextEntry = NO;
        [self.hiddenBtn setImage:[UIImage imageNamed:@"btn_password_display"] forState:UIControlStateNormal];
    }else{
        
        self.passWordTF.secureTextEntry = YES;
        [self.hiddenBtn setImage:[UIImage imageNamed:@"btn_password_hidden"] forState:UIControlStateNormal];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)phoneNumChanged:(id)sender {

    if (self.phoneNumTF.text.length == 11) {
        self.getKeyNum.userInteractionEnabled = YES;
        self.getKeyNum.backgroundColor = COLORRGB(89, 172, 243);
        [self.getKeyNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.getKeyNum.backgroundColor = COLORRGB(48, 59, 100);
        self.getKeyNum.userInteractionEnabled = NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    textField.placeholder.accessibilityElementsHidden = NO;
    [textField setValue:COLORRGB(255, 255, 255) forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField setValue:[UIColor clearColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder.accessibilityElementsHidden = YES;
}

-(NSTimer *)timer{
    
    if (_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    return _timer;
}

-(void)updateTimer{
    
    [self.getKeyNum setTitle:[NSString stringWithFormat:@"(%zd)s",self.time] forState:UIControlStateNormal];
    self.time--;
    
    if (self.time == 0) {
        self.time = 5;
        [self.timer invalidate];
        self.timer = nil;
        [self.getKeyNum setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

- (IBAction)getKeyNumDidClick:(id)sender {

    if ([self isPhoneNum]) {
        
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.mobile = self.phoneNumTF.text;
        
        if (self.isSuccess) {
            self.tipLab.text = @"获取验证码成功";
            if (self.count < 6) {
                [self.getKeyNum startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:COLORRGB(89,172,243) countColor:COLORRGB(89,172,243)];
                self.count ++;
            }
        }else{
            self.tipLab.text = userInfo.errorMsg;
        }
    }else{
        self.tipLab.text = @"手机号格式错误";
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

- (IBAction)clear:(id)sender {
    self.phoneNumTF.text = nil;
}

- (IBAction)phoneNumRegister:(id)sender {
    
    if (self.phoneNumTF.text.length&&self.passWordTF.text.length&&self.messageKeyTF.text.length) {
        
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userName = @"lufei001";
        userInfo.mobile = self.phoneNumTF.text;
        userInfo.userPwd = [CocoaSecurity md5:self.passWordTF.text].hexLower;

        [ModuleNetManager userLogIn:userInfo];
        
    }else{
        if (self.phoneNumTF.text.length == 0) {
            self.tipLab.text = @"手机号不能为空";
        }else if (self.passWordTF.text.length == 0){
            self.tipLab.text = @"密码不能为空";
        }else{
            self.tipLab.text = @"验证码不能为空";
        }
    }
}

- (IBAction)backLogin:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
        
    if ([self.identifier isEqualToString:@"resetByPhoneNum"]) {
        self.registerLabel.text = @"手机密码重置";
        self.userTipLab.hidden = YES;
        [self.mailRegister setHidden:YES];
        [self.registerBtn setTitle:@"密码重置" forState:UIControlStateNormal];
    }
    if (screenWidth == 320) {
        self.passWordTF.placeholder = @"密码至少6位,字母/数字/下划线";
    }
}

-(void)setup{
    
    self.time = 30;
    
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(self.phoneNumTF.frame.origin.x,self.phoneNumTF.frame.origin.y,5.0, self.phoneNumTF.frame.size.height)];
    UIView *blankView1 = [[UIView alloc] initWithFrame:CGRectMake(self.passWordTF.frame.origin.x,self.passWordTF.frame.origin.y,5.0, self.passWordTF.frame.size.height)];
    UIView *blankView2 = [[UIView alloc] initWithFrame:CGRectMake(self.messageKeyTF.frame.origin.x,self.messageKeyTF.frame.origin.y,5.0, self.messageKeyTF.frame.size.height)];
    self.phoneNumTF.leftView = blankView;
    self.passWordTF.leftView = blankView1;
    self.messageKeyTF.leftView = blankView2;
    self.messageKeyTF.leftViewMode =UITextFieldViewModeAlways;
    self.passWordTF.leftViewMode =UITextFieldViewModeAlways;
    self.phoneNumTF.leftViewMode =UITextFieldViewModeAlways;
    
    self.getKeyNum.layer.cornerRadius = 5;
//    self.getKeyNum.userInteractionEnabled = NO;
    self.getKeyNum.layer.borderWidth = 1;
    self.getKeyNum.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.phoneNumTF textFieldWithCornerRadius:5 borderWidth:0 borderColor:[UIColor clearColor]];
    [self.messageKeyTF textFieldWithCornerRadius:5 borderWidth:0 borderColor:[UIColor clearColor]];
    [self.passWordTF textFieldWithCornerRadius:5 borderWidth:0 borderColor:[UIColor clearColor]];
    self.registerBtn.layer.cornerRadius = 5;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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

@interface LoginRegisterViewController ()<UITextFieldDelegate,TencentSessionDelegate,UITableViewDelegate,UITableViewDataSource>

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

@property (nonatomic,strong) TencentOAuth *tencentOAuth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDistance;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoHeight;

@property (weak, nonatomic) IBOutlet UILabel *logTitle;
@property (nonatomic,strong) NSString *accessToken;

@property (nonatomic,strong) UITableView *usedAccountTableView;
@property (nonatomic,strong) NSMutableArray *preAccounts;

@end

@implementation LoginRegisterViewController

- (NSMutableArray *) preAccounts{
    
    if (_preAccounts == nil) {
        NSString *preAccount = [[NSUserDefaults standardUserDefaults] objectForKey:@"preaccount"];
        NSArray *arr = [preAccount componentsSeparatedByString:@"+"];
        _preAccounts = [NSMutableArray arrayWithArray:arr];
    }
    return _preAccounts;
}

- (UITableView *) usedAccountTableView{
    
    if (_usedAccountTableView == nil) {
        
        NSInteger count = self.preAccounts.count;
        if (count > 3) {
            count = 3;
        }
        _usedAccountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 30*count) style:UITableViewStylePlain];
        
        _usedAccountTableView.top = self.phoneNumTF.bottom;
        _usedAccountTableView.left = self.phoneNumTF.left;
        _usedAccountTableView.width = self.phoneNumTF.width;
        
        _usedAccountTableView.delegate = self;
        _usedAccountTableView.dataSource = self;
    }
    
    return _usedAccountTableView;
}

// 获取用户信息
- (void)getUserInfoResponse:(APIResponse *)response {
    
    if (response && response.retCode == URLREQUEST_SUCCEED) {
        
        NSDictionary *userInfo = [response jsonResponse];
        NSString *nickName = userInfo[@"nickname"];
        
        // 后续操作...
        UserInfo *info = [[UserInfo alloc] init];
        
        NSString *accessToken = self.tencentOAuth.accessToken;
        NSString *urlStr=[NSString stringWithFormat:@"https://graph.qq.com/oauth2.0/me?access_token=%@&unionid=1",accessToken];
        NSURL *url=[NSURL URLWithString:urlStr];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray *arr = [str componentsSeparatedByString:@","];
        NSString *allUnionId = arr[2];
        NSArray *unionArr = [allUnionId componentsSeparatedByString:@":"];
        NSString *unionid = unionArr[1];
        
        NSMutableString *str1 = [NSMutableString stringWithString:unionid];
        for (int i = 0; i < str1.length; i++) {
            unichar c = [str1 characterAtIndex:i];
            NSRange range = NSMakeRange(i, 1);
            if (c == '}' || c == ')'|| c == ' '|| c == '"'|| c == ';'|| c == '\n') {
                [str1 deleteCharactersInRange:range];
                --i;
            }
        }
        NSString *unionId = [NSString stringWithString:str1];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            BOOL isSuccess = [ModuleNetManager qqLogIn:info :self.tencentOAuth.openId :unionId :userInfo];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self removeProgressingView];

                if (isSuccess) {
                    //登录状态
                    self.wrongTip.text = @"登录成功";
                    [noticecenter postNotificationName:@"initVc" object:nil];
                    
                } else {
                    self.wrongTip.text = info.errorMsg;
                    self.phoneNumTF.layer.borderColor = COLORRGB(241, 104, 104).CGColor;
                }
                
            });
            
        });
   
    } else {
        NSLog(@"QQ auth fail ,getUserInfoResponse:%d", response.detailRetCode);
    }
}

//登录成功：
- (void)tencentDidLogin{
    if (_tencentOAuth.accessToken.length > 0) {
        // 获取用户信息
        [self addProgressingViewWithMessage:@"登录中..."];
        [_tencentOAuth getUserInfo];
        
    } else {
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}

- (void) tencentDidNotNetWork{

}

//非网络错误导致登录失败：
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        NSLog(@"用户取消登录");
    } else {
        NSLog(@"登录失败");
    }
}
- (IBAction)qqLogClick:(id)sender {
    
    NSString *qqAppId = kQQappId;
    if (![mainstyle isEqualToString:@"note"]) {
        qqAppId = kDiaryQQappId;
    }
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:qqAppId andDelegate:self];
    NSArray *permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    
    [self.tencentOAuth authorize:permissions];
}

- (IBAction)weixinLog:(id)sender {
    
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = mainstyle;
        [WXApi sendReq:req];
    }
}
- (IBAction)clear:(id)sender {
    self.phoneNumTF.text = nil;
}
- (IBAction)registerClick:(id)sender {
    
    PhoneNumRegisterViewController *registerVc = [logSb instantiateViewControllerWithIdentifier:@"resetByPhoneNum"];
    registerVc.identifier = @"register";
    [self.navigationController pushViewController:registerVc animated:YES];
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
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            BOOL isSuccess = [ModuleNetManager userLogIn:userInfo];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self removeProgressingView];
                
                if (isSuccess) {
                    
                    NSString *preAccount = self.phoneNumTF.text.copy;

                    if (![self.preAccounts containsObject: self.phoneNumTF.text]) {
                        for (NSString *subStr in self.preAccounts) {
                            preAccount = [preAccount stringByAppendingFormat:@"+%@",subStr];
                        }
                        
                        [[NSUserDefaults standardUserDefaults] setObject:preAccount forKey:@"preaccount"];
                    }
                    
                    [[ModuleUserManager getInstance] loginSuccess:userInfo];
                    [self.view endEditing:YES];
                    [noticecenter postNotificationName:@"initVc" object:nil];
                    
                } else {
                    self.wrongTip.text = userInfo.errorMsg;
                    self.phoneNumTF.layer.borderColor = COLORRGB(241, 104, 104).CGColor;
                }
                
            });
        });
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumTF){
        [self.passwordTF becomeFirstResponder];
        [self.usedAccountTableView removeFromSuperview];
    }else{
        if (self.phoneNumTF.text.length&&self.passwordTF.text.length) {
            [self loginBtn:self.loginBtn];
        }
        [self.view endEditing:YES];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.logoHeight.constant = 0;
    
    [self.view layoutIfNeeded];
    
    if (textField == self.phoneNumTF) {
        
        [self updateTableView:nil];
    }
    if (textField == self.passwordTF) {
        
        self.usedAccountTableView.hidden = YES;
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.logoHeight.constant = 90;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == self.phoneNumTF) {
    
        NSString *tempStr;
        if ([string isEqualToString:@""]) {
            tempStr = [textField.text substringToIndex:textField.text.length-1];
        }else{
            tempStr = [textField.text stringByAppendingString:string];
        }
        
        [self updateTableView:tempStr];
    }
    
    return YES;
    
}

- (void) updateTableView:(NSString *)tempStr {
    
    NSString *preAccount = [[NSUserDefaults standardUserDefaults] objectForKey:@"preaccount"];

    if (tempStr == nil) {
        
        if (preAccount == nil) {
            
            preAccount = [[NSString alloc] init];
            [[NSUserDefaults standardUserDefaults] setObject:preAccount forKey:@"preaccount"];
            
        }else{
            
            if (![preAccount isEqualToString:@""]) {
                [self.view addSubview:self.usedAccountTableView];
                self.usedAccountTableView.hidden = NO;
                [self.usedAccountTableView reloadData];
                
            }
            
        }
        
    }else{
        
        [self.preAccounts removeAllObjects];

        NSString *preAccount = [[NSUserDefaults standardUserDefaults] objectForKey:@"preaccount"];
        NSArray *arr = [preAccount componentsSeparatedByString:@"+"];

        for (NSString *subStr in arr) {
            if ([subStr containsString:tempStr]) {
                [self.preAccounts addObject:subStr];
            }
        }

        NSInteger count = self.preAccounts.count;
        if (count > 3) {
            count = 3;
        }
        self.usedAccountTableView.height = count*30;
        if (!self.preAccounts.count) {
            self.usedAccountTableView.hidden = YES;
        }else{
            self.usedAccountTableView.hidden = NO;
            [self.usedAccountTableView reloadData];
        }
        
    }

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.preAccounts.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"account"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.preAccounts[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.phoneNumTF.text = self.preAccounts[indexPath.row];
    [self.usedAccountTableView removeFromSuperview];
    [self.passwordTF becomeFirstResponder];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
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
    self.usedAccountTableView.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (screenWidth == 320) {
        self.leftDistance.constant = 90;
        self.rightDistance.constant = 90;
    }
    if (![WXApi isWXAppInstalled]){
    
        [self.weixin setHidden:YES];
        self.leftDistance.constant = screenWidth/2-24;
    }
    if (![TencentOAuth iphoneQQInstalled]) {
        [self.qq setHidden:YES];
        self.rightDistance.constant = screenWidth/2-24;
    }
    if (![TencentOAuth iphoneQQInstalled]&&![WXApi isWXAppInstalled]) {
        self.line1.hidden = YES;
        self.line2.hidden = YES;
        self.line3.hidden = YES;
    }
    
    [[ModuleUserManager getInstance] loginOut];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    
}

-(void)setup{

    self.logTitle.text = generalstyle;

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

//
//  UserInfo.m
//  yinji
//
//  Created by 印记 on 16/6/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfo.h"

@implementation UserInfo
 

-(instancetype) init{
    UserInfo* ui = [super init];
    if (ui) {
        //to do for init
        _userId = @"";
        _userName = @"";
        _userPwd = @"";
        _userPwdNew = @"";
        _secKey = @"";
        _email = @"";
        _mobile = @"";
        _userEmail = @"";
        _userwx = @"";
        _userqq = @"";
        
        _nickName = @"";
        _intro = @"";
        _icon = @"";
        
        _errorMsg = @"";
        
        _friendUpdateTime = 0;
        
        _minVersion = 0;
        _maxVersion = 0;
        
        _syncTime = @"";
        _registerType = 0;
        
        _gestrue = @"";
        
        _bookKey = @"";
        
        _defaultBookId = @"";
                
    }
    
    return ui;
}

-(BOOL) readLoginDiction:(NSDictionary*) dic{
    
    if (dic==nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return false;
    }
    
    NSString* userId = [dic valueForKey:@"uid"];
    if (userId!=nil && [userId isKindOfClass:[NSString class]]) {
        _userId = userId;
    }
    
    NSString* userName = [dic valueForKey:@"loginname"];
    if (userName!=nil && [userName isKindOfClass:[NSString class]]) {
        _userName = userName;
    }
    
    NSString* email = [dic valueForKey:@"email"];
    if (email!=nil && [email isKindOfClass:[NSString class]]) {
        _email = email;
    }
    
    NSString* nickName = [dic valueForKey:@"nickname"];
    if (nickName!=nil && [nickName isKindOfClass:[NSString class]]) {
        _nickName = nickName;
    }
    
    NSString* password = [dic valueForKey:@"password"];
    if (password!=nil && [password isKindOfClass:[NSString class]]) {
        _userPwd = password;
    }

    NSString* mobile = [dic valueForKey:@"mobile"];
    if (mobile!=nil && [mobile isKindOfClass:[NSString class]]) {
        _mobile = mobile;
    }

    NSString* usersign = [dic valueForKey:@"usersign"];
    if (usersign!=nil && [usersign isKindOfClass:[NSString class]]) {
        _secKey = usersign;
    }
    
    NSString* userwx = [dic valueForKey:@"userwx"];
    if (userwx!=nil && [userwx isKindOfClass:[NSString class]]) {
        _userwx = userwx;
    }
    
    NSString* useremail = [dic valueForKey:@"useremail"];
    if (useremail!=nil && [useremail isKindOfClass:[NSString class]]) {
        _userEmail = useremail;
    }
    
    NSString* userqq = [dic valueForKey:@"userqq"];
    if (userqq!=nil && [userqq isKindOfClass:[NSString class]]) {
        _userqq = userqq;
    }

    id registerType = [dic valueForKey:@"registerType"];
    if (registerType!=nil && [registerType isKindOfClass:[NSString class]]) {
        int rtype = [registerType intValue];
        _registerType = rtype;
    }
    
    return true;
}

-(BOOL) readRegisterDiction:(NSDictionary*) dic{
    
    if (dic==nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return false;
    }
    
    NSString* userId = [dic valueForKey:@"uid"];
    if (userId!=nil && [userId isKindOfClass:[NSString class]]) {
        _userId = userId;
    }
    
    NSString* userName = [dic valueForKey:@"loginname"];
    if (userName!=nil && [userName isKindOfClass:[NSString class]]) {
        _userName = userName;
    }
    
    NSString* email = [dic valueForKey:@"username"];
    if (email!=nil && [email isKindOfClass:[NSString class]]) {
        _email = email;
    }
    
    NSString* nickName = [dic valueForKey:@"nickname"];
    if (nickName!=nil && [nickName isKindOfClass:[NSString class]]) {
        _nickName = nickName;
    }
    
    NSString* password = [dic valueForKey:@"password"];
    if (password!=nil && [password isKindOfClass:[NSString class]]) {
        _userPwd = password;
    }
    
    NSString* mobile = [dic valueForKey:@"mobile"];
    if (mobile!=nil && [mobile isKindOfClass:[NSString class]]) {
        _mobile = mobile;
    }
    
    NSString* usersign = [dic valueForKey:@"usersign"];
    if (usersign!=nil && [usersign isKindOfClass:[NSString class]]) {
        _secKey = usersign;
    }
    
    NSString* userwx = [dic valueForKey:@"userwx"];
    if (userwx!=nil && [userwx isKindOfClass:[NSString class]]) {
        _userwx = userwx;
    }
    
    NSString* useremail = [dic valueForKey:@"useremail"];
    if (useremail!=nil && [useremail isKindOfClass:[NSString class]]) {
        _userEmail = useremail;
    }
    
    NSString* userqq = [dic valueForKey:@"userqq"];
    if (userqq!=nil && [userqq isKindOfClass:[NSString class]]) {
        _userqq = userqq;
    }
    
    id registerType = [dic valueForKey:@"registerType"];
    if (registerType!=nil && [registerType isKindOfClass:[NSString class]]) {
        int rtype = [registerType intValue];
        _registerType = rtype;
    }
    
    return true;
}

-(BOOL) readModifyDiction:(NSDictionary*) dic{
    
    if (dic==nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return false;
    }
    
    NSString* userId = [dic valueForKey:@"uid"];
    if (userId!=nil && [userId isKindOfClass:[NSString class]]) {
        _userId = userId;
    }
    
    NSString* userName = [dic valueForKey:@"loginname"];
    if (userName!=nil && [userName isKindOfClass:[NSString class]]) {
        _userName = userName;
    }
    
    NSString* email = [dic valueForKey:@"username"];
    if (email!=nil && [email isKindOfClass:[NSString class]]) {
        _email = email;
    }
    
    NSString* nickName = [dic valueForKey:@"nickname"];
    if (nickName!=nil && [nickName isKindOfClass:[NSString class]]) {
        _nickName = nickName;
    }
    
    NSString* password = [dic valueForKey:@"password"];
    if (password!=nil && [password isKindOfClass:[NSString class]]) {
        _userPwd = password;
    }
    
    NSString* mobile = [dic valueForKey:@"mobile"];
    if (mobile!=nil && [mobile isKindOfClass:[NSString class]]) {
        _mobile = mobile;
    }
    
    NSString* usersign = [dic valueForKey:@"usersign"];
    if (usersign!=nil && [usersign isKindOfClass:[NSString class]]) {
        _secKey = usersign;
    }
    
    id registerType = [dic valueForKey:@"registerType"];
    if (registerType!=nil && [registerType isKindOfClass:[NSString class]]) {
        int rtype = [registerType intValue];
        _registerType = rtype;
    }
    
    
    return true;
}

-(BOOL) readInfoDiction:(NSDictionary*) dic{
    
    if (dic==nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return false;
    }

    NSString* nickName = [dic valueForKey:@"nickname"];
    if (nickName!=nil && [nickName isKindOfClass:[NSString class]]) {
        _nickName = nickName;
    }
    
    NSString* email = [dic valueForKey:@"email"];
    if (email!=nil && [email isKindOfClass:[NSString class]]) {
        _email = email;
    }
   
    NSString* mobile = [dic valueForKey:@"mobile"];
    if (mobile!=nil && [mobile isKindOfClass:[NSString class]]) {
        _mobile = mobile;
    }
    
    NSString* useremail = [dic valueForKey:@"useremail"];
    if (useremail!=nil && [useremail isKindOfClass:[NSString class]]) {
        _userEmail = useremail;
    }
    
    NSString* userwx = [dic valueForKey:@"userwx"];
    if (userwx!=nil && [userwx isKindOfClass:[NSString class]]) {
        _userwx = userwx;
    }
    
    NSString* userqq = [dic valueForKey:@"userqq"];
    if (userqq!=nil && [userqq isKindOfClass:[NSString class]]) {
        _userqq = userqq;
    }
    
    NSString* usersign = [dic valueForKey:@"usersign"];
    if (usersign!=nil && [usersign isKindOfClass:[NSString class]]) {
        _secKey = usersign;
    }
    
    id registerType = [dic valueForKey:@"registerType"];
    if (registerType!=nil && [registerType isKindOfClass:[NSString class]]) {
        int rtype = [registerType intValue];
        _registerType = rtype;
    }
    
    return true;
}


@end

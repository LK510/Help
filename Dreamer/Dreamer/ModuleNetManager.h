//
//  ModuleNetManager.h
//  yinji
//
//  Created by 印记 on 16/7/13.
//  Copyright © 2016年 印记. All rights reserved.
//

@interface ModuleNetManager : NSObject
 
//用户帐号登录
+(BOOL) userLogIn:(UserInfo*) userInfo;

//用户注册
+(BOOL) userRegister:(UserInfo*) userInfo;

//获取验证码
+(BOOL) getCheckNum:(UserInfo *)userInfo;

@end


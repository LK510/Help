//
//  UserInfo.h
//  yinji
//
//  Created by 印记 on 16/6/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#ifndef UserInfo_h
#define UserInfo_h

/**
 *  用户信息
 */
@interface UserInfo : NSObject
{

}

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* userPwd;
@property (nonatomic, copy) NSString* userPwdNew;
@property (nonatomic, copy) NSString* secKey;
@property (nonatomic, copy) NSString* email;

@property (nonatomic, copy) NSString* mobile;
@property (nonatomic, copy) NSString* userEmail;
@property (nonatomic, copy) NSString* userwx;
@property (nonatomic, copy) NSString* userqq;

@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* intro;
@property (nonatomic, copy) NSString* icon;

@property (nonatomic, copy) NSString* errorMsg;

@property (nonatomic, assign) long  friendUpdateTime;

@property (nonatomic, assign) long minVersion;
@property (nonatomic, assign) long maxVersion;

@property (nonatomic, copy) NSString* syncTime;
@property int registerType;

@property (nonatomic, copy) NSString* gestrue;

@property (nonatomic, copy) NSString* bookKey;
@property (nonatomic, copy) NSString* defaultBookId;

-(instancetype) init;
-(BOOL) readLoginDiction:(NSDictionary*) dic;
-(BOOL) readRegisterDiction:(NSDictionary*) dic;
-(BOOL) readModifyDiction:(NSDictionary*) dic;
-(BOOL) readInfoDiction:(NSDictionary*) dic;

@end

#endif /* UserInfo_h */

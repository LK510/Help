//
//  ModuleNetManager.m
//  yinji
//
//  Created by 印记 on 16/7/13.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleNetManager.h"

@implementation ModuleNetManager

+(BOOL) getCheckNum:(UserInfo *)userInfo{

	if (userInfo == nil) {
		return false;
	}

	NSMutableDictionary* paramMap = [[NSMutableDictionary alloc] init];

	[paramMap setValue:userInfo.mobile forKey:@"mobile"];
	[paramMap setValue:[TimeUtils currentTimeStampStr] forKey:@"time"];
	[paramMap setValue:@"mobile_reg" forKey:@"method"];


	NSData* secData = [HttpSecUtil getEncryptHttpParam:paramMap];

	HttpRequest* httpRequest = [[HttpRequest alloc] init];
	NSData* response = [httpRequest sendDataByHttpPost :HELP_SERVER_API_URL:secData];

	if (response != nil) {
		NSError* error;
		NSDictionary* resDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
		NSDictionary* dataDic = [resDic valueForKey:@"data"];
		if (dataDic != nil && [dataDic isKindOfClass:[NSDictionary class]]) {

			[userInfo readLoginDiction:dataDic];

		}else{
			userInfo.errorMsg = [resDic valueForKey:@"msg"];
			return false;
		}

	}

	return true;

}

+(BOOL) userLogIn:(UserInfo*) userInfo{

	if (userInfo==nil) {
		return false;
	}

	NSMutableDictionary* paramMap = [[NSMutableDictionary alloc] init];
	[paramMap setValue:userInfo.userName forKey:@"username"];
	[paramMap setValue:userInfo.userPwd forKey:@"password"];
	[paramMap setValue:[TimeUtils currentTimeStampStr] forKey:@"time"];
	[paramMap setValue:@"all" forKey:@"act"];
	[paramMap setValue:@"login" forKey:@"method"];


	NSData* secData = [HttpSecUtil getEncryptHttpParam:paramMap];

	HttpRequest* httpRequest = [[HttpRequest alloc] init];
	NSData* response = [httpRequest sendDataByHttpPost :HELP_SERVER_API_URL:secData];

	if (response != nil) {
		NSError* error;
		NSDictionary* resDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
		NSDictionary* dataDic = [resDic valueForKey:@"data"];
		if (dataDic != nil && [dataDic isKindOfClass:[NSDictionary class]]) {

			[userInfo readLoginDiction:dataDic];
			return true;
		}else{
			userInfo.errorMsg = [resDic valueForKey:@"msg"];
		}
	}
	return false;
}

+(BOOL) userRegister:(UserInfo*) userInfo{

	if (userInfo==nil) {
		return false;
	}

	NSMutableDictionary* paramMap = [[NSMutableDictionary alloc] init];
	[paramMap setValue:userInfo.userName forKey:@"username"];
	[paramMap setValue:userInfo.userPwd forKey:@"password"];
	[paramMap setValue:@"register" forKey:@"action"];

	NSData* secData = [HttpSecUtil getEncryptHttpParam:paramMap];

	HttpRequest* httpRequest = [[HttpRequest alloc] init];
	NSData* response = [httpRequest sendDataByHttpPost :HELP_SERVER_API_URL:secData];

	if (response != nil) {
		NSError* error;
		NSDictionary* resDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
		NSDictionary* dataDic = [resDic valueForKey:@"data"];
		if (dataDic != nil && [dataDic isKindOfClass:[NSDictionary class]]) {

			[userInfo readRegisterDiction:dataDic];

		}else{
			userInfo.errorMsg = [resDic valueForKey:@"msg"];
			return false;
		}

	}

	return true;
}

@end

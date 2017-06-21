//
//  SystemUtils.h
//  yinji
//
//  Created by 印记 on 16/6/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#ifndef SystemUtils_h
#define SystemUtils_h

@interface SystemUtils : NSObject
 
+(BOOL) hasInternet;
+(BOOL) hasWifi;
+(NSString*) getBundleName;
+(NSString*) getAppVersion;
+(NSString*) getSystemVersion;
+(NSString*) getPhoneModel;
+(NSString*) getLocalPhoneModel;

+ (CGFloat) pointToPixel:(CGFloat)point;

+(NSString*) getVersionName;

@end

#endif /* SystemUtils_h */

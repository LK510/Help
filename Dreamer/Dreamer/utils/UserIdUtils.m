//
//  UserIdUtils.m
//  yinji
//
//  Created by 印记 on 16/8/1.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserIdUtils.h"

@implementation UserIdUtils
 
+(NSString*) getUUID{
    
    //NSUUID* UUID = [NSUUID UUID];
    //NSString* UUIDString = UUID.UUIDString;
    
    NSString* UUIDString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    return UUIDString;
}

@end

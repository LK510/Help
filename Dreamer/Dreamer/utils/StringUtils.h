//
//  StringUtils.h
//  yinji
//
//  Created by 印记 on 16/6/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#ifndef StringUtils_h
#define StringUtils_h

@interface StringUtils : NSObject
 
+(NSString *) jsonStringWithDictionary:(NSDictionary *) dictionary;
+(NSDictionary*)   DicFromJsongString:(NSString*) jsongStr;

+(NSString *) jsonStringWithArray:(NSArray *) array;
+(NSArray*)   arrayFromJsongString:(NSString*) jsongStr;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

+(NSString *) filterUnicodeFromUTF8:(NSString*) utf8String;

@end

#endif /* StringUtils_h */

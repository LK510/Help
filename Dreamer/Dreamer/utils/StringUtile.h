//
//  StringUtile.h
//  note
//
//  Created by 印记 on 16/6/17.
//  Copyright © 2016年 印记. All rights reserved.
//

#ifndef StringUtile_h
#define StringUtile_h


@interface StringUtile : NSObject
{
    
}

+(NSString *) jsonStringWithDictionary:(NSDictionary *) dictionary;

+(NSString *) jsonStringWithArray:(NSArray *) array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

@end

#endif /* StringUtile_h */

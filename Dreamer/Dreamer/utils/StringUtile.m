//
//  StringUtile.m
//  note
//
//  Created by 印记 on 16/6/17.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StringUtile.h"

@implementation StringUtile
{
    
}

+(NSString *) jsonStringWithDictionary:(NSDictionary *) dictionary{
    
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [StringUtile jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+(NSString *) jsonStringWithArray:(NSArray *) array{
    
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [StringUtile jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+(NSString *) jsonStringWithString:(NSString *) string{
    
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithObject:(id) object{
    
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [StringUtile jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [StringUtile jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [StringUtile jsonStringWithArray:object];
    }
    return value;
}


@end
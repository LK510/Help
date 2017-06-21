//
//  StringUtils.m
//  yinji
//
//  Created by 印记 on 16/6/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StringUtils.h"

@implementation StringUtils
 
+(NSString *) jsonStringWithDictionary:(NSDictionary *) dictionary{
    
    if (dictionary==nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *dicData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    NSString* dicStr = [[NSString alloc] initWithData:dicData encoding:NSUTF8StringEncoding];
    return dicStr;
}

+(NSDictionary*)   DicFromJsongString:(NSString*) jsongStr{
    
    if (jsongStr==nil) {
        return nil;
    }
    NSError *error = nil;
    NSDictionary* dataDic = [NSJSONSerialization JSONObjectWithData:[jsongStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    return dataDic;
    
}

+(NSString *) jsonStringWithArray:(NSArray *) array{
    
    if (array==nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *arrayData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    NSString* arrayStr = [[NSString alloc] initWithData:arrayData encoding:NSUTF8StringEncoding];
    return arrayStr;
}

+(NSArray*)   arrayFromJsongString:(NSString*) jsongStr{
    
    if (jsongStr==nil) {
        return nil;
    }
    NSError *error = nil;
    NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:[jsongStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    return dataArray;
}

+(NSString *) jsonStringWithString:(NSString *) string{
    
    if (string==nil) {
        return nil;
    }
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithObject:(id) object{
    
    NSString *value = nil;
    if (!object) {
        return value;
    }
    
    NSError *error = nil;
    NSData *valueData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    value = [[NSString alloc] initWithData:valueData encoding:NSUTF8StringEncoding];
    return value;
}


+(NSString *) filterUnicodeFromUTF8:(NSString*) utf8String{

    NSString* checkStr = utf8String;
    for(int i = 0;i<[utf8String length];i++){
        unichar temp = [checkStr characterAtIndex:i];
        if (temp >= [@"\U00002000" characterAtIndex:0] && temp <= [@"\U0000200f" characterAtIndex:0]) {
            NSString *str = [NSString stringWithFormat: @"%C", temp];
            checkStr = [checkStr stringByReplacingOccurrencesOfString:str withString:@" "];
        }
        if (temp >= [@"\U00002028" characterAtIndex:0] && temp <= [@"\U0000202f" characterAtIndex:0]) {
            NSString *str = [NSString stringWithFormat: @"%C", temp];
            checkStr = [checkStr stringByReplacingOccurrencesOfString:str withString:@" "];
        }
        if (temp >= [@"\U0000205f" characterAtIndex:0] && temp <= [@"\U00002060" characterAtIndex:0]) {
            NSString *str = [NSString stringWithFormat: @"%C", temp];
            checkStr = [checkStr stringByReplacingOccurrencesOfString:str withString:@" "];
        }
        if (temp >= [@"\U00002066" characterAtIndex:0] && temp <= [@"\U0000206e" characterAtIndex:0]) {
            NSString *str = [NSString stringWithFormat: @"%C", temp];
            checkStr = [checkStr stringByReplacingOccurrencesOfString:str withString:@" "];
        }
    }
    
//    NSMutableString* checkStr = [NSMutableString stringWithFormat:@""];
//    for (int i=0; i<[utf8String length]; i++) {
//        
//        NSUInteger location = i;
//        unichar temp = [utf8String characterAtIndex:location];
//        if (temp >= [@"\U00002000" characterAtIndex:0] && temp <= [@"\U0000206e" characterAtIndex:0]) {
//            continue;
//        }
//        
//        NSString *str = [NSString stringWithFormat: @"%C", temp];
//        NSData* str2 = [str dataUsingEncoding:NSUTF8StringEncoding];
//        
//        [checkStr appendString:str];
//    }
    
    return [NSString stringWithFormat:@"%@ ",checkStr];
}


@end

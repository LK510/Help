//
//  HttpSecUtil.m
//  note
//
//  Created by 印记 on 16/6/24.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "HttpSecUtil.h"
#import "CocoaSecurity.h"


@implementation HttpSecUtil

+(NSData*) getEncryptHttpParam:(NSMutableDictionary*) paramMap{
    
    NSString* result = [[NSString alloc] init];
    
    //先获取目前的参数字符串
    NSString* param = [self getHttpParam:paramMap];
    //基于参数字符串得到加密串
    NSString* sortParam = [self getSortHttpParam:paramMap];
    NSString* signature = [self encryptHttpParam: sortParam];
    //[paramMap setValue:signature forKey:@"sign"];
    
    //获得最后的带加密串的参数字符串
    result = [param stringByAppendingFormat:@"&sign=%@",signature];

    return [result dataUsingEncoding:NSUTF8StringEncoding];
}

//获取参数字符串
+(NSString*) getHttpParam:(NSDictionary*) paramMap{
    NSString* result = [[NSString alloc] init];
    
    //遍历paramMap，组成参数字符串
    NSInteger i = 0;
    for ( NSObject* key in paramMap) {
        NSObject* value = paramMap[key];
        
        NSString* pkey;
        NSString* pvalue;
        if([key isKindOfClass:[NSString class]]){
            pkey = (NSString*)key;
        }
        
        
        if([value isKindOfClass:[NSString class]]){
            pvalue = (NSString*)value;
        }
        
        if (i != 0) {
            result = [result stringByAppendingString:@"&"];
        }
        //result = [result stringByAppendingFormat:@"%@=%@",pkey,[pvalue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPasswordAllowedCharacterSet]]];
        result = [result stringByAppendingFormat:@"%@=%@",pkey,[self URLEncodedString:pvalue]];
        i++;
        
    }
    return result;
}

//基于参数字符串得到加密串
+(NSString*) encryptHttpParam:(NSString*) param{
    NSString* text = [param stringByAppendingString:@"yxrsmd5"];
    text = [text stringByReplacingOccurrencesOfString:@"%2A" withString:@"*"];

    
    CocoaSecurityResult *result_md5 = [CocoaSecurity md5:text];
    NSString* result = result_md5.hexLower;
    
    return result;
}

+(NSString*) getSortHttpParam:(NSDictionary*) paramMap{
    NSString* result = [[NSString alloc] init];
    
    NSArray *keys = [paramMap allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingSelector:@selector(compare:)];
    //遍历paramMap，组成参数字符串
    NSInteger i = 0;
    for ( NSObject* key in sortedArray) {
        NSObject* value = paramMap[key];
        
        NSString* pkey;
        NSString* pvalue;
        if([key isKindOfClass:[NSString class]]){
            pkey = (NSString*)key;
        }
        
        
        if([value isKindOfClass:[NSString class]]){
            pvalue = (NSString*)value;
        }
        
        if (i != 0) {
            result = [result stringByAppendingString:@"&"];
        }
        //result = [result stringByAppendingFormat:@"%@=%@",pkey,[pvalue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPasswordAllowedCharacterSet]]];
        result = [result stringByAppendingFormat:@"%@=%@",pkey,[self URLEncodedString:pvalue]];

        i++;
        
    }
    return result;
}

+(NSString*) URLEncodedString:(NSString*) str
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = str;
    NSString *encodedString = [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPasswordAllowedCharacterSet]];
    //NSString *encodedString = [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"(" withString:@"%28"];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@")" withString:@"%29"];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    return encodedString;
}


@end

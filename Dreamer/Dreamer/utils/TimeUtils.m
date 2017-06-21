//
//  TimeUtils.m
//  yinji
//
//  Created by 印记 on 16/7/8.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TimeUtils.h"

@implementation TimeUtils
 
+(long long)micrTimeTransform:(NSString *)time{
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate* date = [dateformatter dateFromString:time];
    
    return [date timeIntervalSince1970] * 1000;
}

+(long long)micrTimeTransformDate:(NSDate *)date{

    return [date timeIntervalSince1970] * 1000;
}

+(long)timeTransform:(NSString *)time{

    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* date = [dateformatter dateFromString:time];
    
    return [date timeIntervalSince1970];
}

+(NSString *)getNoteTime:(long long)noteTime{

    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* noteData = [NSDate dateWithTimeIntervalSince1970:noteTime/1000];
    NSString *time = [dateformatter stringFromDate:noteData];

    return time;
}

+(NSDate *)getNoteDate:(long long)noteTime
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* noteData = [NSDate dateWithTimeIntervalSince1970:noteTime/1000];
    
    return noteData;
}

+ (NSString *)logtime
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    return [[NSString alloc] initWithFormat:@"%@", date];
}

+(long) currentTimeStamp{
    NSDate *datenow =[NSDate date];
    //NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //NSInteger interval = [zone secondsFromGMTForDate:datenow];
    //NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    return (long)[datenow timeIntervalSince1970];
}

+(long long) currentMicroTimeStamp{
    NSDate *datenow =[NSDate date];
    //NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //NSInteger interval = [zone secondsFromGMTForDate:datenow];
    //NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    return (long long)([datenow timeIntervalSince1970]*1000);
}

+(NSString*) currentTimeStampStr{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", [self currentTimeStamp]];
    return timeSp;
}

+(long long) getTimeStampFromString:(NSString*) timeStr{
    if (timeStr==nil) {
        return 0;
    }
    
    NSTimeInterval time = [timeStr doubleValue];
    return time;
}

+(NSString*) getDateStr:(NSString*) fomate : (long long) timeStamp{
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:fomate];

    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    return [dateformatter stringFromDate:date];
}

@end

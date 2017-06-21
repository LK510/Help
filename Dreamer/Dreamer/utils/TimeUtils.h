//
//  TimeUtils.h
//  yinji
//
//  Created by 印记 on 16/7/8.
//  Copyright © 2016年 印记. All rights reserved.
//

#ifndef TimeUtils_h
#define TimeUtils_h

@interface TimeUtils : NSObject

+(long) currentTimeStamp;
+(long)timeTransform:(NSString *)time;
+(NSString*) currentTimeStampStr;


+(long long)micrTimeTransform:(NSString *)time;
+(long long) currentMicroTimeStamp;
+(long long) getTimeStampFromString:(NSString*) timeStr;
+(NSString*) getDateStr:(NSString*) fomate : (long long) timeStamp;
+(NSString *)getNoteTime:(long long)noteTime;
/** 时间戳转化为NSDate  */
+(NSDate *)getNoteDate:(long long)noteTime;
/** NSDate戳转化为时间戳  */
+(long long)micrTimeTransformDate:(NSDate *)date;


+ (NSString *)logtime;

@end

#endif /* TimeUtils_h */

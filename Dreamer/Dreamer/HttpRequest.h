//
//  HttpRequest.h
//  note
//
//  Created by 印记 on 16/6/24.
//  Copyright © 2016年 印记. All rights reserved.
//

#ifndef HttpRequest_h
#define HttpRequest_h


#endif /* HttpRequest_h */


@interface HttpRequest : NSObject
 
-(NSData*) sendDataByHttpPost:(NSString*) url : (NSData*) param;

- (void) sendHttpPost:(NSString*) url : (NSMutableDictionary*) param : (NSMutableDictionary*)respond;

@end

//
//  HttpRequest.m
//  note
//
//  Created by 印记 on 16/6/24.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@interface HttpRequest ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation HttpRequest

- (AFHTTPSessionManager *) manager{
    
    if (_manager == nil) {
        
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                  @"text/html",
                                                                  @"image/jpeg",
                                                                  @"image/png",
                                                                  @"application/octet-stream",
                                                                  @"text/json",
                                                                  nil];

    }
    return _manager;
}

- (void) sendHttpPost:(NSString*) url : (NSMutableDictionary*) param : (NSMutableDictionary*)respond{
    
    [self.manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //...
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [respond setValue:responseObject forKey:@"respond"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [respond setValue:error forKey:@"error"];
        
    }];
    
}

-(NSData*) sendDataByHttpPost:(NSString*) urlstr : (NSData*) param{
    
    if (![SystemUtils hasInternet]) {
    
        runOnMainThread(^{
            
            if ([self currentVc]) {
                [[self showMessage:@"请检查网络设置！"] contetHeight:screenWidth];
            }

        });
        
        return nil;
    }
    
    //构建url
    NSURL* url = [NSURL URLWithString:urlstr];
    //初始化request
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    //初始化参数
    NSData*     data = param;
    [request setHTTPBody:data];
    
    //获得服务器返回内容
    NSData* receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString* resultStr = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    
    return receivedData;
}

@end

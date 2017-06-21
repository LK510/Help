//
//  BlockHelper.h
//  yinji
//
//  Created by mjl on 2017/4/11.
//  Copyright © 2017年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>


void runOnMainThread( void(^bloc)() );
void runOnGloableThread( void(^bloc)() );

@interface BlockHelper : NSObject

@end

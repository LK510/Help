//
//  BlockHelper.m
//  yinji
//
//  Created by mjl on 2017/4/11.
//  Copyright © 2017年 印记. All rights reserved.
//

#import "BlockHelper.h"
void runOnMainThread( void(^bloc)() ){

		dispatch_async(dispatch_get_main_queue(), bloc);

}

void runOnGloableThread( void(^bloc)() ){

		dispatch_async(dispatch_get_global_queue(0, 0), bloc);
}

@implementation BlockHelper

@end

//
//  NSObject+Message.h
//  biaoqian
//
//  Created by majunliang on 16/9/1.
//  Copyright © 2016年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Message)

- (instancetype )showMessage:(NSString *)message;

- (void)contetHeight:(CGFloat)height;

- (UIViewController *) currentVc;

- (void) checkNet;

@end

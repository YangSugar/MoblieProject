//
//  MainClass.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/3.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "MainClass.h"

@implementation MainClass

+ (void)initialize {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)load {
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end


@implementation MainChildClass


@end

//
//  NSArray+Swizzle.m
//  MoblieProject
//
//  Created by futang yang on 2017/12/29.
//  Copyright © 2017年 futang yang. All rights reserved.
//

#import "NSArray+Swizzle.h"

@implementation NSArray (Swizzle)

- (instancetype)ft_lastObject {
    id obj = [self ft_lastObject];
    NSLog(@"************  ft_lastObject ***********");
    return obj;
}

@end

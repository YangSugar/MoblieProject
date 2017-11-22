//
//  NSDate+GXBExtension.m
//  GXBaseExample
//
//  Created by Vision on 2017/4/26.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "NSDate+GXBExtension.h"

@implementation NSDate (GXBExtension)

+ (NSString *)gxb_timestamp {
    
    return [[NSNumber numberWithLongLong:[[self date] timeIntervalSince1970]*1000] stringValue];
}

@end

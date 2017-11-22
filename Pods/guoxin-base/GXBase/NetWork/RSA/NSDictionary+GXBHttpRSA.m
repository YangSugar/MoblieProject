//
//  NSDictionary+GXBHttpRSA.m
//  GXBaseExample
//
//  Created by Vision on 2017/4/27.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "NSDictionary+GXBHttpRSA.h"
#import <MJExtension.h>
#import "GXRSAEncryptor.h"

@implementation NSDictionary (GXBHttpRSA)

- (NSString *)gxb_rsaForDictionary {
    
    NSString *json = [self mj_JSONString];
    
    return [[[GXRSAEncryptor alloc]init] rsaEncryptString:json];
    
}

@end

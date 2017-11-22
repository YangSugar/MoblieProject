//
//  UIColor+GXBHEX.h
//  GXBaseExample
//
//  Created by Vision on 2017/3/21.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GXBHEX)

+ (UIColor *)gxb_colorWithHex:(UInt32)hex;

+ (UIColor *)gxb_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

+ (UIColor *)gxb_colorWithHexString:(NSString *)hexString;

- (NSString *)gxb_HEXString;

@end

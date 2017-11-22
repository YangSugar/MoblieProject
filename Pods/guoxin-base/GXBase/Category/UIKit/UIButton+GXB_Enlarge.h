//
//  UIButton+GXB_Enlarge.h
//  GXBaseExample
//
//  Created by futang yang on 2017/3/29.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GXB_Enlarge)

/**
 *  增加button点击区域大小
 *  必须都要设置才能起作用
 *  @param top    上
 *  @param right  右
 *  @param bottom 下
 *  @param left   左
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;


@end

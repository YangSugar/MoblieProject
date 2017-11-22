//
//  UINavigationController+StatusBar.m
//  GXBaseExample
//
//  Created by Vision on 2017/3/23.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "UINavigationController+StatusBar.h"
#import <objc/runtime.h>

static void *barHidden = &barHidden;
static void *barStyleLightContent = &barStyleLightContent;

@implementation UINavigationController (StatusBar)
@dynamic gx_barHidden;
@dynamic gx_BarStyleLightContent;

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.gx_BarStyleLightContent ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    
    return self.gx_barHidden;
}

- (void)setGx_barHidden:(BOOL)gx_barHidden {
    NSNumber *hidenNum = [NSNumber numberWithBool:gx_barHidden];
    objc_setAssociatedObject(self, barHidden, hidenNum, OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)gx_barHidden {
    NSNumber *hidenNum = objc_getAssociatedObject(self, barHidden);
    return [hidenNum boolValue];
}

- (void)setGx_BarStyleLightContent:(BOOL)gx_BarStyleLightContent {
    
    NSNumber *contentNum = [NSNumber numberWithBool:gx_BarStyleLightContent];
    objc_setAssociatedObject(self, barStyleLightContent, contentNum, OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)gx_BarStyleLightContent {
    
    NSNumber *contentNum = objc_getAssociatedObject(self, barStyleLightContent);
    return [contentNum boolValue];
}

@end

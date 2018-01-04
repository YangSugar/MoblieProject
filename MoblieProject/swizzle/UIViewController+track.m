//
//  UIViewController+track.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/2.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "UIViewController+track.h"
#import <objc/runtime.h>

@implementation UIViewController (track)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(loadView);
        SEL swizzledSelector = @selector(xxx_loadView);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

    });
}

#pragma mark - Method Swizzling
- (void)xxx_viewWillAppear:(BOOL)animated {
    [self xxx_viewWillAppear:animated];
    NSLog(@"xxx_viewWillAppear:========= %@", self);
}


- (void)xxx_loadView {
    [self xxx_loadView];
    NSLog(@"xxx_loadView:========= %@", self);
}

@end

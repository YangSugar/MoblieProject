//
//  FTViewControllerIntercepter.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/4.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTViewControllerIntercepter.h"

#import <Aspects.h>

@interface FTViewControllerIntercepter ()

@end

@implementation FTViewControllerIntercepter

+ (void)load {
    static dispatch_once_t onceToken;
    static FTViewControllerIntercepter *interceper = nil;
    dispatch_once(&onceToken, ^{
        interceper = [[FTViewControllerIntercepter alloc] init];
    });
}

- (instancetype)init {
    if (self = [super init]) {
        // 方法拦截
        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo) {
            [self _viewDidLoad:aspectInfo.instance];
        } error:nil];
    }
    return self;
}


- (void)_viewDidLoad:(UIViewController *)controller {
    
    if ([controller conformsToProtocol:@protocol(FTViewControllerIntercepterDelegate)]) {
        
        NSLog(@"%s%@", __func__, [self class]);
        controller.edgesForExtendedLayout = UIRectEdgeAll;
        controller.view.backgroundColor = [UIColor orangeColor];
    }
}




@end

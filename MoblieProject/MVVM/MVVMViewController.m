//
//  MVVMViewController.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/4.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "MVVMViewController.h"
#import <Masonry.h>
#import "FTViewControllerIntercepter.h"

@interface MVVMViewController () <FTViewControllerIntercepterDelegate>


@end

@implementation MVVMViewController

#pragma mark - life Circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self renderUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - render UI
- (void)renderUI {
    self.title = @"登录";
    
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.height.mas_equalTo(100);
    }];
    
    [button setBackgroundColor:[UIColor orangeColor]];
}

#pragma mark - event response


#pragma mark - private methods
- (void)loadData {
    
}

#pragma mark - getter and setter


#pragma mark - delegate



@end

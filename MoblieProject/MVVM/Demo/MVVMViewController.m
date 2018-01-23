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

#import "FTHomePageTableView.h"
#import "FTHomePageDataManager.h"
#import "FTHomePageTableViewModel.h"


@interface MVVMViewController () <FTViewControllerIntercepterDelegate>

@property (nonatomic, strong) FTHomePageTableView *tableView;
@property (nonatomic, strong) FTHomePageDataManager *dataManager;


@end

@implementation MVVMViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self renderUI];
    
    [self loadData];
}



#pragma mark - render UI
- (void)renderUI {
    self.title = @"主页";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
 
}

#pragma mark - event response


#pragma mark - private methods
- (void)loadData {
    [self.dataManager requestRecipeDataWhenSuccess:^{
        if (self.dataManager.recipes.count > 0) {
            [self renderRecipeView];
        }
    } fialure:^(NSError *error) {
        
    }];
}

- (void)renderRecipeView {
    FTHomePageTableViewModel *vm = [FTHomePageTableViewModel viewModelWithRecioes:self.dataManager.recipes];
    [self.tableView bindDataWithViewModel:vm];
}

#pragma mark - getter and setter
- (FTHomePageTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[FTHomePageTableView alloc] init];
    }
    return _tableView;
}

- (FTHomePageDataManager *)dataManager {
    if (_dataManager == nil) {
        _dataManager = [[FTHomePageDataManager alloc] init];
    }
    return _dataManager;
}

#pragma mark - delegate



@end

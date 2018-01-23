//
//  FTHomePageTableView.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/9.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTHomePageTableView.h"
#import "FTHomePageTableViewCell.h"

#import "FTHomePageTableViewModel.h"
#import "FTHomePageTableCellViewModel.h"


@interface FTHomePageTableView () <UITableViewDelegate,UITableViewDataSource>


@end


@implementation FTHomePageTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self registerClass:[FTHomePageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FTHomePageTableViewCell class])];
        
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)bindDataWithViewModel:(FTHomePageTableViewModel *)viewModel {
    self.tableViewModel = viewModel;
    
    [self reloadData];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewModel.cellViewModels.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FTHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FTHomePageTableViewCell class])];
    
    FTHomePageTableCellViewModel *vm = self.tableViewModel.cellViewModels[indexPath.row];
    [cell bindDataWithViewModel:vm];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}


@end

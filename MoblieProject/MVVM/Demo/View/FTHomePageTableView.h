//
//  FTHomePageTableView.h
//  MoblieProject
//
//  Created by futang yang on 2018/1/9.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTHomePageTableViewModel;
@class FTHomePageTableView;

@interface FTHomePageTableView : UITableView

@property (nonatomic, strong) FTHomePageTableViewModel *tableViewModel;

- (void)bindDataWithViewModel:(FTHomePageTableViewModel *)viewModel;

@end

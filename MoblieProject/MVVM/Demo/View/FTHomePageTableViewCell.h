//
//  FTHomePageTableViewCell.h
//  MoblieProject
//
//  Created by futang yang on 2018/1/10.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FTHomePageTableCellViewModel;

@interface FTHomePageTableViewCell : UITableViewCell

@property (nonatomic, strong) FTHomePageTableCellViewModel *viewModel;

- (void)bindDataWithViewModel:(FTHomePageTableCellViewModel *)viewModel;

@end

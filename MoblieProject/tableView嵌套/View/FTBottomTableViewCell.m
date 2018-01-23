//
//  FTBottomTableViewCell.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/19.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTBottomTableViewCell.h"
#import "FTScrollContentControoler.h"

@implementation FTBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setCellCanScroll:(BOOL)cellCanScroll {
    _cellCanScroll = cellCanScroll;
    
    for (FTScrollContentControoler *vc in _viewControllers) {
        vc.vcCanScroll = cellCanScroll;
        if (!cellCanScroll) { // 如果cell不能滑动 代表到了顶部 修改所有vc状态回到顶部
            vc.tableView.contentOffset = CGPointZero;
        }
    }
}



@end

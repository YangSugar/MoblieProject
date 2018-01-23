//
//  FTBottomTableViewCell.h
//  MoblieProject
//
//  Created by futang yang on 2018/1/19.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSScrollContentView.h"

@interface FTBottomTableViewCell : UITableViewCell

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;


@end

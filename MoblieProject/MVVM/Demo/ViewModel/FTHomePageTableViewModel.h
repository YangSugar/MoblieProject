//
//  FTHomePageTableViewModel.h
//  MoblieProject
//
//  Created by futang yang on 2018/1/10.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Recipe;
@class FTHomePageTableCellViewModel;

@interface FTHomePageTableViewModel : NSObject

@property (nonatomic, strong) NSArray <FTHomePageTableCellViewModel *> *cellViewModels;

@property (nonatomic, strong) UIColor *backgroundColor;



+ (FTHomePageTableViewModel *)viewModelWithRecioes:(NSArray <Recipe *> *)recipes;

@end

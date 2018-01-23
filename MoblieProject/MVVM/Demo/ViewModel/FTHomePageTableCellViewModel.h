//
//  FTHomePageTableCellViewModel.h
//  MoblieProject
//
//  Created by futang yang on 2018/1/10.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Recipe;
@class FTHomePageTableCellViewModel;

@interface FTHomePageTableCellViewModel : NSObject

@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) NSString *desc;



+ (FTHomePageTableCellViewModel *)viewModelWithRecipe:(Recipe *)recipe;

@end

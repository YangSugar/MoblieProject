//
//  FTHomePageTableCellViewModel.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/10.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTHomePageTableCellViewModel.h"
#import "Recipe.h"

@implementation FTHomePageTableCellViewModel

+ (FTHomePageTableCellViewModel *)viewModelWithRecipe:(Recipe *)recipe {
    FTHomePageTableCellViewModel *vm = [[FTHomePageTableCellViewModel alloc] init];
    vm.avatarURL = recipe.recipeAlbum;
    vm.title = recipe.recipeTitle;
    vm.desc = recipe.recipeDesc;
    vm.titleColor = [UIColor redColor];
    
    return vm;
}

@end

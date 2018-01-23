//
//  FTHomePageTableViewModel.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/10.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTHomePageTableViewModel.h"
#import "FTHomePageTableCellViewModel.h"

@implementation FTHomePageTableViewModel

+ (FTHomePageTableViewModel *)viewModelWithRecioes:(NSArray <Recipe *> *)recipes {
    FTHomePageTableViewModel *vm = [[FTHomePageTableViewModel alloc] init];
    
    NSMutableArray *cellViewModelArr = [[NSMutableArray alloc] init];
    
    for (Recipe *recipe in recipes) {
        FTHomePageTableCellViewModel *vm = [FTHomePageTableCellViewModel viewModelWithRecipe:recipe];
        [cellViewModelArr addObject:vm];
    }
    vm.cellViewModels = cellViewModelArr;
    vm.backgroundColor = [UIColor whiteColor];
    
    return vm;
}

@end

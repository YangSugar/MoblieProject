//
//  FTHomePageDataManager.h
//  MoblieProject
//
//  Created by futang yang on 2018/1/9.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recipe;


typedef void(^SuccessBlock)(void);
typedef void(^FailBlock)(NSError *);


@interface FTHomePageDataManager : NSObject


@property (nonatomic, strong) NSArray <Recipe *> *recipes;


- (void)requestRecipeDataWhenSuccess:(SuccessBlock)successHandler fialure:(FailBlock)failurHandler;


@end

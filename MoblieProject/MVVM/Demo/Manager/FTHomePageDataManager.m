//
//  FTHomePageDataManager.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/9.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTHomePageDataManager.h"
#import <AFNetworking/AFNetworking.h>
#import "Recipe.h"


@implementation FTHomePageDataManager

- (instancetype)init {
    if (self = [super init]) {
        self.recipes = [[NSArray alloc] init];
    }
    return self;
}



- (void)requestRecipeDataWhenSuccess:(SuccessBlock)successHandler fialure:(FailBlock)failurHandler {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"http://apis.juhe.cn/cook/query";
    NSDictionary *dic = @{@"key" : @"ece65c27ede91b57c652f30b59ed5dcd",
                          @"menu" : @"炒鸡蛋",};
    
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self generateRecipeWithResponseData:responseObject];
        successHandler();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurHandler(error);
    }];
}


- (void)generateRecipeWithResponseData:(id)responseObj{
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDic = (NSDictionary *)responseObj;
        NSDictionary *resultDic = responseDic[@"result"];
        NSArray *dataArr = resultDic[@"data"];
        NSMutableArray *recipeArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dataArr) {
            Recipe *recipe = [[Recipe alloc] init];
            recipe.recipeId = dic[@"id"];
            recipe.recipeTitle = dic[@"title"];
            recipe.recipeTags = dic[@"tags"];
            recipe.recipeDesc = dic[@"imtro"];
            recipe.recipeAlbum = dic[@"albums"][0];
            [recipeArr addObject:recipe];
        }
        self.recipes = recipeArr;
    }
}

@end

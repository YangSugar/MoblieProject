//
//  GXCommonModel.h
//  GXBaseExample
//
//  Created by Vision on 2017/3/21.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCommonModel : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) id value;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger errCode;

@end

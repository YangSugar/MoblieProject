//
//  GXBHttpTools+GXBToken.h
//  GXBaseExample
//
//  Created by Vision on 2017/4/13.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "GXBHttpTools.h"

@interface GXBHttpTools (GXBToken)

//获取devicetoken
- (NSString *)getDeviceToken;
//删除devicetoken
- (void)deleteDeviceToken;

//获取x-auth-token
- (NSString *)getXAuthToken;
//设置x-auth-token
- (void)saveXAuthToken:(NSString *)token;
//删除x-auth-token
- (void)deleteXAuthToken;

//获取X-IDENTIFY-TOKEN
- (NSString *)getXIdentifyToken;
//设置X-IDENTIFY-TOKEN
- (void)saveXIdentifyToken:(NSString *)token;
//删除X-IDENTIFY-TOKEN
- (void)deleteXIdentifyToken;

@end

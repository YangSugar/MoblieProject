
//
//  GXBHttpTools.m
//  GXBaseExample
//
//  Created by Vision on 2017/3/21.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "GXBHttpTools.h"
#import "GXCommonModel.h"
#import <MJExtension/MJExtension.h>
#import "GXLog.h"
#import "VBHTTPManager.h"
#import "NSString+GXBDevice.h"
#import "GXBHttpTools+GXBToken.h"
#import "VBHTTPCacheManager.h"
#import "VBFileConfig.h"

@interface GXBHttpTools ()

@end

@implementation GXBHttpTools

+ (instancetype)shareManager {
    static GXBHttpTools *httpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[GXBHttpTools alloc] init];
        [[VBHTTPManager shareManager] setTimeout:20];
    });
    return httpManager;
}

#pragma mark - base
//get
- (NSURLSessionTask *)getFromURL:(NSString *)url
                          params:(NSDictionary *)params
                   responseCache:(GXBRequestCacheBlock)responseCache
                         success:(GXBRequestSuccessBlock)successHandler
                         failure:(GXBRequestFailureBlock)failureHandler; {
    
    [self addDeviceToken];
    __weak __typeof(&*self)weakSelf = self;
    RequestCacheBlock cache = ^(id responseObj) {
        GXLogVerbose(@"GET_CACHE:url =%@\nparams =%@\nresponse =%@",
                     url, params, responseObj);
        GXCommonModel *model = [GXCommonModel mj_objectWithKeyValues:responseObj];
        if (model.success) {
            responseCache(model.value);
        }
    };
    RequestSuccessBlock success = ^(id responseObj, NSURLSessionDataTask *task) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        GXLogVerbose(@"GET:url =%@\nparams =%@\nresponse =%@",
                     url, params, responseObj);
        [strongSelf addX_Auth_Token:task];
        GXCommonModel *model = [GXCommonModel mj_objectWithKeyValues:responseObj];
        if (model.errCode == -1) {
            [strongSelf deleteDeviceToken];
        }
        if (model.errCode == -6) {
            [strongSelf tipUserUpdate];
        }
        if (model.errCode == -2) {
            model.message = @"请重新登录";
        }
        if (model.success) {
            successHandler(model.value);
        } else {
            NSError *error =
            [NSError errorWithDomain:GTBHTTPErrorDomain
                                code:model.errCode
                            userInfo:@{NSLocalizedDescriptionKey : model.message}];
            failureHandler(error);
        }
    };
    RequestFailureBlock failure = ^(NSError *error, NSURLSessionDataTask *task) {
        if (error.code == -1011 || error.code == -1001) {
            NSError *cusError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                    code:error.code
                                                userInfo:@{NSLocalizedDescriptionKey : @"请求超时"}];
            failureHandler(cusError);
            return ;
        }
        failureHandler(error);
    };
    NSURLSessionTask *task =
    [[VBHTTPManager shareManager] getRequest:url
                                      params:params
                               responseCache:responseCache?cache:nil
                                     success:success
                                     failure:failure];
    return task;
}
//post
- (NSURLSessionTask *)postFromURL:(NSString *)url
                           params:(NSDictionary *)params
                    responseCache:(GXBRequestCacheBlock)responseCache
                          success:(GXBRequestSuccessBlock)successHandler
                          failure:(GXBRequestFailureBlock)failureHandler {
    
    [self addDeviceToken];
    __weak __typeof(&*self)weakSelf = self;
    RequestCacheBlock cache = ^(id responseObj) {
        GXLogVerbose(@"POST_CACHE:url =%@\nparams =%@\nresponse =%@",
                     url, params, responseObj);
        GXCommonModel *model = [GXCommonModel mj_objectWithKeyValues:responseObj];
        if (model.success) {
            responseCache(model.value);
        }
    };
    RequestSuccessBlock success = ^(id responseObj, NSURLSessionDataTask *task) {
        GXLogVerbose(@"POST:url =%@\nparams =%@\nresponse =%@",
                     url, params, responseObj);
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        [strongSelf addX_Auth_Token:task];
        GXCommonModel *model = [GXCommonModel mj_objectWithKeyValues:responseObj];
        if (model.errCode == -1) {
            [strongSelf deleteDeviceToken];
        }
        if (model.errCode == -6) {
            [strongSelf tipUserUpdate];
        }
        if (model.errCode == -2) {
            model.message = @"请重新登录";
        }
        if (model.success) {
            successHandler(model.value);
        } else {
            NSError *error =
            [NSError errorWithDomain:GTBHTTPErrorDomain
                                code:model.errCode
                            userInfo:@{NSLocalizedDescriptionKey : model.message}];
            failureHandler(error);
        }
    };
    RequestFailureBlock failure = ^(NSError *error, NSURLSessionDataTask *task) {
        if (error.code == -1011 || error.code == -1001) {
            NSError *cusError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                    code:error.code
                                                userInfo:@{NSLocalizedDescriptionKey : @"请求超时"}];
            failureHandler(cusError);
            return ;
        }
        failureHandler(error);
    };
    NSURLSessionTask *task =
    [[VBHTTPManager shareManager] postRequest:url
                                       params:params
                                responseCache:responseCache?cache:nil
                                      success:success
                                      failure:failure];
    return task;
}

- (NSURLSessionTask *)updateRequest:(NSString *)url
                             params:(NSDictionary *)params
                          fileParam:(NSString *)fileParam
                           fileName:(NSString *)fileName
                           filetype:(NSString *)filetype
                           fileData:(NSData *)fileData
                            success:(GXBRequestSuccessBlock)successHandler
                            failure:(GXBRequestFailureBlock)failureHandler {
    
    VBFileConfig *file = [VBFileConfig fileConfigWithfileData:fileData
                                                         name:fileParam
                                                     fileName:fileName
                                                     mimeType:filetype];
    
    __weak __typeof(&*self)weakSelf = self;
    RequestSuccessBlock success = ^(id responseObj, NSURLSessionDataTask *task) {
        GXLogVerbose(@"UPDATE:url =%@\nparams =%@\nresponse =%@",
                     url, params, responseObj);
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        [strongSelf addX_Auth_Token:task];
        GXCommonModel *model = [GXCommonModel mj_objectWithKeyValues:responseObj];
        if (model.errCode == -1) {
            [strongSelf deleteDeviceToken];
        }
        if (model.errCode == -6) {
            [strongSelf tipUserUpdate];
        }
        if (model.success) {
            successHandler(model.value);
        } else {
            NSError *error =
            [NSError errorWithDomain:GTBHTTPErrorDomain
                                code:model.errCode
                            userInfo:@{NSLocalizedDescriptionKey : model.message}];
            failureHandler(error);
        }
    };
    RequestFailureBlock failure = ^(NSError *error, NSURLSessionDataTask *task) {
        failureHandler(error);
    };
    NSURLSessionTask *task =
    [[VBHTTPManager shareManager] updateRequest:url
                                         params:params
                                     fileConfig:file
                                        success:success
                                        failure:failure];
    return task;
}

- (void)setCommonHttpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders {
    [[VBHTTPManager shareManager] setCommonHttpHeaders:httpHeaders];
}

- (void)setTempHttpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders {
    [[VBHTTPManager shareManager] setTempHttpHeaders:httpHeaders];
}

- (void)cancelAllRequest {
    
    [[VBHTTPManager shareManager] cancelAllRequest];
}

- (void)cancelRequestWithURL:(NSString *)URL {
    
    [[VBHTTPManager shareManager] cancelRequestWithURL:URL];
}

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize {
    return [VBHTTPCacheManager getAllHttpCacheSize];
}


/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache {
    
    return [VBHTTPCacheManager removeAllHttpCache];
}

#pragma mark - private method
- (void)addX_Auth_Token:(NSURLSessionDataTask *)task {
    
    NSDictionary *headers = [(NSHTTPURLResponse *)task.response allHeaderFields];
    if ([headers objectForKey:@"x-auth-token"]) {
        [self saveXAuthToken:[headers objectForKey:@"x-auth-token"]];
    }
}

- (void)addDeviceToken {
    
    [self getDeviceToken];
    [self getXAuthToken];
    [self getXIdentifyToken];
}

- (void)tipUserUpdate {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"更新程序" message:@"接口过早，请更新最新版本" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"知道了") otherButtonTitles:nil, nil];
    [alertView show];
#pragma clang diagnostic pop
}

@end

//
//  GXBHttpTools.h
//  GXBaseExample
//
//  Created by Vision on 2017/3/21.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const GTBHTTPErrorDomain = @"com.guoxin.base";
/**
 缓存的Block
 */
typedef void(^GXBRequestCacheBlock)(id responseCache);

/**
 请求成功block
 */
typedef void (^GXBRequestSuccessBlock)(id responseObj);

/**
 请求失败block
 */
typedef void (^GXBRequestFailureBlock)(NSError *error);

@interface GXBHttpTools : NSObject

+ (instancetype)shareManager;

//**url - 避免悲剧,请统一配置 不要额外再设置
@property (nonatomic, copy) NSString *mainHostUrl;      //主要  host url
@property (nonatomic, copy) NSString *tradeHostUrl;     //交易  host url
@property (nonatomic, copy) NSString *marsHostUrl;      //mars host url
@property (nonatomic, copy) NSString *imageHostUrl;     //图片  host url
@property (nonatomic, copy) NSString *h5HostUrl;        //h5 host url

//设置header
- (void)setCommonHttpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders;
//设置临时header (请求第三方接口前调用)
- (void)setTempHttpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders;
/**
 发送GET请求

 @param url host url
 @param params 参数
 @param responseCache 缓存 传nil 为不需要缓存
 @param successHandler 成功 对应服务器,直接返回value值
 @param failureHandler 失败 对应服务器,通过NSError查看错误信息和错误码
 */
- (NSURLSessionTask *)getFromURL:(NSString *)url
                          params:(NSDictionary *)params
                   responseCache:(GXBRequestCacheBlock)responseCache
                         success:(GXBRequestSuccessBlock)successHandler
                         failure:(GXBRequestFailureBlock)failureHandler;
/**
 发送POST请求

 @param url host url
 @param params 参数
 @param responseCache 缓存 传nil 为不需要缓存
 @param successHandler 成功 对应服务器,直接返回value值
 @param failureHandler 失败 对应服务器,通过NSError查看错误信息和错误码
 */
- (NSURLSessionTask *)postFromURL:(NSString *)url
                           params:(NSDictionary *)params
                    responseCache:(GXBRequestCacheBlock)responseCache
                          success:(GXBRequestSuccessBlock)successHandler
                          failure:(GXBRequestFailureBlock)failureHandler;


/**
 上传文件

 @param url url
 @param params 参数
 @param fileParam 文件对应服务器参数
 @param fileName 文件名
 @param filetype 文件类型
 @param fileData 文件数据
 @param successHandler 成功 对应服务器,直接返回value值
 @param failureHandler 失败 对应服务器,通过NSError查看错误信息和错误码
 */
- (NSURLSessionTask *)updateRequest:(NSString *)url
                             params:(NSDictionary *)params
                          fileParam:(NSString *)fileParam
                           fileName:(NSString *)fileName
                           filetype:(NSString *)filetype
                           fileData:(NSData *)fileData
                            success:(GXBRequestSuccessBlock)successHandler
                            failure:(GXBRequestFailureBlock)failureHandler;
/**
 取消所有网络请求
 */
- (void)cancelAllRequest;

/**
 取消特定网络请求
 
 @param URL URL
 */
- (void)cancelRequestWithURL:(NSString *)URL;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;


/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache;


@end

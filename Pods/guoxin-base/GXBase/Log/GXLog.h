//
//  GXLog.h
//  VBKit
//
//  Created by Vision on 15/11/20.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "CocoaLumberjack.h"
#import <Foundation/Foundation.h>

#ifdef LOG_LEVEL_DEF
#undef LOG_LEVEL_DEF
#define LOG_LEVEL_DEF GXLog_logLevel
#endif

#ifdef LOG_ASYNC_ENABLED
#undef LOG_ASYNC_ENABLED
#ifdef DEBUG
#define LOG_ASYNC_ENABLED NO
#else
#define LOG_ASYNC_ENABLED YES
#endif
#endif

typedef NS_ENUM(NSUInteger, GXLogLevel)
{
    GXLogLevelOff = DDLogLevelOff,
    GXLogLevelError = DDLogLevelError,
    GXLogLevelWarning = DDLogLevelWarning,
    GXLogLevelInfo = DDLogLevelInfo,
    GXLogLevelDebug = DDLogLevelDebug,
    GXLogLevelVerbose = DDLogLevelVerbose,
    GXLogLevelAll = DDLogLevelAll
};
extern int GXLog_logLevel;

#define GXLogError(frmt, ...)   DDLogError(frmt, ##__VA_ARGS__)
#define GXLogWarn(frmt, ...)    DDLogWarn(frmt, ##__VA_ARGS__)
#define GXLogInfo(frmt, ...)    DDLogInfo(frmt, ##__VA_ARGS__)
#define GXLogDebug(frmt, ...)   DDLogDebug(frmt, ##__VA_ARGS__)
#define GXLogVerbose(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)

@interface GXLog : NSObject
/**
 *  @author Abc
 *
 *  设置日志级别,必须设置,否则不打开日志
 *
 *  @param logLevel 级别,见枚举.
 */
+ (void)setLevel:(GXLogLevel)logLevel;

@end

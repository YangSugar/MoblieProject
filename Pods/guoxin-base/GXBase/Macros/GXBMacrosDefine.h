//
//  GXBMacrosDefine.h
//  GXAppNew
//
//  Created by futang yang on 2017/3/16.
//  Copyright © 2017年 futang yang. All rights reserved.
//

#ifndef GXBMacrosDefine_h
#define GXBMacrosDefine_h


// ********************** UI ********************** //

//基于6适配其他尺寸
#define GXB_HeightScale_IOS6(height) ((height/667.0) * GXB_ScreenHeight)
#define GXB_WidthScale_IOS6(width) ((width/375.0) * GXB_ScreenWidth)


// 手机型号
#define GXB_SCREEN_MAX_LENGTH MAX(GXB_ScreenHeight, GXB_ScreenWidth)
#define GXB_SCREEN_MIN_LENGTH MIN(GXB_ScreenHeight, GXB_ScreenWidth)
#define GXB_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define GXB_IS_IPHONE_4_OR_LESS (GXB_IS_IPHONE && GXB_SCREEN_MAX_LENGTH < 568.0)
#define GXB_IS_IPHONE_5 (GXB_IS_IPHONE && GXB_SCREEN_MAX_LENGTH == 568.0)
#define GXB_IS_IPHONE_5_OR_LESS (GXB_IS_IPHONE && GXB_SCREEN_MAX_LENGTH <= 568.0)
#define GXB_IS_IPHONE_6_OR_LESS (GXB_IS_IPHONE_6 || GXB_IS_IPHONE_6P)
#define GXB_IS_IPHONE_6 (GXB_IS_IPHONE && GXB_SCREEN_MAX_LENGTH == 667.0)
#define GXB_IS_IPHONE_6P (GXB_IS_IPHONE && GXB_SCREEN_MAX_LENGTH == 736.0)

//屏幕宽高
#define GXB_ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define GXB_ScreenWidth ([UIScreen mainScreen].bounds.size.width)



//字体样式
//pangfang-light
#define GXB_PingFangSC_Light(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define GXB_Helvetica_light(s) [UIFont fontWithName:@"Helvetica-Light" size:s]
//ping-regular
#define GXB_PingFangSC_Regular(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#define GXB_Helvetica_regular(s) [UIFont fontWithName:@"Helvetica" size:s]
//ping-medium
#define GXB_PingFangSC_Medium(s) [UIFont fontWithName:@"PingFangSC-Medium" size:s]
#define GXB_Helvetica_medium(s) [UIFont fontWithName:@"Helvetica" size:s]

//字体SIZE
#define GXB_FONT_PingFangSC_Light(s) (GXB_IOS9_OR_LATER ? GXB_PingFangSC_Light(s):GXB_Helvetica_light(s))
#define GXB_FONT_PingFangSC_Regular(s) (GXB_IOS9_OR_LATER ? GXB_PingFangSC_Regular(s):GXB_Helvetica_regular(s))
#define GXB_FONT_PingFangSC_Medium(s) (GXB_IOS9_OR_LATER ? GXB_PingFangSC_Medium(s):GXB_Helvetica_medium(s))

#define GXBFitFontSize6 (GXB_IS_IPHONE_6 ? 6:(GXB_IS_IPHONE_6P ? 6:4))
#define GXBFitFontSize7 (GXB_IS_IPHONE_6 ? 7:(GXB_IS_IPHONE_6P ? 7:5))
#define GXBFitFontSize8 (GXB_IS_IPHONE_6 ? 8:(GXB_IS_IPHONE_6P ? 8:6))
#define GXBFitFontSize9 (GXB_IS_IPHONE_6 ? 9:(GXB_IS_IPHONE_6P ? 9:7))
#define GXBFitFontSize10 (GXB_IS_IPHONE_6 ? 10:(GXB_IS_IPHONE_6P ? 10:8))
#define GXBFitFontSize11 (GXB_IS_IPHONE_6 ? 11:(GXB_IS_IPHONE_6P ? 11:9))
#define GXBFitFontSize12 (GXB_IS_IPHONE_6 ? 12:(GXB_IS_IPHONE_6P ? 12:10))
#define GXBFitFontSize13 (GXB_IS_IPHONE_6 ? 13:(GXB_IS_IPHONE_6P ? 13:11))
#define GXBFitFontSize14 (GXB_IS_IPHONE_6 ? 14:(GXB_IS_IPHONE_6P ? 14:12))
#define GXBFitFontSize15 (GXB_IS_IPHONE_6 ? 15:(GXB_IS_IPHONE_6P ? 15:13))
#define GXBFitFontSize16 (GXB_IS_IPHONE_6 ? 16:(GXB_IS_IPHONE_6P ? 16:13))
#define GXBFitFontSize17 (GXB_IS_IPHONE_6 ? 17:(GXB_IS_IPHONE_6P ? 17:15))
#define GXBFitFontSize18 (GXB_IS_IPHONE_6 ? 18:(GXB_IS_IPHONE_6P ? 18:16))
#define GXBFitFontSize19 (GXB_IS_IPHONE_6 ? 19:(GXB_IS_IPHONE_6P ? 19:17))
#define GXBFitFontSize20 (GXB_IS_IPHONE_6 ? 20:(GXB_IS_IPHONE_6P ? 20:18))
#define GXBFitFontSize21 (GXB_IS_IPHONE_6 ? 21:(GXB_IS_IPHONE_6P ? 21:19))
#define GXBFitFontSize22 (GXB_IS_IPHONE_6 ? 22:(GXB_IS_IPHONE_6P ? 22:20))
#define GXBFitFontSize23 (GXB_IS_IPHONE_6 ? 23:(GXB_IS_IPHONE_6P ? 23:21))
#define GXBFitFontSize24 (GXB_IS_IPHONE_6 ? 24:(GXB_IS_IPHONE_6P ? 24:22))
#define GXBFitFontSize25 (GXB_IS_IPHONE_6 ? 25:(GXB_IS_IPHONE_6P ? 25:23))
#define GXBFitFontSize26 (GXB_IS_IPHONE_6 ? 26:(GXB_IS_IPHONE_6P ? 26:24))
#define GXBFitFontSize30 (GXB_IS_IPHONE_6 ? 30:(GXB_IS_IPHONE_6P ? 30:28))

//16进制颜色宏
#define GXB_HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define GXB_RGBAColor(r,g,b,p) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(p)]
#define GXB_RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


// ****************** Other ****************** //

// 手机系统版本
#define GXB_IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define GXB_IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define GXB_IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define GXB_IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

//利用十六进制颜色绘制图片
#define GXB_ImageFromHex(hex) [UIImage getImageWithHexColor:hex]
//当前App版本
#define GXB_AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 偏好设置
#define GXB_Userdefult [NSUserDefaults standardUserDefaults]
// 通知中心
#define GXB_NotificationCenter [NSNotificationCenter defaultCenter]
// 是否空对象
#define GXB_IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

//Library/Caches 文件路径
#define GXB_FilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
//获取temp
#define GXB_PathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define GXB_PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define GXB_PathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//字符串是否为空
#define GXB_StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define GXB_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define GXB_DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)


// Dlog
#ifdef DEBUG
#define GXB_DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define GXB_DLog( s, ... )
#endif
// ************************************** //
typedef void(^GXBEventHandler)();
typedef void(^GXBEventOneHandler)(id sender);
typedef void(^GXBEventTwoHandler)(id sender, id sender1);
typedef void(^GXBEventThreeHandler)(id sender, id sender1, id sender2);

#define GXBWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define GXBSS(strongSelf) __strong __typeof__(weakSelf) strongSelf = weakSelf;

#define GXBBlockCall(block)  if(block){block();}
#define GXBBlockCallWithOneArg(block,arg)  if(block){block(arg);}
#define GXBBlockCallWithTwoArg(block,arg1,arg2) if(block){block(arg1,arg2);}
#define GXBBlockCallWithThreeArg(block,arg1,arg2,arg3) if(block){block(arg1,arg2,arg3);}

#define GXBMargin (10 * [UIScreen mainScreen].bounds.size.width / 375)
#define GXBHMargin (10 * [UIScreen mainScreen].bounds.size.height / 667)


#endif /* GXBMacrosDefine_h */

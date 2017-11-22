//
//  NSString+formatChecks.h
//  GXBaseExample
//
//  Created by WangLinfang on 17/4/1.
//  Copyright © 2017年 guoxin. All rights reserved.
//

/*
 密码、姓名、昵称等格式校验
 */
#import <Foundation/Foundation.h>

@interface NSString (formatChecks)

#pragma mark--校验密码格式
/**
 *  校验密码格式
 *
 *  @return 校验结果
 */
-(NSString*)checkPassword;
#pragma mark--判断字符串是否是纯汉字
/**
 *  判断字符串是否是纯汉字
 *
 *  @return 结果
 */
-(BOOL)isChinese;

#pragma mark--校验姓名格式
/**
 *  校验姓名格式
 *
 *  @return 校验结果
 */
-(NSString*)checkName;
#pragma mark--校验昵称
/**
 *  校验昵称
 *
 *  @return 校验结果
 */
-(NSString*)checkNickName;





@end

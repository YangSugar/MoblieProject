//
//  NSString+formatChecks.m
//  GXBaseExample
//
//  Created by WangLinfang on 17/4/1.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "NSString+formatChecks.h"

@implementation NSString (formatChecks)

#pragma mark--校验密码格式
-(NSString*)checkPassword
{
    BOOL isContainSymbol=NO;
    BOOL isContainNum=NO;
    BOOL isContainLetter = NO;
    NSMutableString*psStr=[[NSMutableString alloc]init];
    
    if(self.length<6)
    {
        return @"密码长度不得小于6位";
    }
    for(int i=0;i<self.length;i++)
    {
        char character=[self characterAtIndex:i];
        if((character>=21&&character<=47)||(character>=58&&character<=64)||(character>=91&&character<=96)||(character>=123&&character<=126))
        {
            isContainSymbol=YES;
            [psStr appendString:[NSString stringWithFormat:@"%c",character]];
        }
        if(character>=48&&character<=57)
        {
            isContainNum=YES;
            [psStr appendString:[NSString stringWithFormat:@"%c",character]];
        }
        if((character>=65&&character<=90)||(character>=97&&character<=122))
        {
            isContainLetter=YES;
            [psStr appendString:[NSString stringWithFormat:@"%c",character]];
        }
    }
    if(![psStr isEqualToString:self])
    {
        return @"密码中含有非法字符";
    }
    if(!((isContainLetter&&isContainNum)||(isContainLetter&&isContainSymbol)||(isContainNum&&isContainSymbol)))
    {
        return @"密码需要包含字母、数字、常用符号中的至少两种组合";
    }
    return @"yes";
}

#pragma mark--判断字符串是否是纯汉字
-(BOOL)isChinese
{
    NSString*str=[self copy];
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}
#pragma mark--校验姓名格式
-(NSString*)checkName
{
    if(self.length==0)
    {
        return @"请输入姓名";
    }
    if(![[self stringByReplacingOccurrencesOfString:@"·" withString:@""] isChinese])
    {
        return @"姓名中不得包含除汉字和·之外的其他字符";
    }
    if([[self stringByReplacingOccurrencesOfString:@"·" withString:@""] length]<2)
    {
        return @"姓名不得少于2个汉字";
    }
    if(self.length>20)
    {
        return @"姓名长度不得大于20位";
    }
    if([self hasPrefix:@"·"])
    {
        return @"姓名不得以“·”开头";
    }
    if([self hasSuffix:@"·"])
    {
        return @"姓名不得以“·”结尾";
    }
    int numbersOfDow=0;
    for(int i=0;i<self.length;i++)
    {
        NSString*subStr=[self substringWithRange:NSMakeRange(i, 1)];
        if([subStr isEqualToString:@"·"])
        {
            numbersOfDow++;
        }
    }
    if(numbersOfDow>1)
    {
        return @"姓名中最多只能够包含一个“·”";
    }
    return @"yes";
}
#pragma mark--校验昵称
-(NSString*)checkNickName
{
    if(self.length==0)
    {
        return @"昵称不可以为空";
    }
    if(self.length<2)
    {
        return @"昵称的长度不得小于2位";
    }
    if(self.length>16)
    {
        return @"昵称的长度不得大于16位";
    }
    BOOL isContainNum=NO;
    BOOL isContainLetter = NO;
    
    int numberOfNum=0;
    NSString*nickStr=[self copy];
    for(int i=0;i<self.length;i++)
    {
        char character=[self characterAtIndex:i];
        if(character>=48&&character<=57)
        {
            isContainNum=YES;
            numberOfNum++;
            nickStr=[nickStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c",character] withString:@""];
        }
        if((character>=65&&character<=90)||(character>=97&&character<=122))
        {
            isContainLetter=YES;
            nickStr=[nickStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c",character] withString:@""];
        }
    }
    if(numberOfNum>=5)
    {
        return @"昵称中数字的个数不得大于等于5";
    }
    if(![nickStr isChinese]&&nickStr.length)
    {
        return @"昵称只能由字母、数字、汉字组成";
    }
    if(!isContainLetter&&!nickStr.length)
    {
        return @"昵称不能只由数字组成";
    }
    return @"yes";
}

@end

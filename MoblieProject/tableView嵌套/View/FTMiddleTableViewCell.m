//
//  FTMiddleTableViewCell.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/18.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTMiddleTableViewCell.h"
#import "FSLoopScrollView.h"


@implementation FTMiddleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        FSLoopScrollView *loopView = [FSLoopScrollView loopTitleViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50) isTitleView:YES titleImgArr:@[@"home_ic_new",@"home_ic_hot",@"home_ic_new",@"home_ic_new",@"home_ic_hot"]];
        loopView.titlesArr = @[@"这是一个简易的文字轮播",
                               @"This is a simple text rotation",
                               @"นี่คือการหมุนข้อความที่เรียบง่าย",
                               @"Это простое вращение текста",
                               @"이것은 간단한 텍스트 회전 인"];
        loopView.tapClickBlock = ^(FSLoopScrollView *loopView){
            NSString *message = [NSString stringWithFormat:@"老%ld被点啦",(long)loopView.currentIndex+1];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"大顺啊" message:message delegate:self cancelButtonTitle:@"love you" otherButtonTitles:nil, nil];
            [alert show];
        };
        [self addSubview:loopView];
    }
    return self;
}

@end

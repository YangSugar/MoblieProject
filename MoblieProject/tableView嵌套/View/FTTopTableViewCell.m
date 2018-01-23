//
//  FTTopTableViewCell.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/18.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTTopTableViewCell.h"
#import "FSLoopScrollView.h"

@implementation FTTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        FSLoopScrollView *loopView = [FSLoopScrollView loopImageViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) isHorizontal:YES];
        loopView.imgResourceArr = @[@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg",
                                    @"http://img06.tooopen.com/images/20161123/tooopen_sy_187628854311.jpg",
                                    @"http://img07.tooopen.com/images/20170306/tooopen_sy_200775896618.jpg",
                                    @"http://img06.tooopen.com/images/20170224/tooopen_sy_199503612842.jpg",
                                    @"http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg"];
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

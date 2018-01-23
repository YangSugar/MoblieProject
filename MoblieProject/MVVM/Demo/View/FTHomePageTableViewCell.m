//
//  FTHomePageTableViewCell.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/10.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTHomePageTableViewCell.h"
#import "FTHomePageTableCellViewModel.h"


@interface FTHomePageTableViewCell ()

@property (strong, nonatomic) UIImageView *recipeAvatar;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;

@end


@implementation FTHomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.recipeAvatar];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descLabel];
    }
    return self;
}


- (void)bindDataWithViewModel:(FTHomePageTableCellViewModel *)viewModel {
    
    self.titleLabel.text = viewModel.title;
    
    //如果菜谱标题中包含西红柿三个字，则字体颜色变化
    if ([viewModel.title containsString:@"西红柿"]) {
        self.titleLabel.textColor = viewModel.titleColor;
    }
    self.descLabel.text = viewModel.desc;
}



#pragma mark - setters and getters
- (UIImageView *)recipeAvatar{
    if (_recipeAvatar == nil) {
        _recipeAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 60, 60)];
    }
    return _recipeAvatar;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, screenSize.width-80, 30)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (_descLabel == nil) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, screenSize.width-80, 30)];
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.font = [UIFont systemFontOfSize:12];
    }
    return _descLabel;
}


@end

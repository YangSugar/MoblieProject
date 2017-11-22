//
//  UIViewController+GXLoadingTips.m
//  GXApp
//
//  Created by zhudong on 16/7/21.
//  Copyright © 2016年 yangfutang. All rights reserved.
//


#import "UIView+GXLoadingTips.h"
#import "GXBMacrosDefine.h"
#import <objc/runtime.h>

#define AlertWidth 150
#define AlertHeight 80
#define LoadingAlertHeight 105
#define LoadingTopMargin 20
#define LoadingMiddleMargin 15
#define LoadingBottomMargin 22
#define CornerRadius 10
#define Margin 8
#define ScreenSize self.bounds.size
#define alertInterVal 3

const void *alertViewKey = @"alertViewKey";
const void *timerKey = @"timerKey";
const void *isBGClearKey = @"isBGClearKey";

@interface UIViewController()
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) BOOL isShowLoading;
@end
@implementation UIView (GXLoadingTips)

- (void)showLoadingWithTitle:(NSString *)title isClear:(BOOL)isClear {
    self.isBGClear = isClear;
    [self showLoadingWithTitle:title];
}

- (void)showLoadingWithTitle:(NSString *)title{
    if (self.isShowLoading) return;
    self.isShowLoading=YES;
    [self showWithImage:@"loading" withTitle:title];
}
- (void)timeChange:(NSTimer *)timer{
    UIImageView *iconV = timer.userInfo;
    iconV.transform = CGAffineTransformRotate(iconV.transform, M_PI * 0.1);
}
- (void)showWithImage:(NSString *)imageName withTitle:(NSString *)title{
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = CornerRadius;
    view.layer.masksToBounds = YES;
    if (self.isBGClear == false) {
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }else{
        view.backgroundColor = [UIColor clearColor];
    }
    
    
    self.alertView = view;
    NSInteger  scale = [UIScreen mainScreen].scale;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ViewControllerLoadingTips.bundle/%@@%zdx.png",imageName, scale]];
    UIImageView *iconV = [[UIImageView alloc] initWithImage:image];
    [iconV sizeToFit];
    CGFloat iconX = (AlertWidth - iconV.bounds.size.width) * 0.5;
    iconV.frame = CGRectMake(iconX,Margin, iconV.bounds.size.width, iconV.bounds.size.height);

    if (self.isShowLoading==YES) {
        iconV.frame = CGRectMake(iconX,LoadingTopMargin, iconV.bounds.size.width, iconV.bounds.size.height);
    }
    [view addSubview:iconV];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    UIFont *labelFont = [UIFont systemFontOfSize:14];
    label.font = labelFont;
    label.numberOfLines = 0;
    label.text = title;
    
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(AlertWidth - 2 * Margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:labelFont} context:nil].size;
    CGFloat labelX = (AlertWidth - titleSize.width) * 0.5;
    CGFloat labelY = CGRectGetMaxY(iconV.frame) + Margin;
    if (self.isShowLoading==YES) {
        labelY =CGRectGetMaxY(iconV.frame) + LoadingMiddleMargin;
    }
    
    label.frame = CGRectMake(labelX, labelY, titleSize.width, titleSize.height);
    
    [view addSubview:label];
    
    CGFloat alertH;
    if (title.length == 0) {
        alertH = CGRectGetMaxY(label.frame) - CGRectGetMinY(iconV.frame) + Margin;
        if(self.isShowLoading==YES){
         alertH = CGRectGetMaxY(label.frame) - CGRectGetMinY(iconV.frame) + LoadingBottomMargin;
        }
    }else{
        alertH = CGRectGetMaxY(label.frame) - CGRectGetMinY(iconV.frame) + 2 * Margin;
        if(self.isShowLoading==YES){
            alertH = CGRectGetMaxY(label.frame) - CGRectGetMinY(iconV.frame) + 1.5*LoadingBottomMargin;
        }
    }
    
    CGFloat alertW = AlertWidth;
    CGFloat alertX = (self.bounds.size.width - alertW) * 0.5;
    CGFloat alertY = (self.bounds.size.height - alertH) * 0.5 * 0.8;
    view.frame = CGRectMake(alertX, alertY, alertW, alertH);
    
    [self addSubview:view];
    [self bringSubviewToFront:view];
    
    if ([imageName isEqualToString:@"loading"]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(timeChange:) userInfo:iconV repeats:YES];
    }else{
        self.timer = nil;
    }
}
- (void)showSuccessWithTitle:(NSString *)title{

    if (self.isShowLoading) return;
    self.isShowLoading=YES;
    [self showWithImage:@"成功" withTitle:title];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(alertInterVal * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeTipView];
    });
    
}
- (void)showFailWithTitle:(NSString *)title{
    if (self.isShowLoading) return;
    self.isShowLoading=YES;
    [self showWithImage:@"失败" withTitle:title];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(alertInterVal * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeTipView];
    });
    
}
- (void)removeTipView{
    [self.alertView removeFromSuperview];
    self.isShowLoading = NO;
    if (self.timer) {
        [self.timer invalidate];
    }
}
- (NSTimer *)timer{
    return objc_getAssociatedObject(self, timerKey);
}
- (void)setTimer:(NSTimer *)timer{
    objc_setAssociatedObject(self, timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setAlertView:(UIView *)alertView{
    objc_setAssociatedObject(self, alertViewKey, alertView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)alertView{
    return objc_getAssociatedObject(self, alertViewKey);
}
-(void)setIsShowLoading:(BOOL)isShowLoading
{
    objc_setAssociatedObject(self, @selector(isShowLoading), @(isShowLoading), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isShowLoading
{
    return [objc_getAssociatedObject(self, @selector(isShowLoading))boolValue];
}

-(void)setIsBGClear:(BOOL)isBGClear
{
    objc_setAssociatedObject(self, @selector(isBGClear), @(isBGClear), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isBGClear
{
    return [objc_getAssociatedObject(self, @selector(isBGClear)) boolValue];
}

@end

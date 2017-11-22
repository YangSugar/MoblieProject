//
//  GXBViewController.h
//  GXBaseExample
//
//  Created by Vision on 2017/3/21.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GXRightItemBlock)(NSInteger index, UIButton *btn);


@interface GXBViewController : UIViewController

@property (nonatomic, copy) GXRightItemBlock gx_rightItemsBlock;

//主色 默认白色  请提前设置
@property (nonatomic, copy) UIColor *navBarColor;

#pragma mark - title
- (void)gx_configNavBarWithTitle:(NSString *)title
                       tintColor:(UIColor *)tintColor;

- (void)gx_configNavBarWithCustomView:(UIView *)view;

#pragma mark - left
- (void)gx_addBackItem;
- (void)gx_addBackItemWithtitle:(NSString *)title;
- (void)gx_addBackItemWithImage:(NSString *)imageName
                           zoom:(CGFloat)zoom;
- (void)gx_addBackItemWithCustomView:(UIView *)view;

#pragma mark - right
- (void)gx_addRightItemWithtitle:(NSString *)title;
- (void)gx_addRightItemWithImage:(NSString *)imageName
                            zoom:(CGFloat)zoom;
- (void)gx_addRightItemWithImage:(NSString *)imageName
                            zoom:(CGFloat)zoom
                          action:(SEL)action;
- (void)gx_addRightItemWithtitle:(NSString *)title action:(SEL)action;
- (void)gx_addRightItemWithCustomView:(UIView *)view;
- (void)gx_addRightItemsWithImages:(NSArray *)images;



#pragma mark - animation
- (void)gx_hideNavigationBar:(BOOL)hide
                    animated:(BOOL)animated
                      finish:(void(^)(void))finishBlock;
- (void)gx_showNavigationBar:(BOOL)hide
                    animated:(BOOL)animated
                      finish:(void(^)(void))finishBlock;

#pragma mark - overWrite
- (void)gx_backButtonItemClick;
- (void)gx_rightButtonItemClick;


@end

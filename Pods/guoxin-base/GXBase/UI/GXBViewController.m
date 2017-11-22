//
//  GXBViewController.m
//  GXBaseExample
//
//  Created by Vision on 2017/3/21.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "GXBViewController.h"

@interface GXBViewController ()

@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation GXBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navBarColor = [UIColor whiteColor];

    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  title
- (void)gx_configNavBarWithTitle:(NSString *)title
                       tintColor:(UIColor *)tintColor {
    
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    [self gx_configNavBarWithCustomView:self.titleButton];
    self.navigationController.navigationBar.barTintColor = tintColor;

}

- (void)gx_configNavBarWithCustomView:(UIView *)view {
    
    self.navigationItem.titleView = view;
}

#pragma mark - left
- (void)gx_addBackItem {
    
    [self.leftButton setImage:[UIImage imageNamed:@"gxb_nav_back"]
                     forState:UIControlStateNormal];
    self.leftButton.frame = CGRectMake(0, 0, 21, 21);
    self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
}

- (void)gx_addBackItemWithtitle:(NSString *)title {
    
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.leftButton.frame = CGRectMake(0, 0, rect.size.width + 10, rect.size.height);
    self.leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);

}
- (void)gx_addBackItemWithImage:(NSString *)imageName
                           zoom:(CGFloat)zoom {

    UIImage *image = [UIImage imageNamed:imageName];
    [self.leftButton setImage:image
                     forState:UIControlStateNormal];
    self.leftButton.frame = CGRectMake(0, 0, image.size.width * zoom, image.size.height * zoom);
    self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    
}

- (void)gx_addBackItemWithCustomView:(UIView *)view {
    
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
#pragma mark - right
- (void)gx_addRightItemWithtitle:(NSString *)title {

    [self.rightButton setTitle:title forState:UIControlStateNormal];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.rightButton.frame = CGRectMake(0, 0, rect.size.width + 10, rect.size.height);
    self.rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
}

- (void)gx_addRightItemWithtitle:(NSString *)title action:(SEL)action {
    [self gx_addRightItemWithtitle:title];
    [self.rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}


- (void)gx_addRightItemsWithImages:(NSArray *)images {
    CGFloat margin = 0, width = 35.0;
    UIView *container = [[UIView alloc] init];
    container.frame = CGRectMake(0, 0, width * images.count + margin * (images.count - 1), width);
    
    for (NSInteger i = 0; i < images.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((margin + width) * i, 0, width, width);
        button.tag = i + 1000;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        [button setImage:images[i] forState:UIControlStateNormal];
        [container addSubview:button];
        [button addTarget:self action:@selector(gx_rightButtomsItemsClickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:container];
    self.navigationItem.rightBarButtonItem = item;
}



- (void)gx_addRightItemWithImage:(NSString *)imageName
                            zoom:(CGFloat)zoom {
    UIImage *image = [UIImage imageNamed:imageName];
    [self.rightButton setImage:image
                     forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(0, 0, image.size.width * zoom, image.size.height * zoom);
    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
}

- (void)gx_addRightItemWithImage:(NSString *)imageName
                            zoom:(CGFloat)zoom
                          action:(SEL)action {
    [self gx_addRightItemWithImage:imageName zoom:zoom];
    [self.rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}


- (void)gx_addRightItemWithCustomView:(UIView *)view {
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)gx_rightButtomsItemsClickButton:(UIButton *)btn{
    if (_gx_rightItemsBlock) {
        _gx_rightItemsBlock(btn.tag - 1000, btn);
    }
}





#pragma mark - animation
- (void)gx_hideNavigationBar:(BOOL)hide
                    animated:(BOOL)animated
                      finish:(void(^)(void))finishBlock {

}

- (void)gx_showNavigationBar:(BOOL)hide
                    animated:(BOOL)animated
                      finish:(void(^)(void))finishBlock {

}

#pragma mark - overWrite
- (void)gx_backButtonItemClick {
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)gx_rightButtonItemClick {

}

#pragma mark - private method
- (UIButton *)creatDefaultButtonItemWithImageName:(NSString *)imageNamge
                                           Action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setBackgroundColor:[UIColor clearColor]];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [button setImage:[UIImage imageNamed:imageNamge] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [_titleButton setTitleColor:self.navBarColor forState:UIControlStateNormal];
    }
    return _titleButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitleColor:self.navBarColor forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_leftButton addTarget:self
                        action:@selector(gx_backButtonItemClick)
              forControlEvents:UIControlEventTouchUpInside];
        [self gx_addBackItemWithCustomView:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_rightButton setTitleColor:self.navBarColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
       [ _rightButton addTarget:self
                         action:@selector(gx_rightButtonItemClick)
               forControlEvents:UIControlEventTouchUpInside];
        [self gx_addRightItemWithCustomView:_rightButton];
    }
    return _rightButton;
}

- (void)setNavBarColor:(UIColor *)navBarColor {
    _navBarColor = [navBarColor copy];
    if (_titleButton) {
        [_titleButton setTitleColor:_navBarColor forState:UIControlStateNormal];
    }
    if (_leftButton) {
        [_leftButton setTitleColor:_navBarColor forState:UIControlStateNormal];
    }
    if (_rightButton) {
        [_rightButton setTitleColor:_navBarColor forState:UIControlStateNormal];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

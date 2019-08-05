//
//  BaseViewController.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = K_NavColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:K_333Color}];
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self addReturnBackButton];
    }
    
    /** 导航栏背景图 */
    if ([self respondsToSelector:@selector(backgroundImage)]) {
        UIImage *bgimage = [self navBackgroundImage];
        [self setNavigationBack:bgimage];
    }
    /** 富文本标题 */
    if ([self respondsToSelector:@selector(setTitle)]) {
        NSMutableAttributedString *titleAttri = [self setTitle];
        [self set_Title:titleAttri];
    }
    
    /** 左按钮（图片） */
    if (![self leftButton]) {
        [self configLeftBaritemWithImage];
    }
    /** 右按钮（图片） */
    if (![self rightButton]) {
        [self configRightBaritemWithImage];
    }
    
    //设置侧滑的距离
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 120.0;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /** 导航栏背景色 */
    if ([self respondsToSelector:@selector(set_navigationBackgroundColor)]) {
        UIColor *backgroundColor = [self set_navigationBackgroundColor];
        UIImage *bgimage = [self imageWithColor:backgroundColor];
        [self.navigationController.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
    }
    
    /** 隐藏导航栏底线 */
    UIImageView *blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    blackLineImageView.hidden = NO;
    if ([self respondsToSelector:@selector(hideNavigationBottomLine)]) {
        if ([self hideNavigationBottomLine]) {
            blackLineImageView.hidden = YES;
        }
    }
}


#pragma mark -
/** setBackgroundImage */
- (void)setNavigationBack:(UIImage *)image {
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
    [self.navigationController.navigationBar setShadowImage:image];
}



/** 是否已有左按钮 */
- (BOOL)leftButton {
    BOOL isleft = [self respondsToSelector:@selector(set_leftButton)];
    if (isleft) {
        UIButton *leftbutton = [self set_leftButton];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
    return isleft;
}
/** 是否已有右按钮 */
- (BOOL)rightButton {
    BOOL isright = [self respondsToSelector:@selector(set_rightButton)];
    if (isright) {
        UIButton *right_button = [self set_rightButton];
        [right_button addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }
    return isright;
}

/** 设置左按钮图片 */
- (void)configLeftBaritemWithImage {
    if ([self respondsToSelector:@selector(set_leftBarButtonItemWithImage)]) {
        UIImage *image = [self set_leftBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self  action:@selector(left_click:)];
        self.navigationItem.backBarButtonItem = item;
    }
}
/** 设置右按钮图片 */
- (void)configRightBaritemWithImage {
    if ([self respondsToSelector:@selector(set_rightBarButtonItemWithImage)]) {
        UIImage *image = [self set_rightBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self  action:@selector(right_click:)];
        self.navigationItem.rightBarButtonItem = item;
    }
}


- (void)left_click:(id)sender {
    if ([self respondsToSelector:@selector(left_button_event:)]) {
        [self left_button_event:sender];
    }
}

- (void)right_click:(id)sender {
    if ([self respondsToSelector:@selector(right_button_event:)]) {
        [self right_button_event:sender];
    }
}




/** 返回按钮事件 */
- (void)addReturnBackButton {
    UIButton *returnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBack. frame = CGRectMake(15, 0, 38, 44);
    [returnBack setImage:[UIImage imageNamed:@"Navi_back"] forState:UIControlStateNormal];
    returnBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [returnBack addTarget:self action:@selector(clickReturnBackEvent)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnBackItem = [[UIBarButtonItem alloc] initWithCustomView:returnBack];
    //设置导航栏的leftButton
    self.navigationItem.leftBarButtonItem = returnBackItem;
}
- (void)clickReturnBackEvent {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/** 设置富文本标题 */
- (void)set_Title:(NSMutableAttributedString *)title {
    UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    navTitleLabel.numberOfLines = 0;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
    navTitleLabel.textColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
    [navTitleLabel addGestureRecognizer:tap];
    self.navigationItem.titleView = navTitleLabel;
}
- (void)titleClick:(UIGestureRecognizer *)Tap {
    UIView *view = Tap.view;
    if ([self respondsToSelector:@selector(title_click_event:)]) {
        [self title_click_event:view];
    }
}

/** 设置左侧导航栏的左侧title按钮 */
- (void)setNavgationBarLeftTitle:(NSString *)title {
    self.navigationItem.leftBarButtonItem = nil;
    if (title) {
        UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftbutton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftbutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        leftbutton.frame = CGRectMake(0.0, 0.0, 120.0, 44.0);
        [leftbutton setTitle:title forState:UIControlStateNormal];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
}
/** 设置左侧导航栏的左侧图片按钮 */
- (void)setNavgationBarLeftImageStr:(NSString *)imageStr {
    self.navigationItem.leftBarButtonItem = nil;
    UIImage *leftImage = [UIImage imageNamed:imageStr];
    if (leftImage) {
        UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftbutton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftbutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        leftbutton.frame = CGRectMake(0.0, 0.0, 120.0, 44.0);
        [leftbutton setImage:leftImage forState:UIControlStateNormal];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
}
/** 设置右侧导航栏的右侧title按钮 */
- (void)setNavgationBarRightTitle:(NSString *)title {
    self.navigationItem.rightBarButtonItem = nil;
    if (title) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat titleWidth = [title sizeWithFont:rightButton.titleLabel.font maxW:MAXFLOAT].width;
        [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        rightButton.frame = CGRectMake(0.0, 0.0, titleWidth, 44.0);
        [rightButton setTitle:title forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = item;
    }
}
/** 设置右侧导航栏的右侧图片按钮 */
- (void)setNavgationBarRightImageStr:(NSString *)imageStr {
    self.navigationItem.rightBarButtonItem = nil;
    UIImage *rightImage = [UIImage imageNamed:imageStr];
    if (rightImage) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:rightImage forState:UIControlStateNormal];
        [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        rightButton.frame = CGRectMake(0.0, 0.0, 40.0, 44.0);
        [rightButton addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = item;
    }
}






#pragma mark - private method


//找查到Nav底部的黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        imageView.image = [UIImage imageNamed:@"navBar_bottom_line"];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

//根据颜色生成纯色图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

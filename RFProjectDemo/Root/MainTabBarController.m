//
//  MainTabBarController.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"

#import "HomeViewController.h"
#import "MineViewController.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetMake(0, -3.5)];
    /* 设置Tabbara样式 */
    [self customizeTabBarAppearance];
    
    if (@available(iOS 12.1, *)) {
        //iOS12.1的BUG tabbar跳动
        [[UITabBar appearance] setTranslucent:NO];
    }
    
    return (self = (MainTabBarController *)tabBarController);
}

/* Controllers */
- (NSArray *)viewControllers {
    UIViewController *tab1Navi = [[BaseNavigationController alloc] initWithRootViewController:[HomeViewController new]];
    UIViewController *tab2Navi = [[BaseNavigationController alloc] initWithRootViewController:[MineViewController new]];
    
    NSArray *viewControllers = @[tab1Navi, tab2Navi];
    return viewControllers;
}
/* Tabbar Items */
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *tab1BarItemsAttributes = @{
                                             CYLTabBarItemTitle : @"首页",
                                             CYLTabBarItemImage : @"Tabbar_home",
                                             CYLTabBarItemSelectedImage : @"Tabbar_homeH",
                                             };
    NSDictionary *tab2BarItemsAttributes =  @{
                                              CYLTabBarItemTitle : @"我的",
                                              CYLTabBarItemImage : @"Tabbar_mine",
                                              CYLTabBarItemSelectedImage : @"Tabbar_mineH"
                                              };
    NSArray *tabBarItemsAttributes = @[
                                       tab1BarItemsAttributes,
                                       tab2BarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}
/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
- (void)customizeTabBarAppearance {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:COLOR_GRAY_STR];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = K_MainColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"TabBar_top_line"]];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
    
}



@end

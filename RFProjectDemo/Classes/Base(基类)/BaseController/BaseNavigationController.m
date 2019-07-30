//
//  BaseNavigationController.m
//  MaYiBang
//
//  Created by jiesheng on 2019/4/1.
//  Copyright © 2019 捷晟数据科技. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //  设置状态栏颜色
        if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    }
    [super pushViewController:viewController animated:animated];
}

@end

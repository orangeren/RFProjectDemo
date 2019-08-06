//
//  AppBaseConfig.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "AppBaseConfig.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "ReachabilityTools.h"
#import "UmShareHelper.h"
#import "DHGuidePageHUD.h"

@implementation AppBaseConfig

#pragma mark --- Base Config -------------------------------------------------
+ (void)startAppBaseConfig:(NSDictionary *)launchOptions {
    /** 设置导航栏样式 */
    [self navigationBarConfig];
    
    /* 网络请求时的转圈 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    /* 配置请求基础参数 */
    [self configNetworkBaseParam];
    
    /* IQKeyboardManager */
    [self configIQKeyboardManager];
    
    /* 网络访问权限监听 */
    [ReachabilityTools networkAccessibityMonitoring];
    
    /* 友盟分享 */
    [UmShareHelper addUmsocialManager];
    [UmShareHelper configUSharePlatforms];
    
    
    /** 引导页 - App生命期间只运行一次 */
    [self addGuidePage];
    
    
}




/**
 配置请求基础参数
 */
+ (void)configNetworkBaseParam {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = BaseUrl;
}


/**
 IQKeyboardManager
 */
+ (void)configIQKeyboardManager {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES; //  点击空白页取消键盘
}


/**
 引导页 - App生命期间只运行一次
 */
+ (void)addGuidePage {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        NSArray *imageNameArray = @[@"GuidePage1", @"GuidePage2", @"GuidePage3", @"GuidePage4", @"GuidePage5"];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:kKeyWindow.frame imageNameArray:imageNameArray buttonIsHidden:NO];
        [kKeyWindow addSubview:guidePage];
    }
}

/**
 导航栏样式设置
 */
+ (void)navigationBarConfig {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = K_NavColor;
//    [navigationBar setShadowImage:[UIImage new]];
    if (@available(iOS 8.2, *)) {
        [navigationBar setTitleTextAttributes:@{
                                                NSFontAttributeName:[UIFont systemFontOfSize:fitW(18) weight:UIFontWeightMedium],
                                                NSForegroundColorAttributeName:K_333Color
                                                }];
    }
    
    
}

@end

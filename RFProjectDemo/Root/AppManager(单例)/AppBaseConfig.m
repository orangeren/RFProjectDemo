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

@implementation AppBaseConfig

#pragma mark --- Base Config -------------------------------------------------
+ (void)startAppBaseConfig:(NSDictionary *)launchOptions {
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

@end

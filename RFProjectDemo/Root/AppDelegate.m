//
//  AppDelegate.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "AppDelegate.h"
#import "RTRootNavigationController.h"
#import "MainTabBarController.h"

#import "AppBaseConfig.h"
#import "DHGuidePageHUD.h"

#import <UMShare/UMShare.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /** 设置rootController */
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[RTRootNavigationController alloc] initWithRootViewController:[MainTabBarController new]];
    [self.window makeKeyAndVisible];
    
    
    [AppBaseConfig startAppBaseConfig:launchOptions];
    
    
    /** 引导页 - App生命期间只运行一次 */
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        NSArray *imageNameArray = @[@"GuidePage1", @"GuidePage2", @"GuidePage3", @"GuidePage4", @"GuidePage5"];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.frame imageNameArray:imageNameArray buttonIsHidden:NO];
        [self.window addSubview:guidePage];
    }
    
    
    return YES;
}






#pragma mark - 设置系统回调
// NOTE: iOS 低于 9.0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
    }
    return result;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end

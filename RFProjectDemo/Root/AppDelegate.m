//
//  AppDelegate.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"

#import "AppBaseConfig.h"
#import "DHGuidePageHUD.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /** 设置rootController */
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [MainTabBarController new];
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


@end

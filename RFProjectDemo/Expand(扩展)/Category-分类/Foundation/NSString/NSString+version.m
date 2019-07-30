//
//  NSString+version.m
//  WeiLiHuaiOS
//
//  Created by yangpenghua on 2017/10/23.
//  Copyright © 2018年 JieSheng. All rights reserved.
//

#import "NSString+version.h"

@implementation NSString (version)

//  获取app 版本
+ (long)appVersionLongValue {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appCurrentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    long appVersion = [appCurrentVersion longLongValue];
    return appVersion;
}

@end

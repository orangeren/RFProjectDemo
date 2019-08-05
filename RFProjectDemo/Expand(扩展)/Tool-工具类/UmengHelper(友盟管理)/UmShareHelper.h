//
//  UmShareHelper.h
//  RFProjectDemo
//
//  Created by 任 on 2019/8/2.
//  Copyright © 2019 ZXKJ. All rights reserved.
//
/***
 *  分享操作
 *  1.配置 ThirdMacros 中的 AppKey
 *  2.在 AppDelegate 中，调用初始化代码：addUmsocialManager 和 configUSharePlatforms
 *  3.添加白名单
 *  4.添加 URL Types
 */

#import <Foundation/Foundation.h>

@interface UmShareHelper : NSObject

/** 添加友盟统计 */
+ (void)addUmsocialManager;

/* 友盟分享 平台设置 */
+ (void)configUSharePlatforms;


/* 调起分享页面 */
+ (void)shareWithInfo:(NSDictionary *)dict;

@end



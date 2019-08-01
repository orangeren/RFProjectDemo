//
//  ReachabilityTools.h
//  RFProjectDemo
//
//  Created by 任 on 2019/8/1.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachabilityTools : NSObject

/** 监听网络权限变化 */
+ (void)networkAccessibityMonitoring;

/** 监听网络状态 */
+ (void)networkStatusMonitoring;


@end



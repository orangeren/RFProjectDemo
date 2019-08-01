//
//  ReachabilityTools.m
//  RFProjectDemo
//
//  Created by 任 on 2019/8/1.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "ReachabilityTools.h"
#import <CoreTelephony/CTCellularData.h>
#import "ZYNetworkAccessibity.h"

@implementation ReachabilityTools

/** 监听网络权限 */
+ (void)networkAccessibityMonitoring {
    [ZYNetworkAccessibity setAlertEnable:YES];
    [ZYNetworkAccessibity setStateDidUpdateNotifier:^(ZYNetworkAccessibleState state) {
        NSLog(@"setStateDidUpdateNotifier > %zd", state);
        switch (state) {
            case ZYNetworkRestricted: // 网络受限
            {
                
            }
                break;
                
            default:
                break;
        }
    }];
    [ZYNetworkAccessibity start];
}


/** 监听网络状态 */
+ (void)networkStatusMonitoring {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    
    [manager startMonitoring];
}



@end

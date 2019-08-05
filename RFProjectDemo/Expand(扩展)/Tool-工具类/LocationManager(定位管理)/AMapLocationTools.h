//
//  AMapLocationTools.h
//  RFProjectDemo
//
//  Created by 任 on 2019/8/1.
//  Copyright © 2019 ZXKJ. All rights reserved.
//
//  定位 - 高德地图api

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void (^CompletedLoctionBlock)(NSString *latitudeString, NSString *longitudeString);

@interface AMapLocationTools : NSObject

/** 开始设置定位, 并且放回需要持有 AMapLocationManager 这个对象 */
+ (void)startLocationWithComplish:(CompletedLoctionBlock)locationBlock;


/** 获取纬度 */
+ (NSString *)latitudeString;
/** 获取经度 */
+ (NSString *)longitudeString;

@end



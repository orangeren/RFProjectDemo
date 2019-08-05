//
//  AMapLocationTools.m
//  RFProjectDemo
//
//  Created by 任 on 2019/8/1.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "AMapLocationTools.h"
#import "DeviceAuthTools.h"

#define AMAPLocationLatitudeKey               @"AMAPLocationLatitudeKey"
#define AMAPLocationLongitudeKey              @"AMAPLocationLongitudeKey"



@implementation AMapLocationTools

+ (void)startLocationWithComplish:(CompletedLoctionBlock)locationBlock {
    if (![DeviceAuthTools Device_Permission_LocationAuth]) {
        [DeviceAuthTools openSetting];
        return;
    }
    
    
    AMapLocationManager *locationManager = [[AMapLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    // 定位超时时间，最低2s，此处设置为2s
    locationManager.locationTimeout = 5;
    [locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        CLLocationCoordinate2D coordinate = location.coordinate;
        if (coordinate.latitude && coordinate.longitude) {
            
            NSString * latStr = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
            NSString * longStr = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
            locationBlock(latStr, longStr);
            
            [[NSUserDefaults standardUserDefaults] setValue:latStr forKey:AMAPLocationLatitudeKey];
            [[NSUserDefaults standardUserDefaults] setValue:longStr forKey:AMAPLocationLongitudeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }]; 
}



/** 获取经度 */
+ (NSString *)longitudeString {
    NSString *longitudeStr = [[NSUserDefaults standardUserDefaults] valueForKey: AMAPLocationLongitudeKey];
    return longitudeStr;
}
/** 获取纬度 */
+ (NSString *)latitudeString {
    NSString *latitudeStr = [[NSUserDefaults standardUserDefaults] valueForKey: AMAPLocationLatitudeKey];
    return latitudeStr;
}

@end

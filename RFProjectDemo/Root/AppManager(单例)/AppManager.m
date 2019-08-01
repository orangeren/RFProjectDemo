//
//  AppManager.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+ (instancetype)sharedInstance {
    static AppManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AppManager new];
    });
    return instance;
}


 




@end

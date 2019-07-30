//
//  BaseRequestSerivce.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "YTKRequest.h"
#import <UIKit/UIKit.h>


typedef void(^successBlock)(NSDictionary *responseDict);
typedef void(^failureBlock)(__kindof YTKBaseRequest *request);


@interface BaseRequestSerivce : YTKRequest

// 是否隐藏请求弹窗
@property (nonatomic, assign) BOOL isHideToast;
// 发起网络请求
- (void)requestWithSuccess:(successBlock)success failure:(failureBlock)failure;

@end



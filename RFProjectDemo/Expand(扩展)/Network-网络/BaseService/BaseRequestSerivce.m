//
//  BaseRequestSerivce.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "BaseRequestSerivce.h"

@implementation BaseRequestSerivce


// 发起网络请求
- (void)requestWithSuccess:(successBlock)success failure:(failureBlock)failure {
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *responseDict = request.responseJSONObject;
        //NSDictionary *dataDict = responseDict[@"result"];
        NSDictionary *dataDict = responseDict;
        if (![dataDict isKindOfClass:[NSDictionary class]]) {
            dataDict = nil;
        }
        //网络请求
        if (DEBUG && isAppOnline == 0) {
            NSLog(@">>网络请求=======================================\nURL: %@\nArgument: %@\nResponseDict: %@", request.response.URL, [self requestArgument], responseDict);
        }
        
        NSString *codeStr = [dataDict[@"code"] description];
        if(![codeStr isEqualToString:k_SuccessCode]) {
            NSString *messageStr = [dataDict[@"msg"] description];
            if (!self.isHideToast) {
                [[UIApplication sharedApplication].keyWindow makeCenterToast:messageStr];
            }
        }
        
        success(dataDict);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (!self.isHideToast) {
            [[UIApplication sharedApplication].keyWindow makeCenterToast:kNetworkConnectFailure];
        }
        //网络请求
        if (DEBUG && isAppOnline == 0) {
            NSLog(@">>网络请求=======================================\nURL: %@\nArgument: %@\nError: %@", request.response.URL, [self requestArgument], request.error);
        }
        
        failure(request);
    }];
}



#pragma mark -- Base Config ---------------------------

// 设置请求方式
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

// 设置json数据格式请求
- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}


@end

//
//  HomeViewModel.m
//  RFProjectDemo
//
//  Created by 任 on 2019/8/1.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

/** 获取首页轮播图 */
- (void)requestHomePageData {
    [AFNetwork GET:@"app/getHomeRotationPic.do" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"renfang - 1");
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"renfang - 2");
    }];
}

@end

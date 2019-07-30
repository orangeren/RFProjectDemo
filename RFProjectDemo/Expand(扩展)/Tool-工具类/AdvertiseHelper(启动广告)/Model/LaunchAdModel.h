//
//  LaunchAdModel.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/30.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaunchAdModel : NSObject
// 广告URL
@property (nonatomic, copy  ) NSString *content;
// 点击打开连接
@property (nonatomic, copy  ) NSString *openUrl;
// 广告停留时间
@property (nonatomic, assign) NSInteger duration;

// 广告分辨率
@property (nonatomic, copy  ) NSString *contentSize;
// 分辨率宽
@property(nonatomic, assign, readonly) CGFloat width;
// 分辨率高
@property(nonatomic, assign, readonly) CGFloat height;



- (instancetype)initWithDict:(NSDictionary *)dict;

@end



//
//  LaunchAdModel.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/30.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "LaunchAdModel.h"

@implementation LaunchAdModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.content = dict[@"content"];
        self.openUrl = dict[@"openUrl"];
        self.duration = [dict[@"duration"] integerValue];
        self.contentSize = dict[@"contentSize"];
    }
    return self;
}

- (CGFloat)height {
    return [[[self.contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}
- (CGFloat)width {
    return [[[self.contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
}

@end

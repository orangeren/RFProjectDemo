//
//  NSDictionary+Additions.m
//  WeiLiHuaiOS
//
//  Created by 朱吉达 on 2017/10/6.
//  Copyright © 2018年 JieSheng. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

- (NSDictionary *)removeForeAndAftWhitespace{
    NSMutableDictionary * dicNow = [[NSMutableDictionary alloc]init];
    for (NSString * keyStr in self.allKeys) {
        id valueStr = self[keyStr];
        valueStr = [valueStr description];
        if ([valueStr isKindOfClass:[NSString class]]) {
            // 字符串去收尾空格
            NSString *vlualeString = [valueStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [dicNow setValue:vlualeString forKey:keyStr];
        }else{
            [dicNow setValue:valueStr forKey:keyStr];
        }
    }
    return dicNow;
}

@end

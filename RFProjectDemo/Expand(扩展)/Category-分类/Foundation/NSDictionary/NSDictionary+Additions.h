//
//  NSDictionary+Additions.h
//  WeiLiHuaiOS
//
//  Created by 朱吉达 on 2017/10/6.
//  Copyright © 2018年 JieSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

/**
 去除字典中 value 首尾空格

 @return 去除之后的字典
 */
-(NSDictionary*)removeForeAndAftWhitespace;
@end

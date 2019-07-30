//
//  NSString+md5.h
//  WeiLiHuaiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2018年 JieSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5)

#pragma mark - 计算当前字符串的 MD5值
/** 计算当前字符串的 MD5值 */
- (NSString *) MD5;

- (NSString *)MD5Hash;
/**  哈希256 */
- (NSString*) sha256;

@end

//
//  UIImageView+instance.h
//  WeiLiHuaiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2018年 JieSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (instance)

+ (UIImageView *)setupImageViewWithImageName:(NSString *)imageName;

/** 创建一个带图片的实例 */
+ (UIImageView *)setupImageViewWithImageName:(NSString *)imageName withSuperView:(UIView *)superView;

+ (UIImageView *)setupImageViewWithImage:(UIImage *)image withSuperView:(UIView *)superView;

@end

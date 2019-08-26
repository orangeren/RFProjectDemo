//
//  UIButton+Addition.h
//  WeiLiHuaiOS
//
//  Created by 朱吉达 on 2018/2/1.
//  Copyright © 2018年 JieSheng. All rights reserved.
//  扩展

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

/** 带动画 显示图片 */
- (void)sd_setImageFadeEffectWithURLstr:(NSString *)imgUrl placeholderImage:(NSString *)imgName;

/** 设置边框虚线 */
- (CAShapeLayer *)setupViewDotWdith:(CGFloat)width dotColor:(UIColor *)color fullLineWidth:(CGFloat)fullWidth blankWidth:(CGFloat)blankWidth;

@end

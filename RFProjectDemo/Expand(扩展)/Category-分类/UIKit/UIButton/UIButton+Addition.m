//
//  UIButton+Addition.m
//  WeiLiHuaiOS
//
//  Created by 朱吉达 on 2018/2/1.
//  Copyright © 2018年 JieSheng. All rights reserved.
//

#import "UIButton+Addition.h"
#import <UIButton+WebCache.h>

@implementation UIButton (Addition)

- (void)sd_setImageFadeEffectWithURLstr:(NSString *)imgUrl placeholderImage:(NSString *)imgName {
    NSURL *url = [NSURL URLWithString:imgUrl];
    [self sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:imgName]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image&&cacheType!=SDImageCacheTypeMemory) {
            self.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                self.alpha = 1;
            }];
        } else {
            self.alpha = 1;
        }
    }];
}


//  设置边框虚线
- (CAShapeLayer*)setupViewDotWdith:(CGFloat)width dotColor:(UIColor *)color fullLineWidth:(CGFloat)fullWidth blankWidth:(CGFloat)blankWidth {
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = color.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.lineWidth = width;
    border.lineCap = @"square";
    if (fullWidth < 1.0) {
        fullWidth = 1.0;
    }
    if (blankWidth < 2.0) {
        blankWidth = 2.0;
    }
    NSNumber *fullwidthNum = [NSNumber numberWithFloat:fullWidth];
    NSNumber *blankwidthNum = [NSNumber numberWithFloat:blankWidth];
    border.lineDashPattern = @[fullwidthNum, blankwidthNum];
    [self.layer addSublayer:border];
    return border;
}


@end

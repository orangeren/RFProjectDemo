//
//  UIView+EaseBlankPage.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/30.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseBlankPageView.h"

@interface UIView (EaseBlankPage)

@property (strong, nonatomic) EaseBlankPageView *blankPageView;

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData reloadButtonBlock:(void(^)(id sender))block;

@end



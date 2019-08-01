//
//  EaseBlankPageView.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/30.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EaseBlankPageType) {
    EaseBlankPageTypeProject = 0,   //默认（图片+按钮）
    EaseBlankPageTypeNoButton,      //默认（图片）
    EaseBlankPageTypeLoadFail       //无网络
    
};


@interface EaseBlankPageView : UIView

// 空白页提示图片
@property (strong, nonatomic) UIImageView *blankImageV;
// 空白页提示文字
@property (strong, nonatomic) UILabel *tipLabel;
// 重新加载按钮
@property (strong, nonatomic) UIButton *reloadButton;
@property (copy, nonatomic  ) void(^reloadButtonBlock)(id sender);

/**
 hasError   : 加载失败  - 先判断 是否失败，再判断 是否有数据
 hasData    : 页面是否有数据
 */
- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData reloadButtonBlock:(void(^)(id sender))block;

@end



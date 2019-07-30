//
//  BaseViewController.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewControllerDataSource<NSObject>
@optional
- (NSMutableAttributedString *)setTitle;
- (UIColor *)set_navigationBackgroundColor;         /** 导航栏背景色 */
- (UIImage *)navBackgroundImage;                    /** 导航栏背景图 */
- (UIButton *)set_leftButton;
- (UIButton *)set_rightButton;
- (UIImage *)set_leftBarButtonItemWithImage;
- (UIImage *)set_rightBarButtonItemWithImage;
- (BOOL)hideNavigationBottomLine;                   /** 隐藏导航栏底线（defalut : NO） */
@end

@protocol BaseViewControllerDelegate <NSObject>
@optional
- (void)left_button_event:(UIButton *)sender;
- (void)right_button_event:(UIButton *)sender;
- (void)title_click_event:(UIView *)sender;
@end



@interface BaseViewController : UIViewController<BaseViewControllerDataSource, BaseViewControllerDelegate>
/* 设置富文本标题 可监听点击标题事件 */
- (void)set_Title:(NSMutableAttributedString *)title;
/* 截获返回事件 */
- (void)clickReturnBackEvent;

/** 设置左侧导航栏的左侧title按钮 */
- (void)setNavgationBarLeftTitle:(NSString *)title;
/** 设置左侧导航栏的左侧图片按钮 */
- (void)setNavgationBarLeftImageStr:(NSString *)imageStr;

/** 设置右侧导航栏的右侧title按钮 */
- (void)setNavgationBarRightTitle:(NSString *)title;
/** 设置右侧导航栏的右侧图片按钮 */
- (void)setNavgationBarRightImageStr:(NSString *)imageStr;
@end



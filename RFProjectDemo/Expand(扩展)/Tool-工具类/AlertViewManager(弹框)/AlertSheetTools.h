//
//  AlertSheetTools.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockActionClick)(NSInteger index);

@interface AlertSheetTools : NSObject

/** Alert - 标题-文字-确认 */
+ (void)alertTitle:(NSString *)title message:(NSString *)msg;

/** Alert */
+ (void)alertTitle:(NSString *)title message:(NSString *)msg arrTitleAction:(NSArray *)arrTitle superVC:(UIViewController *)superVC blockClick:(BlockActionClick)blockClick;

/** Sheet */
+ (void)sheetTitle:(NSString *)title message:(NSString *)msg arrTitleAction:(NSArray *)arrTitle superVC:(UIViewController *)superVC blockClick:(BlockActionClick)blockClick;

@end



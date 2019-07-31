//
//  ToolsAlertSheet.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "ToolsAlertSheet.h"

@implementation ToolsAlertSheet

+ (void)alertTitle:(NSString *)title message:(NSString *)msg arrTitleAction:(NSArray *)arrTitle superVC:(UIViewController *)superVC blockClick:(BlockActionClick)blockClick {
    
    [self AlertSheetTitle:title message:msg arrTitleAction:arrTitle style:UIAlertControllerStyleAlert superVC:superVC blockClick:blockClick];
}

+ (void)sheetTitle:(NSString *)title message:(NSString *)msg arrTitleAction:(NSArray *)arrTitle superVC:(UIViewController *)superVC blockClick:(BlockActionClick)blockClick {
    
    [self AlertSheetTitle:title message:msg arrTitleAction:arrTitle style:UIAlertControllerStyleActionSheet superVC:superVC blockClick:blockClick];
}


+ (void)AlertSheetTitle:(NSString *)title message:(NSString *)msg arrTitleAction:(NSArray *)arrTitle style:(UIAlertControllerStyle)style superVC:(UIViewController *)superVC blockClick:(BlockActionClick)blockClick {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    
    for (NSInteger i = 0; i < arrTitle.count; i++) {
        NSString * actionTitle = arrTitle[i];
        UIAlertAction * actionAlert = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger index = [arrTitle indexOfObject:action.title];
            blockClick(index);
        }];
        [alertVC addAction:actionAlert];
    }
    
    // Cancel
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:actionCancel];
    
    
    //修改 sheet 的 title
    if (style == UIAlertControllerStyleActionSheet) {
        if (title.length > 0) {
            NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
            [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 2)];
            [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_GRAY_STR] range:NSMakeRange(0, 2)];
            [alertVC setValue:alertControllerStr forKey:@"attributedTitle"];
        }
    }
    
    [superVC presentViewController:alertVC animated:YES completion:nil];
}


@end

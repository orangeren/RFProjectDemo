//
//  WebBaseViewController.h
//  MaYiBang
//
//  Created by jiesheng on 2019/5/21.
//  Copyright © 2019 捷晟数据科技. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface WebBaseViewController : BaseViewController

@property (nonatomic, strong) WKWebView *webView;
/** 加载URL字符串 */
@property (nonatomic, copy  ) NSString  *webUrlStr;
/** 是否直接回到根目录*/
@property (nonatomic, assign) BOOL isBackRoot;

@end



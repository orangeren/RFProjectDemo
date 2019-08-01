//
//  WebBaseViewController.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/31.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "WebBaseViewController.h"
#import "WebViewManager.h"
#import "AlertSheetTools.h"

static void *WkwebBrowserContext = &WkwebBrowserContext;


@interface WebBaseViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy  ) NSString *webUrlStr;  /** 加载URL字符串 */

@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, assign) BOOL pageNeedRefresh;                 /** 页面是否需要刷新 */
@property (nonatomic, assign) WebAddAppUINameType addUINameType;    /** 添加右按钮的类型 */

@end

@implementation WebBaseViewController

- (void)dealloc {
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self forKeyPath:@"title" context:NULL];
}


- (instancetype)initWithUrl:(NSString *)webUrlStr {
    self = [super init];
    if (self) {
        _webUrlStr = webUrlStr;
        // 去除字符串左右空格
        _webUrlStr = [_webUrlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.webView];
    
    if (self.webUrlStr.length > 0) {
        [self webLoadRequest];
    }
    
    // 添加导航栏左侧按钮
    [self addLeftButton];
    // 添加进度条
    [self.view addSubview:self.progressView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.pageNeedRefresh) {
        self.pageNeedRefresh = NO;
        [self webLoadRequest];
    }
}

- (void)webLoadRequest {
    NSLog(@"访问 - Url: %@", self.webUrlStr);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrlStr]]];
}


#pragma mark - 添加关闭按钮
- (void)addLeftButton {
    self.navigationItem.leftBarButtonItem = self.backItem;
}

#pragma mark - 注册监听title和进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.navigationItem.title = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - Lazy load
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *confi = [[WKWebViewConfiguration alloc] init];
//        WKUserContentController *userContent = [WKUserContentController new];
//        [userContent addScriptMessageHandler:self name:@"getConfigFromApp()"];
//        [userContent addScriptMessageHandler:self name:@"mqH5BackAction()"];
//        confi.userContentController = userContent;
        
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, k_Navigation_BarHei, KW, KH- k_Navigation_BarHei) configuration:confi];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
    }
    return _webView;
}

// 进度条
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, k_Navigation_BarHei, self.view.bounds.size.width, 2);
        // 设置进度条的色彩
        [_progressView setTrackTintColor:K_BackgroundColor];
        _progressView.progressTintColor = K_MainColor;
    }
    return _progressView;
}

// 返回按钮
- (UIBarButtonItem *)backItem {
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"Navi_back"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.frame = CGRectMake(15, 0, 44, 44);
        _backItem.customView = btn;
    }
    return _backItem;
}

// 关闭按钮
- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
        [_closeItem setTintColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
    }
    return _closeItem;
}


#pragma mark - 点击返回的方法
- (void)backNative {
    /** 返回上一层H5页面 */
    if ([self.webView canGoBack]) {
        int y = (int)_webView.backForwardList.backList.count;
        WKBackForwardListItem * item = _webView.backForwardList.backItem;
        if ([item.initialURL.absoluteString rangeOfString:@"lsd-web/thirdPartyLink"].location != NSNotFound) {
            for (int i = y; i > 0; i--) {
                WKBackForwardListItem * item1 = _webView.backForwardList.backList[i - 1];
                if ([item1.initialURL.absoluteString rangeOfString:@"lsd-web/thirdPartyLink"].location == NSNotFound) {
                    [_webView goToBackForwardListItem:item1];
                    return;
                }
            }
            [self closeNative];
        } else {
            [self.webView goBack];
        }
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    }
    else {
        [self closeNative];
    }
}

#pragma mark - 点击关闭的方法
- (void)closeNative {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 右侧导航栏按钮点击事件 (继承自BaseVC)
- (void)right_button_event:(UIButton *)sender {
    if (self.addUINameType == WebAddAppUINameTypeShare) {
        // 分享
//        if (![LoginManager isLogin]) {
//            [LoginManager presentLoginVCWithController:self];
//        } else {
//            [self.webView evaluateJavaScript:@"lsdShareData()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//                NSLog(@"%@  %@", response, error.userInfo);
//                NSDictionary * resultDict = [NSDictionary initWithJsonString:response];
//                [XLUmengShareHelper startShareWithDic:resultDict];
//            }];
//        }
    }
}




#pragma mark -----------------------------------------------
#pragma mark - Delegate
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([@"mqH5BackAction()" isEqualToString:message.name]) {
        NSLog(@"----------BBBBBB");
    }
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //    NSLog(@"WebView did Finish URL: %@", webView.URL);
    //    NSString *promptCode = [NSString stringWithFormat:@"getConfigFromApp(\'%@\')", [[WLHH5UserInfo sharedXLH5UserInfo].pointInfo_H5 mj_JSONString]];
    //    NSLog(@"%s页面获取定位信息:%@", __func__, [WLHH5UserInfo sharedXLH5UserInfo].pointInfo_H5);
    //    [self.webView evaluateJavaScript:promptCode completionHandler:^(id _Nullable response, NSError * _Nullable error) {}];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 数据加载发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //[self.view makeCenterToast:@"数据加载失败"];
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 处理web界面的三种提示框(警告框、确认框、输入框)
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler {
    
}


#pragma mark - 页面跳转的代理方法
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *requestUrl = navigationAction.request.URL;
    NSString *requestString = requestUrl.absoluteString;
    NSLog(@"requestString - %@", requestString);
    
    /** URL拦截 */
    if ([requestString hasPrefix:@"itms-services://"]) {
        // 下载第三方APP
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestString]];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([requestString rangeOfString:@"itunes.apple.com"].location != NSNotFound) {
        // 跳转到AppStore，下载App
        NSString *appUrlStr = [requestString encodingStringUsingURLEscape];
        NSString *appUrl = [appUrlStr substringFromIndex:[appUrlStr rangeOfString:@"://"].location];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps%@", appUrl]]];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([self tellPhoneInterupt:requestString]) {
        // 电话拦截
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([self openNativeUrl:requestUrl]) {
        // 拦截原生操作
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([requestString rangeOfString:@"about:blank"].location != NSNotFound) {
        // 空页面 不跳转
        NSLog(@"空页面========");
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([requestString rangeOfString:@"weixin://"].location != NSNotFound || [requestString rangeOfString:@"mqq://"].location != NSNotFound) {
        // 打开QQ，微信
        NSURL *url = [NSURL URLWithString:requestString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            [self.view makeCenterToast:@"未安装相关软件"];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}


/** 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSURL *requestUrl = navigationResponse.response.URL;
    //NSString *requestString = requestUrl.absoluteString;
    // 拦截导航栏添加UI控件
    [self addNavigationBarUIWithQuery:requestUrl.query];
    decisionHandler(WKNavigationResponsePolicyAllow);
}


#pragma mark - URL拦截操作
// 截取打电话
- (BOOL)tellPhoneInterupt:(NSString *)urlStr {
    if ([urlStr hasPrefix:@"sms:"] || [urlStr hasPrefix:@"tel:"]) {
        NSArray *tel = [urlStr componentsSeparatedByString:@":"];
        NSString *telStr = @"";
        if (tel.count == 2) {
            telStr = [tel lastObject];
        }
        NSString *message = @"拨打电话";
        NSArray *arr = @[telStr, @"取消"];
       
        [AlertSheetTools sheetTitle:message message:nil arrTitleAction:arr superVC:self blockClick:^(NSInteger index) {
            if (0 == index) {
                dispatch_after(0.3, dispatch_get_main_queue(), ^{
                    UIApplication *app = [UIApplication sharedApplication];
                    if ([app canOpenURL:[NSURL URLWithString:urlStr]]) {
                        [app openURL:[NSURL URLWithString:urlStr]];
                    }
                });
            }
        }];
        
        return YES;
    }
    return NO;
}

//  处理原生操作
- (BOOL)openNativeUrl:(NSURL *)url {
    BOOL openNative = NO;
    if ([url.path rangeOfString:@"opennative"].location != NSNotFound) {
        NSString *queryStr = url.query;
        queryStr = queryStr.stringByRemovingPercentEncoding;
        NSArray *paramsArray = [queryStr componentsSeparatedByString:@"&"];
        NSString *name = @"";
        NSString *paramstring = @"";
        for (NSString *params in paramsArray) {
            if([params hasPrefix:@"name="]) {
                name = [params substringFromIndex:5];
            } else if ([params hasPrefix:@"params="]) {
                paramstring = [params substringFromIndex:7];
            }
        }
        WebOpenNativeNameType nativeNameType = [WebViewManager opennativeNameTypeWithName:name];
        switch (nativeNameType) {
            case APP_LOGIN: {
                // 登陆
                self.pageNeedRefresh = YES;
                //[LoginManager presentLoginVCWithController:self];
                openNative = YES;
            }
                break;
            case APP_SHARE: {
                // 打开分享
                //[self openNativeShareWithParams:paramstring];
                openNative = YES;
            } break;
            case RETURN_BACK: {
                // 返回到上一个页面
                [self.navigationController popViewControllerAnimated:YES];
                openNative = YES;
            } break;
            default: { } break;
        }
    }
    return openNative;
}



#pragma mark - 拦截导航栏添加UI控件，配合h5添加视图
- (BOOL)addNavigationBarUIWithQuery:(NSString *)query {
    BOOL addUINameResult = NO;
    NSArray *paramsArray = [query.stringByRemovingPercentEncoding componentsSeparatedByString:@"&"];
    NSString *addUiName = @"";
    for (NSString *params in paramsArray) {
        if([params hasPrefix:@"addUiName="]) {
            addUiName = [params substringFromIndex:10];
        }
    }
    WebAddAppUINameType uiType = [WebViewManager addAppUINameTypeWithName:addUiName];
    switch (uiType) {
        case WebAddAppUINameTypeShare: {
            self.addUINameType = WebAddAppUINameTypeShare;
            [self setNavgationBarRightImageStr:@"share_nav"];
            addUINameResult = YES;
        } break;
        default: {} break;
    }
    return addUINameResult;
}



@end

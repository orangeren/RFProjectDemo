//
//  HomeViewController.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "HomeViewController.h"
#import "ZYNetworkAccessibity.h"

#import "MineViewController.h"
#import "UmShareHelper.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = UIColor.cyanColor;
    btn.frame = CGRectMake(0, 0, KW, 100);
    [btn setTitle:@"http://test2.bont9.com/game56/" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = UIColor.blueColor;
    btn2.frame = CGRectMake(0, 100, KW, 100);
    [btn2 setTitle:@"http://test2.bont9.com/game52/" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(btn2Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = UIColor.greenColor;
    btn3.frame = CGRectMake(0, 200, KW, 100);
    [btn3 setTitle:@"http://test2.bont9.com/game47/" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(btn3Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:ZYNetworkAccessibityChangedNotification object:nil];
}

- (void)btnClicked {
    WebBaseViewController *web = [[WebBaseViewController alloc] initWithUrl:@"http://test2.bont9.com/game56/"];
    [self.navigationController pushViewController:web animated:YES];

    NSDictionary *dict = @{@"shareAppUrl"       :@"http://mobile.umeng.com/social",
                           @"shareAppImage"     :@"https://mobile.umeng.com/images/pic/home/social/img-1.png",
                           @"shareAppTitle"     :@"标题",
                           @"shareAppContent"   :@"内容"};
    [UmShareHelper shareWithInfo:dict];
}
- (void)btn2Clicked {
    WebBaseViewController *web = [[WebBaseViewController alloc] initWithUrl:@"http://test2.bont9.com/game52/"];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)btn3Clicked {
    WebBaseViewController *web = [[WebBaseViewController alloc] initWithUrl:@"http://test2.bont9.com/game47/"];
    [self.navigationController pushViewController:web animated:YES];
}





#pragma mark - BaseViewControllerDataSource
- (BOOL)hideNavigationBottomLine {
    return YES;
}





#pragma mark - 根据网络权限显示UI

- (void)networkChanged:(NSNotification *)notification {
    ZYNetworkAccessibleState state = ZYNetworkAccessibity.currentState;
    if (state == ZYNetworkRestricted) {
        
    } else {
        //        if (nil) {
        //            [self reloadData]
        //        }
    }
    
    
    [self networkErrorUI];
}

- (void)networkErrorUI {
    [self.view configBlankPage:EaseBlankPageTypeLoadFail hasData:ZYNetworkAccessibity.currentState == ZYNetworkRestricted ? NO:YES reloadButtonBlock:^(id sender) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self networkErrorUI];
        });
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

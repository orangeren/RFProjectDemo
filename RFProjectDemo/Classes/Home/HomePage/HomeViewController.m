//
//  HomeViewController.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "HomeViewController.h"
#import "MineViewController.h"

#import "ZYNetworkAccessibity.h"

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
    [btn setTitle:@"百度一下" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:ZYNetworkAccessibityChangedNotification object:nil];
}

- (void)btnClicked {
    WebBaseViewController *web = [[WebBaseViewController alloc] initWithUrl:@"http://www.baidu.com"];
    [self.navigationController pushViewController:web animated:YES];
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

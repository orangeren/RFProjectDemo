//
//  HomeViewController.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "HomeViewController.h"
#import "MineViewController.h"

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
    
}

- (void)btnClicked {
    WebBaseViewController *web = [[WebBaseViewController alloc] initWithUrl:@"http://www.baidu.com"];
    [self.navigationController pushViewController:web animated:YES];
}


@end

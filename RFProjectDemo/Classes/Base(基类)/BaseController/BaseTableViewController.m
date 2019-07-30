//
//  BaseTableViewController.m
//  E-commerce
//
//  Created by jiesheng on 2019/1/18.
//  Copyright © 2019 JS. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()
@property (nonatomic, strong) UIImageView       * endImageView;
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0.f;
        self.tableView.estimatedSectionHeaderHeight = 0.f;
        self.tableView.estimatedSectionFooterHeight = 0.f;
    }
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    self.dataArray = [NSMutableArray array];
}

- (UIImageView *)endImageView {
    if (!_endImageView) {
        _endImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GY_EndImage"]];
        _endImageView.contentMode = UIViewContentModeScaleAspectFit;
        _endImageView.hidden = YES;
    }
    return _endImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KW, KH - k_TabBarHei) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        @WeakObj(self);
        MJRefreshNormalHeader* headerRefresh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [selfWeak refData];
        }];
        headerRefresh.lastUpdatedTimeLabel.hidden = YES;
        headerRefresh.stateLabel.hidden = YES;
        _tableView.mj_header = headerRefresh;
    }
    return _tableView;
}


#pragma mark -  TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellstr = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mark - 子类重载以下方法

- (void)moreData {
    
}

- (void)refData {
    
}

- (void)endRef {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addFooter];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (self.dataArray.count) {
            if (self.dataArray.count - (self.pageNum - 1) * K_Page_size != 0) {
                MJRefreshAutoGifFooter * footer = (MJRefreshAutoGifFooter *)self.tableView.mj_footer;
                [footer endRefreshingWithNoMoreData];
                self.endImageView.hidden = NO;
            } else{
                self.endImageView.hidden = YES;
            }
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        [self.tableView reloadData];
    });
}

- (void)addFooter {
    @WeakObj(self);
    if (!_tableView.mj_footer) {
        MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            [selfWeak moreData];
        }];
        footer.frame = CGRectMake(0, 0, KW, 70);
        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = FONT_LIGHT(14);
        [footer addSubview:self.endImageView];
        self.endImageView.frame = CGRectMake(15, 0, KW - 30, footer.height);
        _tableView.mj_footer = footer;
    }
}



@end

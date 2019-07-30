//
//  BaseTableViewController.h
//  E-commerce
//
//  Created by jiesheng on 2019/1/18.
//  Copyright © 2019 JS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) NSMutableArray    * dataArray;
@property (nonatomic, assign) NSInteger         pageNum;

/** 更多数据 */
- (void)moreData;
/** 刷新数据 */
- (void)refData;
/** 添加footer */
- (void)addFooter;
/** 结束刷新 */
- (void)endRef;

@end


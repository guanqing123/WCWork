//
//  WCNewArrivalViewController.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCNewArrivalViewController.h"
#import "WCNewArrivalCell.h"

#import "WCNewArrivalTool.h"
#import "MJRefresh.h"

#import "WCNewArrivalDetailViewController.h"

@interface WCNewArrivalViewController ()
{
    int page;
    int totalPage;
}

@property (nonatomic, strong)  NSMutableArray *dataArray;

@end

@implementation WCNewArrivalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60.0f;
    // 设置回调 (一旦进入刷新状态,就调用target的action,也就是调用self的headerRefreshing方法)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    if(@available(iOS 11.0, *)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(WCTopNavH, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
}

- (void)headerRefreshing {
    page = 1;
    WCNewArrivalParam *newArrivalParam = [WCNewArrivalParam param:newArrival];
    newArrivalParam.need_paginate = @"true";
    newArrivalParam.page_number = [NSString stringWithFormat:@"%d",page];
    newArrivalParam.page_size = @"20";
    [WCNewArrivalTool newArrivalWithParam:newArrivalParam success:^(WCNewArrivalResult *result) {
        [self.tableView.mj_header endRefreshing];
        if (result.errorMsg) {
            [MBProgressHUD showError:[NSString stringWithFormat:@"errorcode:%@",result.errorMsg]];
        } else {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:result.list];
            if ([result.totalPage intValue] > page) {
                [self setupFooterView];
            }
            page++;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"网络异常,请稍候再试"];
    }];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)setupFooterView {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

- (void)footerRefreshing {
    WCNewArrivalParam *newArrivalParam = [WCNewArrivalParam param:newArrival];
    newArrivalParam.need_paginate = @"true";
    newArrivalParam.page_number = [NSString stringWithFormat:@"%d",page];
    newArrivalParam.page_size = @"20";
    [WCNewArrivalTool newArrivalWithParam:newArrivalParam success:^(WCNewArrivalResult *result) {
        [self.tableView.mj_footer endRefreshing];
        if (result.errorMsg) {
            [MBProgressHUD showError:[NSString stringWithFormat:@"errorcode:%@",result.errorMsg]];
        } else {
            [self.dataArray addObjectsFromArray:result.list];
            [self.tableView reloadData];
            page++;
            if (page > totalPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCNewArrivalCell *newArrivalCell = [WCNewArrivalCell cellWithTableView:tableView];
    
    WCNewArrival *arrival = self.dataArray[indexPath.row];
    newArrivalCell.arrival = arrival;
    
    return newArrivalCell;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WCNewArrival *arrival = self.dataArray[indexPath.row];
    WCNewArrivalDetailViewController *arrivalDetaliVc = [[WCNewArrivalDetailViewController alloc] initWithTitle:arrival.title time:arrival.submit_date content:arrival.content];
    arrivalDetaliVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:arrivalDetaliVc animated:YES];
}

#pragma mark -屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end

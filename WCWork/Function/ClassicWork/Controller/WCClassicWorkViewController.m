//
//  WCClassicWorkViewController.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCClassicWorkViewController.h"

#import "WCClassicWorkDetailViewController.h"

#import "WCClassicWorkTool.h"
#import "MJRefresh.h"

#import "WCClassicWorkView.h"

#define BUTTONWIDTH  self.view.frame.size.width / 3
#define BUTTONX self.view.frame.size.width / 16

@interface WCClassicWorkViewController ()
{
    int page;
    int totalPage;
}
@property (nonatomic, strong)  NSMutableArray *dataArray;
@end

@implementation WCClassicWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView.mj_header beginRefreshing];
    
    if(@available(iOS 11.0, *)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(WCTopNavH, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
}

- (void)headerRefreshing {
    page = 1;
    WCClassicWorkParam *classicWorkParam = [WCClassicWorkParam param:classicWorkUrl];
    classicWorkParam.need_paginate = @"true";
    classicWorkParam.page_number = [NSString stringWithFormat:@"%d",page];
    classicWorkParam.page_size = @"20";
    [WCClassicWorkTool classicWorkWithParam:classicWorkParam success:^(WCClassicWorkResult *result) {
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
    WCClassicWorkParam *classicWorkParam = [WCClassicWorkParam param:classicWorkUrl];
    classicWorkParam.need_paginate = @"true";
    classicWorkParam.page_number = [NSString stringWithFormat:@"%d",page];
    classicWorkParam.page_size = @"20";
    [WCClassicWorkTool classicWorkWithParam:classicWorkParam success:^(WCClassicWorkResult *result) {
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
        [MBProgressHUD showError:@"网络异常,请稍候再试"];
    }];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        WCClassicWork *classicWork = self.dataArray[i];
        
        WCClassicWorkView *classicWorkView = [[WCClassicWorkView alloc] init];
        classicWorkView.frame = CGRectMake(BUTTONWIDTH * (i % 3), 10.0f + (BUTTONWIDTH / 3.0 * 2 + 40.0f) * (i / 3 ), BUTTONWIDTH, BUTTONWIDTH / 3.0 * 2 + 30.0f);
        classicWorkView.classicWork = classicWork;
        classicWorkView.tag = i;
        [cell.contentView addSubview:classicWorkView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
        [classicWorkView addGestureRecognizer:tapGesture];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tapItem:(UITapGestureRecognizer *)recognizer {
    WCClassicWorkView *classicWorkView = (WCClassicWorkView *)recognizer.view;
    NSInteger i = classicWorkView.tag;
    WCClassicWork *classicWork = [_dataArray objectAtIndex:i];
    WCClassicWorkDetailViewController *detailVc = [[WCClassicWorkDetailViewController alloc] initWithPath:classicWork.path];
    detailVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (_dataArray.count / 3 + 1) * (BUTTONWIDTH / 3.0 * 2 + 40.0f);
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

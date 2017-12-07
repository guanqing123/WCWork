//
//  WCHonourCompanyViewController.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHonourCompanyViewController.h"
#import "MJRefresh.h"
#import "WCHonourCompanyTool.h"
#import "WCHonourCompanyCell.h"
#import "WCHonourCompanyDetailViewController.h"

@interface WCHonourCompanyViewController () <UITableViewDataSource,UITableViewDelegate>
{
    int page;
    int totalPage;
}

@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic, strong)  NSMutableArray *companyHonour;

@end

@implementation WCHonourCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // tableView create
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
    
    // tableView setting
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.rowHeight = 70.0f;
    
    // setupHeaderRefresh
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView.mj_header beginRefreshing];
    
    if(@available(iOS 11.0, *)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(WCTopNavH, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
}


#pragma mark - headerRefreshing
- (void)headerRefreshing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        page = 1;
        WCHonourCompanyParam *param = [WCHonourCompanyParam param:honourCompany];
        param.need_paginate = @"true";
        param.page_number = @(page);
        param.page_size = @(10);
        [WCHonourCompanyTool honourCompanyListWithParam:param success:^(WCHonourCompanyResult *result) {
            [self.tableView.mj_header endRefreshing];
            [self.companyHonour removeAllObjects];
            if (result) {
                [self.companyHonour addObjectsFromArray:result.list];
                [self.tableView reloadData];
                if ([result.totalPage intValue] > page) {
                    [self setupFooterRefresh];
                }
                page ++;
            }else{
                [MBProgressHUD showError:@"未加载到数据"];
                return;
            }
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD showError:@"网络异常"];
        }];
    });
}
#pragma mark - setupFooterRefresh
- (void)setupFooterRefresh {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

#pragma mark - footerRefreshing
- (void)footerRefreshing {
    WCHonourCompanyParam *param = [WCHonourCompanyParam param:honourCompany];
    param.need_paginate = @"true";
    param.page_number = @(page);
    param.page_size = @(10);
    [WCHonourCompanyTool honourCompanyListWithParam:param success:^(WCHonourCompanyResult *result) {
        [self.tableView.mj_footer endRefreshing];
        if (result) {
            [self.companyHonour addObjectsFromArray:result.list];
            [self.tableView reloadData];
            page ++;
            if (page > [result.totalPage intValue]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [MBProgressHUD showError:@"未加载到数据"];
            return;
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"网络异常"];
    }];
}


#pragma mark - lazy load
- (NSMutableArray *)companyHonour {
    if (!_companyHonour) {
        _companyHonour = [NSMutableArray array];
    }
    return _companyHonour;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.companyHonour.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCHonourCompanyCell *honourCompanyCell = [WCHonourCompanyCell cellWithTableView:tableView];
    WCHonourCompany *honour = [self.companyHonour objectAtIndex:indexPath.row];
    honourCompanyCell.honour = honour;
    return honourCompanyCell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WCHonourCompany *honour = [self.companyHonour objectAtIndex:indexPath.row];
    WCHonourCompanyDetailViewController *detailVc = [[WCHonourCompanyDetailViewController alloc] initWithTitle:honour.introduction time:honour.honor_date content:honour.content];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

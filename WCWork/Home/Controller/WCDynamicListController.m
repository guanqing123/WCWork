//
//  WCNewsListController.m
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCDynamicListController.h"
#import "WCDynamicDetailController.h"
#import "WCDynamicCell.h"
#import "MJRefresh.h"
#import "WCNoWifiView.h"
#import "WCDynamicParam.h"
#import "WCHomeTool.h"


@interface WCDynamicListController () <WCNoWifiViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>
{
    int page;
    int totalPage;
}
@property (nonatomic, strong)  NSMutableArray *dynamicArray;
@property (nonatomic, strong)  NSMutableDictionary *dynamicDic;
@property (nonatomic, strong)  NSMutableArray *titleArray;
@property (nonatomic, strong)  NSMutableArray *searchArray;
@property (nonatomic, strong)  NSMutableArray *searchResultArray;
@property (nonatomic, strong)  WCNoWifiView *noWifiView;
@property (nonatomic, strong)  UISearchController *searchVc;
@end

@implementation WCDynamicListController

- (instancetype)initWithColumnId:(NSString *)columnId {
    if (self = [super init]) {
        _columnId = columnId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    // setupHeaderRefresh
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView.mj_header beginRefreshing];
    
    // searchVc
    // 初始化方法, 参数是展示搜索结果的控制器, 如果是在当前控制器展示搜索结果, 就传nil
    UISearchController *searchVc = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchVc.view.backgroundColor = [UIColor clearColor];
    // 设置结果更新代理
    searchVc.searchResultsUpdater = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    searchVc.dimsBackgroundDuringPresentation = NO;
    
    [searchVc.searchBar sizeToFit];
    searchVc.searchBar.delegate = self;
    searchVc.searchBar.placeholder = @"关键字搜索";
    searchVc.hidesNavigationBarDuringPresentation = YES;
    _searchVc = searchVc;
    
    self.tableView.tableHeaderView = _searchVc.searchBar;
    self.definesPresentationContext = YES;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchVc.active) {
        return self.searchArray.count;
    }else{
      return self.dynamicArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCDynamicCell *cell = [WCDynamicCell cellWithTableView:tableView];
    
    if (_searchVc.active) {
        WCDynamic *wcDynamic = self.searchResultArray[indexPath.row];
        cell.wcDynamic = wcDynamic;
    }else{
        WCDynamic *wcDynamic = self.dynamicArray[indexPath.row];
        cell.wcDynamic = wcDynamic;
    }
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_searchVc.active) {
        WCDynamic *wcDynamic = self.searchResultArray[indexPath.row];
        WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
        dynamicDetailVc.title = self.title;
        [self.navigationController pushViewController:dynamicDetailVc animated:YES];
    }else{
        WCDynamic *wcDynamic = self.dynamicArray[indexPath.row];
        WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
        dynamicDetailVc.title = self.title;
        [self.navigationController pushViewController:dynamicDetailVc animated:YES];
    }
}

#pragma mark - headerRefreshing
- (void)headerRefreshing {
    page = 1;
    [self.noWifiView hide];
    WCDynamicParam *param = [WCDynamicParam param:dynamic];
    param.page = @(page);
    param.columnId = _columnId;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WCHomeTool homeDynamicWithParam:param success:^(WCDynamicResult *dynamicResult) {
            [self.tableView.mj_header endRefreshing];
            
            [self.dynamicArray removeAllObjects];
            [self.dynamicArray addObjectsFromArray:dynamicResult.NewsList];
            [self.titleArray removeAllObjects];
            for (WCDynamic *wcDynamic in dynamicResult.NewsList) {
                [self.titleArray addObject:wcDynamic.Title];
            }
            [self.dynamicDic removeAllObjects];
            [self.dynamicDic setValuesForKeysWithDictionary:[NSDictionary dictionaryWithObjects:self.dynamicArray forKeys:self.titleArray]];
            
            [self.tableView reloadData];
            totalPage = (dynamicResult.PageSize == 0 ? 0 : ([dynamicResult.RCount intValue] % [dynamicResult.PageSize intValue] == 0 ? [dynamicResult.RCount intValue] / [dynamicResult.PageSize intValue] : [dynamicResult.RCount intValue] / [dynamicResult.PageSize intValue] + 1));
            if (totalPage > page) {
                [self setupFooterRefresh];
            }
            page ++;
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self.noWifiView show];
        }];
    });
}

#pragma mark - setupFooterRefresh
- (void)setupFooterRefresh {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

#pragma mark - footerRefreshing
- (void)footerRefreshing {
    WCDynamicParam *param = [WCDynamicParam param:dynamic];
    param.page = @(page);
    param.columnId = _columnId;
    [WCHomeTool homeDynamicWithParam:param success:^(WCDynamicResult *dynamicResult) {
        [self.tableView.mj_footer endRefreshing];
        
        [self.dynamicArray addObjectsFromArray:dynamicResult.NewsList];
        for (WCDynamic *wcDynamic in dynamicResult.NewsList) {
            [self.titleArray addObject:wcDynamic.Title];
        }
        [self.dynamicDic setValuesForKeysWithDictionary:[NSDictionary dictionaryWithObjects:self.dynamicArray forKeys:self.titleArray]];
        
        [self.tableView reloadData];
        page ++;
        totalPage = (dynamicResult.PageSize == 0 ? 0 : ([dynamicResult.RCount intValue] % [dynamicResult.PageSize intValue] == 0 ? [dynamicResult.RCount intValue] / [dynamicResult.PageSize intValue] : [dynamicResult.RCount intValue] / [dynamicResult.PageSize intValue] + 1));
        if (page > totalPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - noWifiView / noWifiViewDelegate
- (WCNoWifiView *)noWifiView {
    if (!_noWifiView) {
        _noWifiView = [[WCNoWifiView alloc] init];
        _noWifiView.center = CGPointMake(ScreenW / 2, ScreenH / 2 - 64);
        _noWifiView.delegate = self;
        [self.tableView addSubview:_noWifiView];
    }
    return _noWifiView;
}

- (void)noWifiViewDidRefreshBtn:(WCNoWifiView *)noWifiView {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - dynamicArray
- (NSMutableArray *)dynamicArray {
    if (!_dynamicArray) {
        _dynamicArray = [NSMutableArray array];
    }
    return _dynamicArray;
}

#pragma mark - dynamicDic
- (NSMutableDictionary *)dynamicDic {
    if (!_dynamicDic) {
        _dynamicDic = [NSMutableDictionary dictionary];
    }
    return _dynamicDic;
}

#pragma mark - titleArray
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

#pragma mark - searchArray
- (NSMutableArray *)searchArray {
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

#pragma mark - searchResultArray
- (NSMutableArray *)searchResultArray {
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchStr = [self.searchVc.searchBar text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchStr];
    [self.searchArray removeAllObjects];
    [self.searchResultArray removeAllObjects];
    [self.searchArray addObjectsFromArray:[self.titleArray filteredArrayUsingPredicate:predicate]];
    for (int i = 0; i < self.searchArray.count; i++) {
        [self.searchResultArray addObject:[self.dynamicDic objectForKey:self.searchArray[i]]];
    }
    [self.tableView reloadData];
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

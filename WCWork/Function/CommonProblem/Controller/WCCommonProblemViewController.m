//
//  CjwtViewController.m
//  HYWork
//
//  Created by information on 16/7/7.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import "WCCommonProblemViewController.h"
#import "WCCommonProblem.h"
#import "WCCommonProblemTool.h"
#import "WCCommonProblemHeaderView.h"
#import "WCCommonProblemCell.h"
#import "MJRefresh.h"

@interface WCCommonProblemViewController () <UISearchResultsUpdating,UISearchBarDelegate,WCCommonProblemHeaderViewDelegate>
@property (nonatomic, strong) UISearchController  *searchController;

@property (nonatomic, strong)  NSMutableArray *searchArray;
@property (nonatomic, strong)  NSMutableArray *modelArray;
@property (nonatomic, strong)  NSMutableArray *questionArray;
@property (strong, nonatomic) NSMutableArray *searchedModelArray;
@property (nonatomic, strong)  NSDictionary *dict;
@end

@implementation WCCommonProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupHeaderRefresh];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //Attempting to load the view of a view controller while it is deallocating is not allowed and may result in undefined behavior (<UISearchController: 0x7f9ce3921fb0>)
    //[_searchController loadViewIfNeeded]; 9.0 这句话可以解决这个问题,但是要求 9.0
    _searchController.view.backgroundColor = [UIColor clearColor]; // 用这句话也可以解决
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder = @"关键字搜索";
    _searchController.hidesNavigationBarDuringPresentation = YES;
    
    self.tableView.tableHeaderView = _searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_searchController.presentingViewController removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray *)questionArray {
    if (_questionArray == nil) {
        _questionArray = [NSMutableArray array];
    }
    return _questionArray;
}

- (NSMutableArray *)searchedModelArray {
    if (_searchedModelArray == nil) {
        _searchedModelArray = [NSMutableArray array];
    }
    return _searchedModelArray;
}

- (void)setupHeaderRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)headerRefreshing {
    WCCommonProbleParam *problemParam = [WCCommonProbleParam param:commonProblemUrl];
    [WCCommonProblemTool commomProblemWithParam:problemParam success:^(NSArray *commonProblem) {
        [self.modelArray addObjectsFromArray:commonProblem];
        for (WCCommonProblem *commonProblem in self.modelArray) {
            [self.questionArray addObject:commonProblem.question];
        }
        self.dict = [[NSDictionary alloc] initWithObjects:self.modelArray forKeys:self.questionArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    /*[CjwtManager getCjwtWithUrl:url success:^(id json) {
        NSDictionary *header = [json objectForKey:@"header"];
        if ([[header objectForKey:@"succflag"] intValue] > 1) {
            [MBProgressHUD showError:[[Utils getDict] objectForKey:[header objectForKey:@"errorcode"]]];
        } else {
            self.modelArray = [CjwtManager jsonArrayToModelArray:[json objectForKey:@"data"]];
            [self.questionArray removeAllObjects];
            for (QuestionModel *model in self.modelArray) {
                [self.questionArray addObject:model.question];
            }
            _dict = [[NSDictionary alloc] initWithObjects:self.modelArray forKeys:self.questionArray];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } fail:^{
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"网络异常,请下拉刷新"];
    }];*/
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_searchController.active) {
        return _searchArray.count;
    }else{
        return _modelArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.active) {
        WCCommonProblem *commonProblem = [_searchedModelArray objectAtIndex:section];
        return commonProblem.isOpened ? 1 : 0;
    }else{
        WCCommonProblem *commonProblem = [_modelArray objectAtIndex:section];
        return commonProblem.isOpened ? 1 : 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCCommonProblemCell *cell = [WCCommonProblemCell cellWithTableView:tableView];
    if (_searchController.active) {
        WCCommonProblem *commonProblem = [_searchedModelArray objectAtIndex:indexPath.section];
        cell.commonProblem = commonProblem;
    }else{
        WCCommonProblem *commonProblem = self.modelArray[indexPath.section];
        cell.commonProblem = commonProblem;
    }
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WCCommonProblemHeaderView *headerView = [WCCommonProblemHeaderView headerViewWithTableView:tableView];
    headerView.delegate = self;
    
    if (_searchController.active) {
        WCCommonProblem *commonProblem = self.searchedModelArray[section];
        headerView.commonProblem = commonProblem;
    }else{
        WCCommonProblem *commonProblem = self.modelArray[section];
        headerView.commonProblem = commonProblem;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 345.0f;
}

#pragma mark - WCCommonProblemHeaderViewDelegateDelegate
- (void)headerViewDidClickedNameView:(WCCommonProblemHeaderView *)headerView {
    [self.tableView reloadData];
}

#pragma mark - searchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchString];
    if (_searchArray != nil) {
        [_searchArray removeAllObjects];
    }
    if (self.searchedModelArray.count > 0) {
        [self.searchedModelArray removeAllObjects];
    }
    _searchArray = [NSMutableArray arrayWithArray:[_questionArray filteredArrayUsingPredicate:predicate]];
    for (int i = 0; i < _searchArray.count; i++) {
        [self.searchedModelArray addObject:[_dict objectForKey:_searchArray[i]]];
    }
    [self.tableView reloadData];
}

@end

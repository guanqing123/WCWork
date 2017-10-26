//
//  WCAddressBookViewController.m
//  WCWork
//
//  Created by information on 2017/9/29.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookViewController.h"
#import "WCAddressBookSearchHeaderView.h"
#import "WCAddressBookSectionHeaderView.h"
#import "WCAddressBookCell.h"

#import "WCNavigationController.h"
#import "WCAddressBookSearchViewController.h"
#import "WCAddressBookTool.h"

#import "YLYTableViewIndexView.h"
#import "WCActivityIndicatorView.h"
#import "WCNoWifiView.h"

#define WCAddressBookFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"addressBook.data"]

#define SearchHeaderViewH 44.0f

@interface WCAddressBookViewController () <UITableViewDataSource,UITableViewDelegate,WCNoWifiViewDelegate,YLYTableViewIndexDelegate,WCAddressBookSearchHeaderViewDelegate>

@property (nonatomic, strong)  NSArray *addressBookListResultAllKey;
@property (nonatomic, strong)  WCAddressBookListResult *addressBookListResult;

@property (nonatomic, strong)  WCActivityIndicatorView *indicatorView;
@property (nonatomic, strong)  WCNoWifiView *noWifiView;

@property (nonatomic, weak) WCAddressBookSearchHeaderView  *searchHeaderView;
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic, weak)  UILabel *flotageLabel; //显示视图
@property (nonatomic, weak) YLYTableViewIndexView  *indexView;
@property (nonatomic, weak) UIButton  *backTopButton;
@end

@implementation WCAddressBookViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.flotageLabel.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.headerView & navigationItem
    [self setupNavBarHeaderView];
    
    // 2.tableView
    [self setupTableView];
    
    // 3.flotageLabel
    [self setupFlotageLabel];
    
    // 4.backTopButton
    [self setupBackTopButton];
    
    // 5.loadData
    [self setupData];
}

#pragma mark - headerView & navigationItem / headerViewDelegate
- (void)setupNavBarHeaderView {
    WCAddressBookSearchHeaderView *searchHeaderView = [WCAddressBookSearchHeaderView headerView];
    searchHeaderView.frame = CGRectMake(0, WCTopNavH, ScreenW, SearchHeaderViewH);
    searchHeaderView.delegate = self;
    _searchHeaderView = searchHeaderView;
    [self.view addSubview:searchHeaderView];
    
    UIButton *refreshBtn = [[UIButton alloc] init];
    refreshBtn.frame = CGRectMake(0, 0, 30, 30);
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"flush"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(updateLocationAddressBook) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem= [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addressBookSearchHeaderViewDidSearchBtn:(WCAddressBookSearchHeaderView *)searchHeaderView {
    WCAddressBookSearchViewController *searchViewController = [[WCAddressBookSearchViewController alloc] initWithAddressBookListResult:self.addressBookListResult];
    WCNavigationController *nav = [[WCNavigationController alloc] initWithRootViewController:searchViewController];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve; //设置动画效果
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - tableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, WCTopNavH + SearchHeaderViewH, ScreenW, ScreenH - WCTopNavH - SearchHeaderViewH - WCBottomTabH);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = YES;
    _tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addressBookListResultAllKey.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionKey = [self.addressBookListResultAllKey objectAtIndex:section];
    NSArray *sectionValue = [self.addressBookListResult objectForKey:sectionKey];
    return sectionValue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCAddressBookCell *addressBookCell = [WCAddressBookCell cellWithTableView:tableView];
    
    NSString *sectionKey = [self.addressBookListResultAllKey objectAtIndex:indexPath.section];
    NSArray *sectionValue = [self.addressBookListResult valueForKey:sectionKey];
    NSDictionary *resultDict = [sectionValue objectAtIndex:indexPath.row];
    
    addressBookCell.trueName = [resultDict objectForKey:@"trueName"];
    addressBookCell.userName = [resultDict objectForKey:@"userName"];
    addressBookCell.mobile = [resultDict objectForKey:@"mobile"];
    
    return addressBookCell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [WCAddressBookSectionHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WCAddressBookSectionHeaderView *sectionHeaderView = [WCAddressBookSectionHeaderView sectionHeaderViewWithTableView:tableView];
    sectionHeaderView.sectionKey = [self.addressBookListResultAllKey objectAtIndex:section];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WCAddressBookCell height];
}

#pragma mark - flotageLabel
- (void)setupFlotageLabel {
    UILabel *flotageLabel = [[UILabel alloc] init];
    flotageLabel.frame = (CGRect){CGPointZero,{64.0f, 64.0f}};
    flotageLabel.center = CGPointMake(ScreenW / 2, ScreenH / 2);
    flotageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"flotageBackgroud"]];
    flotageLabel.hidden = YES;
    flotageLabel.textAlignment = NSTextAlignmentCenter;
    flotageLabel.textColor = [UIColor whiteColor];
    _flotageLabel = flotageLabel;
    [self.view addSubview:flotageLabel];
}

#pragma mark - setupBackTopButton
- (void)setupBackTopButton {
    UIButton *backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 100, 40, 40);
    [backTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    backTopButton.hidden = YES;
    _backTopButton = backTopButton;
    [self.view addSubview:backTopButton];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.backTopButton.hidden = (scrollView.contentOffset.y > self.tableView.frame.size.height) ? NO : YES;
}

- (void)scrollToTop {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - updateLocationAddressBook
- (void)updateLocationAddressBook {
    self.addressBookListResultAllKey = nil;
    self.addressBookListResult = nil;
    [self.tableView reloadData];
    // 删除文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isHave = [fileManager fileExistsAtPath:WCAddressBookFile];
    if (isHave) {
        NSError *error;
        [fileManager removeItemAtPath:WCAddressBookFile error:&error];
    }
    [self setupData];
}

#pragma mark - setupData
- (void)setupData {
    [self loading];
    WCAddressBookListResult *addressBookDict = [NSKeyedUnarchiver unarchiveObjectWithFile:WCAddressBookFile];
    if (addressBookDict) {
        [self show];
        self.addressBookListResult = addressBookDict;
        self.addressBookListResultAllKey = [[addressBookDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        [self.tableView reloadData];
        [self initIndexView];
    }else{
        [self.indexView removeFromSuperview];
        WCAddressBookListParam *param = [WCAddressBookListParam param:addressBookList];
        [WCAddressBookTool addressBookListWithParam:param success:^(WCAddressBookListResult *addressBookListResult) {
            [self show];
            self.addressBookListResult = addressBookListResult;
            self.addressBookListResultAllKey = [[addressBookListResult allKeys] sortedArrayUsingSelector:@selector(compare:)];
            [self.tableView reloadData];
            [NSKeyedArchiver archiveRootObject:addressBookListResult toFile:WCAddressBookFile];
            [self initIndexView];
        } failure:^(NSError *error) {
            [self failure];
        }];
    }
}


#pragma mark - alphabetic list / YLYTableViewIndexDelegate
- (void)initIndexView {
    YLYTableViewIndexView *indexView = [[YLYTableViewIndexView alloc] init];
    indexView.frame = CGRectMake(ScreenW - 20, 0, 20, ScreenH);
    indexView.tableViewIndexDelegate = self;
    _indexView = indexView;
    [self.view addSubview:indexView];
    
    CGRect tempRect = indexView.frame;
    tempRect.size.height = self.addressBookListResultAllKey.count * 16;
    tempRect.origin.y = ((ScreenH - WCTopNavH - SearchHeaderViewH - WCBottomTabH ) - tempRect.size.height)/2 + WCTopNavH + SearchHeaderViewH;
    indexView.frame = tempRect;
}

- (NSArray *)tableViewIndexTitle:(YLYTableViewIndexView *)tableViewIndex {
    return self.addressBookListResultAllKey;
}

- (void)tableViewIndexTouchesBegan:(YLYTableViewIndexView *)tableViewIndex {
    self.flotageLabel.hidden = NO;
}

- (void)tableViewIndexTouchesEnd:(YLYTableViewIndexView *)tableViewIndex {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    self.flotageLabel.hidden = YES;
}

- (void)tableViewIndex:(YLYTableViewIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title {
    if ([self.tableView numberOfSections] > index && index > -1) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        self.flotageLabel.text = title;
    }
}

#pragma mark - noWifiView/indicatorView lazy load
- (WCNoWifiView *)noWifiView {
    if (!_noWifiView) {
        _noWifiView = [WCNoWifiView noWifiView];
        _noWifiView.center = CGPointMake(ScreenW / 2, ScreenH / 2 - 64);
        _noWifiView.delegate = self;
        [self.tableView addSubview:_noWifiView];
    }
    return _noWifiView;
}

- (void)noWifiViewDidRefreshBtn:(WCNoWifiView *)noWifiView {
    [self setupData];
}

- (WCActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [WCActivityIndicatorView indicatorView];
        _indicatorView.center = CGPointMake(ScreenW / 2, ScreenH / 2 - 64);
        [self.tableView addSubview:_indicatorView];
    }
    return _indicatorView;
}

#pragma mark - loading / show / failure
- (void)loading {
    [self.noWifiView hide];
    [self.indicatorView show];
}

- (void)show {
    [self.noWifiView hide];
    [self.indicatorView hide];
}

- (void)failure {
    [self.indicatorView hide];
    [self.noWifiView show];
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

//
//  WCAddressBookSearchViewController.m
//  WCWork
//
//  Created by information on 2017/10/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookSearchViewController.h"
#import "WCAddressBookSearchTitleView.h"
#import "WCAddressBookCell.h"

@interface WCAddressBookSearchViewController () <WCAddressBookSearchTitleViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)  WCAddressBookSearchTitleView *searchTitleView;
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic, weak) UIView  *warningView;
@property (nonatomic, strong)  NSMutableArray *searchResultArray;
@end

@implementation WCAddressBookSearchViewController

- (instancetype)initWithAddressBookListResult:(WCAddressBookListResult *)addressBookListResult {
    if (self = [super init]) {
        _addressBookListResult = addressBookListResult;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.searchBar
    [self setupSearchBar];
    // 2.tableView
    [self setupTableView];
    // 3.warningView
    [self setupWarningView];
}

#pragma mark - searchBar / searchBarDelegate
- (void)setupSearchBar {
    self.navigationItem.titleView = self.searchTitleView;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (WCAddressBookSearchTitleView *)searchTitleView {
    if (!_searchTitleView) {
        _searchTitleView = [WCAddressBookSearchTitleView searchTitleView];
        _searchTitleView.delegate = self;
        [_searchTitleView active];
    }
    return _searchTitleView;
}

- (void)addressBookSearchTitleViewDidClickCancleBtn:(WCAddressBookSearchTitleView *)searchTitleView {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageUnCurl";
    animation.type = kCATransitionFade;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)addressBookSearchTitleView:(WCAddressBookSearchTitleView *)searchTitleView textFieldDidChange:(NSString *)text {
    [self.searchResultArray removeAllObjects];
    if (text.length > 0 && [self isIncludeChineseInString:text]) { //中文
        for (NSString *sectionKey in self.addressBookListResult.allKeys) {
            NSArray *sectionValue = [self.addressBookListResult valueForKey:sectionKey];
            for (NSDictionary *resultDict in sectionValue) {
                NSRange titleResult = [[resultDict objectForKey:@"trueName"] rangeOfString:text options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [self.searchResultArray addObject:resultDict];
                }
            }
        }
    }else if (text.length > 0 && ![self isIncludeChineseInString:text]) {//英文
        for (NSString *sectionKey in self.addressBookListResult.allKeys) {
            NSArray *sectionValue = [self.addressBookListResult valueForKey:sectionKey];
            for (NSDictionary *resultDict in sectionValue) {
                NSRange titleResult = [[resultDict objectForKey:@"userName"] rangeOfString:text options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [self.searchResultArray addObject:resultDict];
                }
            }
        }
    }
    
    if (self.searchResultArray.count > 0) {
        self.warningView.hidden = YES;
    }else{
        self.warningView.hidden = NO;
    }
    
    [self.tableView reloadData];
}
                            
- (BOOL)isIncludeChineseInString:(NSString *)text {
    for (int i=0; i<text.length;i++) {
        unichar ch = [text characterAtIndex:i];
        if (0x4e00 < ch && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.searchTitleView unactive];
}

#pragma mark - tableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = RGB(248.0f, 248.0f, 248.0f);
    _tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCAddressBookCell *addressBookCell = [WCAddressBookCell cellWithTableView:tableView];
    
    NSDictionary *resultDict = [self.searchResultArray objectAtIndex:indexPath.row];
    
    addressBookCell.trueName = [resultDict objectForKey:@"trueName"];
    addressBookCell.userName = [resultDict objectForKey:@"userName"];
    addressBookCell.mobile = [resultDict objectForKey:@"mobile"];
    
    return addressBookCell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WCAddressBookCell height];
}

#pragma mark - searchResultArray lazy
- (NSMutableArray *)searchResultArray {
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}

#pragma mark - warningView
- (void)setupWarningView {
    UIView *warningView = [[UIView alloc] init];
    warningView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    warningView.backgroundColor = [UIColor whiteColor];
    warningView.hidden = YES;
    _warningView = warningView;
    
    UILabel *warningLabel = [[UILabel alloc] init];
    warningLabel.frame = CGRectMake((ScreenW - 100)/2, (ScreenH - 40)/2, 100, 40);
    warningLabel.text = @"无结果";
    warningLabel.font = [UIFont systemFontOfSize:25.0f];
    warningLabel.textColor = [UIColor grayColor];
    [warningView addSubview:warningLabel];
    
    [self.view addSubview:warningView];
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

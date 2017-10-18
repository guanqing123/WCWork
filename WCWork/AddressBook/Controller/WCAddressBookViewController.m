//
//  WCAddressBookViewController.m
//  WCWork
//
//  Created by information on 2017/9/29.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookViewController.h"
#import "WCAddressBookSearchHeaderView.h"

@interface WCAddressBookViewController ()
@property (nonatomic, strong)  WCAddressBookSearchHeaderView *tableHeaderView;
@end

@implementation WCAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    self.tableView.tableHeaderView = self.tableHeaderView;
}

#pragma mark - tableHeaderView
- (WCAddressBookSearchHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [WCAddressBookSearchHeaderView headerView];
    }
    return _tableHeaderView;
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"text";
    return cell;
}

#pragma mark - tableView delegate

@end

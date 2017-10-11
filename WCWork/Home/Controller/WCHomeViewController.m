//
//  ViewController.m
//  WCWork
//
//  Created by information on 2017/9/28.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHomeViewController.h"
#import "CustomSegmentControl.h"

@interface WCHomeViewController () <UITableViewDataSource,UITableViewDelegate>

///<SwipeTableViewDelegate,SwipeTableViewDataSource>

@property (nonatomic, strong)  CustomSegmentControl *segmentBar;

@property (nonatomic, strong)  UITableView *tableView;

@property (nonatomic, strong)  NSMutableArray *dynamicArray;

@end

@implementation WCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
    
    [self changeSwipeViewIndex:self.segmentBar];
}

#pragma mark - dynamicArray
- (NSMutableArray *)dynamicArray {
    if (!_dynamicArray) {
        _dynamicArray = [NSMutableArray array];
    }
    return _dynamicArray;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return self.dynamicArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"添加常用";
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dynamicArray[indexPath.row]];
        return cell;
    }
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0f;
    }else{
        return 40.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.segmentBar;
}

- (CustomSegmentControl *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[CustomSegmentControl alloc] initWithItems:@[@"煤市行情",@"煤市资讯",@"物流仓储",@"指数价格"]];
        _segmentBar.font = [UIFont systemFontOfSize:15];
        _segmentBar.textColor = RGB(100, 100, 100);
        _segmentBar.selectedTextColor = RGB(0, 0, 0);
        _segmentBar.backgroundColor = RGB(249, 251, 198);
        _segmentBar.selectionIndicatorColor = RGB(249, 104, 92);
        [_segmentBar addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentBar;
}

- (void)changeSwipeViewIndex:(CustomSegmentControl *)segmentBar{
    switch (segmentBar.selectedSegmentIndex) {
        case 0:
            [self.dynamicArray removeAllObjects];
            for (int i = 0; i < 10; i++) {
                [self.dynamicArray addObject:@(0)];
            }
            break;
        case 1:
            [self.dynamicArray removeAllObjects];
            for (int i = 0; i < 10; i++) {
                [self.dynamicArray addObject:@(1)];
            }
            break;
        case 2:
            [self.dynamicArray removeAllObjects];
            for (int i = 0; i < 10; i++) {
                [self.dynamicArray addObject:@(2)];
            }
            break;
        case 3:
            [self.dynamicArray removeAllObjects];
            for (int i = 0; i < 10; i++) {
                [self.dynamicArray addObject:@(3)];
            }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

@end

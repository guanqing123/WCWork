//
//  ViewController.m
//  WCWork
//
//  Created by information on 2017/9/28.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHomeViewController.h"
#import "CustomSegmentControl.h"
#import "WCHomeTool.h"
#import "WCSlideshowHeadView.h"

@interface WCHomeViewController () <UITableViewDataSource,UITableViewDelegate,WCSlideshowHeadViewDelegate>

@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong)  CustomSegmentControl *segmentBar;
@property (nonatomic, strong)  NSMutableArray *dynamicArray;
@property (nonatomic, strong)  WCSlideshowHeadView *headerView;

@end

@implementation WCHomeViewController

#pragma mark -lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:tableView];
    
    [self changeSwipeViewIndex:self.segmentBar];
    
    [self setUpData];
    
}

#pragma mark - slide headerView
- (WCSlideshowHeadView *)headerView {
    if (!_headerView) {
        _headerView = [WCSlideshowHeadView headerView];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (void)slideShowHeaderViewDidClickRefreshBtn:(WCSlideshowHeadView *)headerView {
    [self setUpSliderData];
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

#pragma mark - setUpData
- (void)setUpData {
    // 1.加载滚动页
    [self setUpSliderData];
    
    // 2.加载常用
    [self setUpCommonUseFunction];
}


- (void)setUpSliderData {
    [self.headerView loading];
    WCSliderParam *param = [WCSliderParam param:slider];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WCHomeTool homeSliderWithParam:param success:^(NSArray *sliderResult) {
            NSMutableArray *resultArray = [NSMutableArray array];
            [sliderResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                WCSliderResult *result = obj;
                [resultArray addObject:result.path];
            }];
            [self.headerView show:resultArray];
        } failure:^(NSError *error) {
            [self.headerView failure];
        }];
    });
}

- (void)setUpCommonUseFunction {
    
}

@end

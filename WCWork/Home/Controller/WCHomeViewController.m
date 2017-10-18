//
//  ViewController.m
//  WCWork
//
//  Created by information on 2017/9/28.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHomeViewController.h"
#import "WCAddCommonController.h"
#import "WCDynamicListController.h"
#import "WCDynamicDetailController.h"

#import "CustomSegmentControl.h"
#import "WCHomeTool.h"
#import "WCSlideshowHeadView.h"

#import "WCCommonUseCell.h"
#import "WCMoreDynamicCell.h"
#import "WCDynamicCell.h"

#import "WCGroup.h"
#import "WCItem.h"

@interface WCHomeViewController () <UITableViewDataSource,UITableViewDelegate,WCSlideshowHeadViewDelegate,WCMoreDynamicCellDelegate,WCCommonUseCellDelegate,WCAddCommonControllerDelegate>

@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong)  CustomSegmentControl *segmentBar;
@property (nonatomic, strong)  NSMutableArray *dynamicArray;
@property (nonatomic, strong)  WCSlideshowHeadView *headerView;

@property (nonatomic, strong)  NSMutableArray *functions;
@property (nonatomic, strong)  NSMutableArray *commonUseArray;
@property (nonatomic, strong)  UIView *sectionHeaderView;

@property (nonatomic, strong)  WCMoreDynamicCell *moreDynamicCell;

// 煤市行情
@property (nonatomic, strong)  NSMutableArray *coalMarketQuotationsArray;
// 煤市资讯
@property (nonatomic, strong)  NSMutableArray *coalMarketInformationArray;
// 物流仓储
@property (nonatomic, strong)  NSMutableArray *logisticsStorageArray;
// 指数价格
@property (nonatomic, strong)  NSMutableArray *indexPriceArray;
// 当前选择的页签
@property (nonatomic, assign)  NSInteger currentSelectedSegment;
// 请求列
@property (nonatomic, copy)    NSString *columnId;
// segment desc
@property (nonatomic, copy)    NSString *sgementDesc;

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
- (NSMutableArray *)coalMarketQuotationsArray {
    if (!_coalMarketQuotationsArray) {
        _coalMarketQuotationsArray = [NSMutableArray array];
    }
    return _coalMarketQuotationsArray;
}

- (NSMutableArray *)coalMarketInformationArray {
    if (!_coalMarketInformationArray) {
        _coalMarketInformationArray = [NSMutableArray array];
    }
    return _coalMarketInformationArray;
}

- (NSMutableArray *)logisticsStorageArray {
    if (!_logisticsStorageArray) {
        _logisticsStorageArray = [NSMutableArray array];
    }
    return _logisticsStorageArray;
}

- (NSMutableArray *)indexPriceArray {
    if (!_indexPriceArray) {
        _indexPriceArray = [NSMutableArray array];
    }
    return _indexPriceArray;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        switch (_currentSelectedSegment) {
            case 0:
                return self.coalMarketQuotationsArray.count + 1;
                break;
            case 1:
                return self.coalMarketInformationArray.count + 1;
                break;
            case 2:
                return self.logisticsStorageArray.count + 1;
                break;
            case 3:
                return self.indexPriceArray.count + 1;
                break;
            default:
                return 0;
                break;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WCCommonUseCell *commonUseCell = [WCCommonUseCell cellWithTableView:tableView];
        commonUseCell.commonUseArray = self.commonUseArray;
        commonUseCell.delegate = self;
        return commonUseCell;
    }else{
        switch (_currentSelectedSegment) {
            case 0:
                if (indexPath.row < self.coalMarketQuotationsArray.count) {
                    WCDynamicCell *dynamicCell = [WCDynamicCell cellWithTableView:tableView];
                    WCDynamic *wcDynamic = self.coalMarketQuotationsArray[indexPath.row];
                    dynamicCell.wcDynamic = wcDynamic;
                    return dynamicCell;
                }else{
                    return self.moreDynamicCell;
                }
                break;
            case 1:
                if (indexPath.row < self.coalMarketInformationArray.count) {
                    WCDynamicCell *dynamicCell = [WCDynamicCell cellWithTableView:tableView];
                    WCDynamic *wcDynamic = self.coalMarketInformationArray[indexPath.row];
                    dynamicCell.wcDynamic = wcDynamic;
                    return dynamicCell;
                }else{
                    return self.moreDynamicCell;
                }
                break;
            case 2:
                if (indexPath.row < self.logisticsStorageArray.count) {
                    WCDynamicCell *dynamicCell = [WCDynamicCell cellWithTableView:tableView];
                    WCDynamic *wcDynamic = self.logisticsStorageArray[indexPath.row];
                    dynamicCell.wcDynamic = wcDynamic;
                    return dynamicCell;
                }else{
                    return self.moreDynamicCell;
                }
                break;
            case 3:
                if (indexPath.row < self.indexPriceArray.count) {
                    WCDynamicCell *dynamicCell = [WCDynamicCell cellWithTableView:tableView];
                    WCDynamic *wcDynamic = self.indexPriceArray[indexPath.row];
                    dynamicCell.wcDynamic = wcDynamic;
                    return dynamicCell;
                }else{
                    return self.moreDynamicCell;
                }
                break;
            default:
                break;
        }
    }
    return nil;
}

#pragma mark - WCCommonUseCellDelegate
- (void)commonUseCell:(WCCommonUseCell *)commonUseCell btnDidClickWithWCItem:(WCItem *)item {
    if (item.destVcClass == nil) return;
    if ([item.destVcClass isEqualToString:@"WCAddCommonController"]) {
        WCAddCommonController *vc = [[NSClassFromString(item.destVcClass) alloc] init];
        vc.delegate = self;
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}

#pragma mark - WCAddCommonControllerDelegate
- (void)addCommonControllerDidChooseBtn:(WCAddCommonController *)addCommonVc {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:@"dict"];
    NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([[dict allKeys] count] > 0) {
        NSArray *tempArray = [dict allValues];
        tempArray = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            WCItem *i1 = obj1;
            WCItem *i2 = obj2;
            return [i1.order compare:i2.order];
        }];
        _commonUseArray = [tempArray mutableCopy];
    }else {
        _commonUseArray = [NSMutableArray array];
    }
    WCItem *item = [[WCItem alloc] init];
    item.image = @"jiahao";
    item.title = @"添加常用";
    item.destVcClass = @"WCAddCommonController";
    [_commonUseArray addObject:item];
    [self.tableView reloadData];
}

#pragma mark - moreDynamicCell / WCMoreDynamicCellDelegate
- (WCMoreDynamicCell *)moreDynamicCell {
    if (!_moreDynamicCell) {
        _moreDynamicCell = [WCMoreDynamicCell cellWithTableView:self.tableView];
        _moreDynamicCell.delegate = self;
    }
    return _moreDynamicCell;
}

- (void)moreDynamicCellDidRefreshBtn:(WCMoreDynamicCell *)moreDynamicCell {
    [self changeSwipeViewIndex:self.segmentBar];
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0f;
    }else{
        return 40.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return (1 + (_commonUseArray.count - 1) / 4) * 75.0f;
    }else{
        return 44.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderView;
}

- (UIView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[UIView alloc] init];
        // 1.topLineView
        UIView *topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = RGB(238, 238, 238);
        topLineView.frame = CGRectMake(0, 0, ScreenW, 1);
        [_sectionHeaderView addSubview:topLineView];
        // 2.middle segment
        [_sectionHeaderView addSubview:self.segmentBar];
        // 3.bottomLineView
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = RGB(238, 238, 238);
        bottomLineView.frame = CGRectMake(0, 39, ScreenW, 1);
        [_sectionHeaderView addSubview:bottomLineView];
    }
    return _sectionHeaderView;
}

- (CustomSegmentControl *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[CustomSegmentControl alloc] initWithItems:@[@"煤市行情",@"煤市资讯",@"物流仓储",@"指数价格"]];
        _segmentBar.frame = CGRectMake(0, 1, ScreenW, 38);
        _segmentBar.font = [UIFont systemFontOfSize:15];
        _segmentBar.textColor = RGB(100, 100, 100);
        _segmentBar.selectedTextColor = RGB(0, 0, 0);
        _segmentBar.backgroundColor = RGB(238, 238, 238);
        _segmentBar.selectionIndicatorColor = RGB(168, 168, 168);
        [_segmentBar addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentBar;
}

- (void)changeSwipeViewIndex:(CustomSegmentControl *)segmentBar{
    _currentSelectedSegment = segmentBar.selectedSegmentIndex;
    [self.moreDynamicCell show];
    switch (segmentBar.selectedSegmentIndex) {
        case 0:
            _columnId = @"1001";
            _sgementDesc = @"煤市行情";
            [self.tableView reloadData];
            if (!self.coalMarketQuotationsArray.count) {
                [self setUpDynamicData:_columnId resultArray:self.coalMarketQuotationsArray];
            }
            break;
        case 1:
            _columnId = @"1002";
            _sgementDesc = @"煤市资讯";
            [self.tableView reloadData];
            if (!self.coalMarketInformationArray.count) {
                [self setUpDynamicData:_columnId resultArray:self.coalMarketInformationArray];
            }
            break;
        case 2:
            _columnId = @"1003";
            _sgementDesc = @"物流仓储";
            [self.tableView reloadData];
            if (!self.logisticsStorageArray.count) {
                [self setUpDynamicData:_columnId resultArray:self.logisticsStorageArray];
            }
            break;
        case 3:
            _columnId = @"1004";
            _sgementDesc = @"指数价格";
            [self.tableView reloadData];
            if (!self.indexPriceArray.count) {
                [self setUpDynamicData:_columnId resultArray:self.indexPriceArray];
            }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (_currentSelectedSegment) {
        case 0:
            if (indexPath.row < self.coalMarketQuotationsArray.count) {
                WCDynamic *wcDynamic = self.coalMarketQuotationsArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:_columnId];
                dynamicListVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        case 1:
            if (indexPath.row < self.coalMarketInformationArray.count) {
                WCDynamic *wcDynamic = self.coalMarketInformationArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:_columnId];
                dynamicListVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        case 2:
            if (indexPath.row < self.logisticsStorageArray.count) {
                WCDynamic *wcDynamic = self.logisticsStorageArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:_columnId];
                dynamicListVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        case 3:
            if (indexPath.row < self.indexPriceArray.count) {
                WCDynamic *wcDynamic = self.indexPriceArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:_columnId];
                dynamicListVc.title = _sgementDesc;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        default:
            break;
    }
}

#pragma mark - setUpData
- (void)setUpData {
    // 1.加载滚动页
    [self setUpSliderData];
    
    // 2.加载常用
    [self setUpCommonUseFunction];
    
    // 3.加载
    [self changeSwipeViewIndex:self.segmentBar];
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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if (![userDefault boolForKey:@"firstLaunch"]) {
        [userDefault setBool:YES forKey:@"firstLaunch"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        WCGroup *group = [self.functions lastObject];
        for (WCItem *item in group.items) {
            [dict setObject:item forKey:item.title];
        }
        NSData *new_data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [userDefault setObject:new_data forKey:@"dict"];
        [userDefault synchronize];
    }
    
    NSData *data = [userDefault objectForKey:@"dict"];
    NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([[dict allKeys] count] > 0) {
        NSArray *tempArray = [dict allValues];
        tempArray = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            WCItem *i1 = obj1;
            WCItem *i2 = obj2;
            return [i1.order compare:i2.order];
        }];
        _commonUseArray = [tempArray mutableCopy];
    }else{
        _commonUseArray = [NSMutableArray array];
    }
    WCItem *item = [[WCItem alloc] init];
    item.image = @"jiahao";
    item.title = @"添加常用";
    item.destVcClass = @"WCAddCommonController";
    [_commonUseArray addObject:item];
}

- (NSMutableArray *)functions {
    if (_functions == nil) {
        // 加载JSON的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"function" ofType:@"json"];
        
        // 加载JSON文件
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        // 将JSON数据转为NSArray或者NSDictionary
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // 将字典转成模型
        NSMutableArray *itemArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            if ([[dict objectForKey:@"header"] isEqualToString:@"办公"]) {
                WCGroup *group = [WCGroup groupWithDict:dict];
                [itemArray addObject:group];
            }
        }
        _functions = itemArray;
    }
    return _functions;
}

- (void)setUpDynamicData:(NSString *)columnId resultArray:(NSMutableArray * )resultArray{
    [self.moreDynamicCell loading];
    WCDynamicParam *param = [WCDynamicParam param:dynamic];
    param.page = @(1);
    param.columnId = columnId;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WCHomeTool homeDynamicWithParam:param success:^(WCDynamicResult *dynamicResult) {
            [self.moreDynamicCell show];
            [resultArray addObjectsFromArray:dynamicResult.NewsList];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self.moreDynamicCell failure];
        }];
    });
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

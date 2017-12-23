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

#import "WCHomeTool.h"
#import "WCSlideshowHeadView.h"
#import "WCSliderDetailViewController.h"

#import "WCSectionHeaderView.h"
#import "WCSectionFooterView.h"
#import "WCSectionFooterDetailViewController.h"

#import "WCCommonUseCell.h"
#import "WCMoreDynamicCell.h"
#import "WCDynamicCell.h"
#import "WCTechnologySupportCell.h"

#import "WCGroup.h"
#import "WCItem.h"

@interface WCHomeViewController () <UITableViewDataSource,UITableViewDelegate,WCSlideshowHeadViewDelegate,WCMoreDynamicCellDelegate,WCCommonUseCellDelegate,WCAddCommonControllerDelegate,WCSectionHeaderViewDelegate,WCSectionFooterViewDelegate>

@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong)  NSMutableArray *dynamicArray;
@property (nonatomic, strong)  WCSlideshowHeadView *headerView;

@property (nonatomic, strong)  NSMutableArray *functions;
@property (nonatomic, strong)  NSMutableArray *commonUseArray;

@property (nonatomic, strong)  WCSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong)  WCMoreDynamicCell *moreDynamicCell;
@property (nonatomic, strong)  WCTechnologySupportCell *technologySupportCell;

@property (nonatomic, strong)  WCSectionFooterView *sectionFooterView;

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
// segment array
@property (nonatomic, strong)  NSArray *item;
// 头条滚动
@property (nonatomic, strong)  NSArray *sliderResult;
// section footerView Result
@property (nonatomic, strong)  NSArray *sectionFooterViewResult;
@end

@implementation WCHomeViewController

#pragma mark -lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"物产中大集团";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:tableView];
    
    //init Data
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

#pragma mark - WCSlideshowHeadViewDelegate
- (void)slideShowHeaderViewDidClickRefreshBtn:(WCSlideshowHeadView *)headerView {
    [self setUpSliderData];
}

- (void)slideShowHeaderView:(WCSlideshowHeadView *)headerView selectedIndex:(NSInteger)index {
    WCSliderResult *result = [_sliderResult objectAtIndex:index];
    WCSliderDetailViewController *sliderDetailVc = [[WCSliderDetailViewController alloc] initWithSliderResult:result];
    [self.navigationController pushViewController:sliderDetailVc animated:YES];
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
                return self.coalMarketQuotationsArray.count + 2;
                break;
            case 1:
                return self.coalMarketInformationArray.count + 2;
                break;
            case 2:
                return self.logisticsStorageArray.count + 2;
                break;
            case 3:
                return self.indexPriceArray.count + 2;
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
                }else if(indexPath.row == self.coalMarketQuotationsArray.count){
                    return self.moreDynamicCell;
                }else{
                    return self.technologySupportCell;
                }
                break;
            case 1:
                if (indexPath.row < self.coalMarketInformationArray.count) {
                    WCDynamicCell *dynamicCell = [WCDynamicCell cellWithTableView:tableView];
                    WCDynamic *wcDynamic = self.coalMarketInformationArray[indexPath.row];
                    dynamicCell.wcDynamic = wcDynamic;
                    return dynamicCell;
                }else if(indexPath.row == self.coalMarketInformationArray.count){
                    return self.moreDynamicCell;
                }else{
                    return self.technologySupportCell;
                }
                break;
            case 2:
                if (indexPath.row < self.logisticsStorageArray.count) {
                    WCDynamicCell *dynamicCell = [WCDynamicCell cellWithTableView:tableView];
                    WCDynamic *wcDynamic = self.logisticsStorageArray[indexPath.row];
                    dynamicCell.wcDynamic = wcDynamic;
                    return dynamicCell;
                }else if(indexPath.row == self.logisticsStorageArray.count){
                    return self.moreDynamicCell;
                }else{
                    return self.technologySupportCell;
                }
                break;
            case 3:
                if (indexPath.row < self.indexPriceArray.count) {
                    WCDynamicCell *dynamicCell = [WCDynamicCell cellWithTableView:tableView];
                    WCDynamic *wcDynamic = self.indexPriceArray[indexPath.row];
                    dynamicCell.wcDynamic = wcDynamic;
                    return dynamicCell;
                }else if(indexPath.row == self.indexPriceArray.count){
                    return self.moreDynamicCell;
                }else{
                    return self.technologySupportCell;
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
        UIViewController *desVc = nil;
        if ([item.load intValue]) {
            WCLoginViewController *loginVc = [WCLoginViewController instance];
            if (loginVc.logining) {
                desVc = [[NSClassFromString(item.destVcClass) alloc] init];
                desVc.title = item.title;
            } else {
                desVc = loginVc;
            }
        }else{
            desVc = [[NSClassFromString(item.destVcClass) alloc] init];
            desVc.title = item.title;
        }
        if (desVc == nil) return;
        [self.navigationController pushViewController:desVc animated:YES];
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
    [self changeSwipeViewIndex];
}

#pragma mark - WCTechnologySupportCell
- (WCTechnologySupportCell *)technologySupportCell {
    if (!_technologySupportCell) {
        _technologySupportCell = [WCTechnologySupportCell cellWithTableView:self.tableView];
    }
    return _technologySupportCell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!_item.count) return;
    WCSectionHeaderViewResult *result = [_item objectAtIndex:_currentSelectedSegment];
    switch (_currentSelectedSegment) {
        case 0:
            if (indexPath.row < self.coalMarketQuotationsArray.count) {
                WCDynamic *wcDynamic = self.coalMarketQuotationsArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:result.ColumnId];
                dynamicListVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        case 1:
            if (indexPath.row < self.coalMarketInformationArray.count) {
                WCDynamic *wcDynamic = self.coalMarketInformationArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:result.ColumnId];
                dynamicListVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        case 2:
            if (indexPath.row < self.logisticsStorageArray.count) {
                WCDynamic *wcDynamic = self.logisticsStorageArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:result.ColumnId];
                dynamicListVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        case 3:
            if (indexPath.row < self.indexPriceArray.count) {
                WCDynamic *wcDynamic = self.indexPriceArray[indexPath.row];
                WCDynamicDetailController *dynamicDetailVc = [[WCDynamicDetailController alloc] initWithWcDynamic:wcDynamic];
                dynamicDetailVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicDetailVc animated:YES];
            }else{
                WCDynamicListController *dynamicListVc = [[WCDynamicListController alloc] initWithColumnId:result.ColumnId];
                dynamicListVc.title = result.ColumnName;
                [self.navigationController pushViewController:dynamicListVc animated:YES];
            }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return ScreenW / 4;
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 44.0f;
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return (1 + (_commonUseArray.count - 1) / 4) * 75.0f;
    }else{
        switch (_currentSelectedSegment) {
            case 0:
                if (indexPath.row < _coalMarketQuotationsArray.count) {
                    return 110.0f;
                }else if(indexPath.row == _coalMarketQuotationsArray.count){
                    return 44.0f;
                }else{
                    return 20.0f;
                }
                break;
            case 1:
                if (indexPath.row < _coalMarketInformationArray.count) {
                    return 110.0f;
                }else if(indexPath.row == _coalMarketInformationArray.count){
                    return 44.0f;
                }else{
                    return 20.0f;
                }
                break;
            case 2:
                if (indexPath.row < _logisticsStorageArray.count) {
                    return 110.0f;
                }else if(indexPath.row == _logisticsStorageArray.count){
                    return 44.0f;
                }else{
                    return 20.0f;
                }
                break;
            case 3:
                if (indexPath.row < _indexPriceArray.count) {
                    return 110.0f;
                }else if(indexPath.row == _indexPriceArray.count){
                    return 44.0f;
                }else{
                    return 20.0f;
                }
                break;
            default:
                return 44.0f;
                break;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return self.sectionFooterView;
    }
    return nil;
}

- (WCSectionFooterView *)sectionFooterView {
    if (!_sectionFooterView) {
        _sectionFooterView = [WCSectionFooterView footerView];
        _sectionFooterView.delegate = self;
    }
    return _sectionFooterView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.sectionHeaderView;
    }
    return nil;
}

- (WCSectionHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [WCSectionHeaderView headerView];
        _sectionHeaderView.delegate = self;
    }
    return _sectionHeaderView;
}

- (void)changeSwipeViewIndex{
    if (!_item.count) return;
    [self.moreDynamicCell show];
    WCSectionHeaderViewResult *result = [_item objectAtIndex:_currentSelectedSegment];
    switch (_currentSelectedSegment) {
        case 0:
            [self.tableView reloadData];
            if (!self.coalMarketQuotationsArray.count) {
                [self setUpDynamicData:result.ColumnId resultArray:self.coalMarketQuotationsArray];
            }
            break;
        case 1:
            [self.tableView reloadData];
            if (!self.coalMarketInformationArray.count) {
                [self setUpDynamicData:result.ColumnId resultArray:self.coalMarketInformationArray];
            }
            break;
        case 2:
            [self.tableView reloadData];
            if (!self.logisticsStorageArray.count) {
                [self setUpDynamicData:result.ColumnId resultArray:self.logisticsStorageArray];
            }
            break;
        case 3:
            [self.tableView reloadData];
            if (!self.indexPriceArray.count) {
                [self setUpDynamicData:result.ColumnId resultArray:self.indexPriceArray];
            }
            break;
        default:
            break;
    }
}

#pragma mark - WCSectionFooterViewDelegate
- (void)sectionFooterViewDidClickRefreshBtn:(WCSectionFooterView *)footerView {
    [self setUpSectionFooterView];
}

- (void)sectionFooterView:(WCSectionFooterView *)footerView selectedIndex:(NSInteger)index {
    WCSectionFooterViewResult *result = [_sectionFooterViewResult objectAtIndex:index];
    WCSectionFooterDetailViewController *sectionFooterDetailVc = [[WCSectionFooterDetailViewController alloc] initWithSectionFooterViewResult:result];
    [self.navigationController pushViewController:sectionFooterDetailVc animated:YES];
}

#pragma mark - WCSectionHeaderViewDelegate
- (void)sectionHeaderViewDidClickRefreshBtn:(WCSectionHeaderView *)headerView {
    [self setUpSectionHeaderView];
}

- (void)sectionHeaderView:(WCSectionHeaderView *)headerView selectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _currentSelectedSegment = selectedSegmentIndex;
    [self changeSwipeViewIndex];
}

#pragma mark - setUpData
- (void)setUpData {
    // 1.加载滚动页
    [self setUpSliderData];
    
    // 2.加载常用
    [self setUpCommonUseFunction];
    
    // 3.价值 tableView sectionFooterView
    [self setUpSectionFooterView];
    
    // 4.加载 tableView sectionHeaderView
    [self setUpSectionHeaderView];
}

- (void)setUpSliderData {
    [self.headerView loading];
    WCSliderParam *param = [WCSliderParam param:slider];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WCHomeTool homeSliderWithParam:param success:^(NSArray *sliderResult) {
            _sliderResult = sliderResult;
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
        /*WCGroup *group = [self.functions lastObject];
        for (WCItem *item in group.items) {
            [dict setObject:item forKey:item.title];
        }*/
        for (WCItem *item in self.functions) {
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
            WCGroup *group = [WCGroup groupWithDict:dict];
            for (WCItem *item in group.items) {
                if ([item.firstShow isEqualToString:@"1"]) {
                    [itemArray addObject:item];
                }
            }
        }
        _functions = itemArray;
    }
    return _functions;
}

- (void)setUpSectionFooterView {
    [self.sectionFooterView loading];
    WCSectionFooterViewParam *param = [WCSectionFooterViewParam param:sectionSlider];
    [WCHomeTool homeSectionFooterViewParam:param success:^(NSArray *sectionFooterViewResult) {
        _sectionFooterViewResult = sectionFooterViewResult;
        NSMutableArray *resultArray = [NSMutableArray array];
        [sectionFooterViewResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WCSectionFooterViewResult *result = obj;
            [resultArray addObject:result.ImgUrl];
        }];
        [self.sectionFooterView show:resultArray];
    } failure:^(NSError *error) {
        [self.sectionFooterView failure];
    }];
}

- (void)setUpSectionHeaderView {
    [self.sectionHeaderView loading];
    WCSectionHeaderViewParam *param = [WCSectionHeaderViewParam param:homeSegement];
    [WCHomeTool homeSectionHeaderViewParam:param success:^(NSArray *sectionHeaderViewResult) {
        [self dealSectionHeaderView:sectionHeaderViewResult];
    } failure:^(NSError *error) {
        [self.sectionHeaderView failure:@"世界上最遥远的距离就是断网"];
    }];
}

- (void)dealSectionHeaderView:(NSArray *)result {
    _item = result;
    if (result.count > 0) {
        NSMutableArray *resultArray = [NSMutableArray array];
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WCSectionHeaderViewResult *result = obj;
            [resultArray addObject:result.ColumnName];
        }];
        [self.sectionHeaderView show:resultArray];
        [self sectionHeaderView:self.sectionHeaderView selectedSegmentIndex:0];
    }else {
        [self.sectionHeaderView failure:@"网络正常,未获取数据"];
    }
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

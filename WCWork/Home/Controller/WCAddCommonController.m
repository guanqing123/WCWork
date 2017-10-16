//
//  WCAddCommonController.m
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddCommonController.h"
#import "WCGroup.h"
#import "WCAddCommonCell.h"

@interface WCAddCommonController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong)  NSArray *functions;
@property (nonatomic, strong)  NSMutableDictionary *selectFunsDict;
@end

@implementation WCAddCommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - functions 懒加载
- (NSArray *)functions {
    if (!_functions) {
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
            [itemArray addObject:group];
        }
        _functions = itemArray;
    }
    return _functions;
}

#pragma mark - selectFunsDict
- (NSMutableDictionary *)selectFunsDict {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"dict"];
    NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _selectFunsDict = [dict mutableCopy];
    return _selectFunsDict;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.functions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WCGroup *group = [self.functions objectAtIndex:section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCAddCommonCell *cell = [WCAddCommonCell cellWithTableView:tableView];
    
    WCGroup *group = [self.functions objectAtIndex:indexPath.section];
    WCItem *item = [group.items objectAtIndex:indexPath.row];
    
    cell.item = item;
    cell.choose = [[self.selectFunsDict allKeys] containsObject:item.title];
    
    return cell;
}

#pragma mark - tableView delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    WCGroup *group = self.functions[section];
    return group.header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WCGroup *group = [self.functions objectAtIndex:indexPath.section];
    WCItem *item = [group.items objectAtIndex:indexPath.row];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *old_data = [userDefault objectForKey:@"dict"];
    NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:old_data];
    
    if ([[dict allKeys] count] < 1) {
        dict = [NSMutableDictionary dictionary];
    }
    
    if ([[dict allKeys] containsObject:item.title]) {
        [dict removeObjectForKey:item.title];
    }else{
        [dict setObject:item forKey:item.title];
    }
    
    NSData *new_data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [userDefault setObject:new_data forKey:@"dict"];
    [userDefault synchronize];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    if ([self.delegate respondsToSelector:@selector(addCommonControllerDidChooseBtn:)]) {
        [self.delegate addCommonControllerDidChooseBtn:self];
    }
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

//
//  WCMeViewController.m
//  WCWork
//
//  Created by information on 2017/9/29.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCMeViewController.h"
#import "WCMeTableHeaderView.h"
#import "WCMeTableFooterView.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingGroup.h"

#import "WCHelpViewController.h"

@interface WCMeViewController () <WCMeTableFooterViewDelegate,WCLoginViewControllerDelegate>
@property (nonatomic, strong)  WCMeTableHeaderView *tableHeaderView;
@property (nonatomic, strong)  WCMeTableFooterView *tableFooterView;
@end

@implementation WCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = self.tableFooterView;
    
    [self setupData];
    
    [self setupLoginMsg];
}

- (void)setupData {
    //帮助
    SettingItem *help = [SettingArrowItem itemWithIcon:@"help" title:@"帮助" destVcClass:[WCHelpViewController class]];
    SettingItem *autoLogin = [SettingSwitchItem itemWithIcon:@"zidongdenglu" title:@"自动登录"];
    SettingGroup *firstGroup = [[SettingGroup alloc] init];
    firstGroup.items = @[help, autoLogin];
    [self.data addObject:firstGroup];
    
    //关于
    SettingItem *about = [SettingArrowItem itemWithIcon:@"guanyu" title:@"关于" destVcClass:nil];
    SettingGroup *secondGroup = [[SettingGroup alloc] init];
    secondGroup.items = @[about];
    [self.data addObject:secondGroup];
}

- (void)setupLoginMsg {
    //判断登录情况
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    if (loginVc.isLogined) {
        [self.tableHeaderView active:loginVc.loginAccount.trueName];
        [self.tableFooterView active];
    }else{
        [self.tableHeaderView unactive];
        [self.tableFooterView unactive];
    }
}

#pragma mark - tableHeaderView
- (WCMeTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [WCMeTableHeaderView headerView];
    }
    return _tableHeaderView;
}

#pragma mark - tableFooterView / tableFooterViewDelegate
- (WCMeTableFooterView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [WCMeTableFooterView footerView];
        _tableFooterView.delegate = self;
    }
    return _tableFooterView;
}

- (void)meTableFooterViewDidLoginOrResignBtn:(WCMeTableFooterView *)meTableFooterView {
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    if (loginVc.isLogined) {
        loginVc.logining = NO;
        loginVc.loginAccount = nil;
        [self.tableHeaderView unactive];
        [self.tableFooterView unactive];
        
        // 删除文件
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isHave = [fileManager fileExistsAtPath:WCAccountFile];
        if (isHave) {
            NSError *error;
            [fileManager removeItemAtPath:WCAccountFile error:&error];
        }
        
    }else{
        loginVc.delegate = self;
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}

#pragma mark - WCLoginViewControllerDelegate
- (void)loginViewControllerDidFinishLogin:(WCLoginViewController *)loginVc {
    [self.tableHeaderView active:loginVc.loginAccount.trueName];
    [self.tableFooterView active];
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

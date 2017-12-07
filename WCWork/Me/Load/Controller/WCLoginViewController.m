//
//  WCLoginViewController.m
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCLoginViewController.h"
#import "WCLoginCell.h"
#import "WCLoginSectionFooterView.h"
#import <CloudPushSDK/CloudPushSDK.h>

@interface WCLoginViewController () <UITableViewDataSource,UITableViewDelegate,WCLoginSectionFooterViewDelegate,WCLoginCellDelegate>
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic, strong)  NSArray *loginArray;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@end

@implementation WCLoginViewController

static WCLoginViewController *loginVc = nil;
+ (instancetype)instance {
    // dispatch_once_t 是线程安全的,onceToken默认为0
    static dispatch_once_t onceToken;
    // dispatch_once 宏可以保证块代码中的指令只被执行一次
    dispatch_once(&onceToken, ^{
        // 永远只会被执行一次
        loginVc = [[super allocWithZone:NULL] init];
        loginVc.title = @"登录";
    });
    return loginVc;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [WCLoginViewController instance];
}

-(instancetype)copyWithZone:(struct _NSZone *)zone {
    return [WCLoginViewController instance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(@available(iOS 11.0, *)){
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    _tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loginArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCLoginCell *loginCell = [WCLoginCell cellWithTableView:tableView];
    loginCell.delegate = self;
    
    NSDictionary *loginDict = self.loginArray[indexPath.row];
    loginCell.loginDict = loginDict;
    
    return loginCell;
}

#pragma mark - tableViewCell delegate
- (void)loginCell:(WCLoginCell *)loginCell didEditTextFieldChange:(NSString *)text {
    if ([[loginCell.loginDict objectForKey:@"secret"] boolValue]) {
        self.password = text;
    }else{
        self.username = text;
    }
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WCLoginSectionFooterView *sectionFooterView = [WCLoginSectionFooterView footerViewWithTableView:tableView];
    sectionFooterView.delegate = self;
    return sectionFooterView;
}

#pragma mark - WCLoginSectionFooterViewDelegate
- (void)loginSectionFooterViewDidClickLoginBtn:(WCLoginSectionFooterView *)footerView {
    if (![self.username length] || ![self.password length]) {
        [MBProgressHUD showError:@"信息必须填写完整"];
        return;
    }
    [MBProgressHUD showMessage:@"登录验证中..."];
    WCLoginParam *param = [WCLoginParam param:login];
    param.gh = self.username;
    param.mm = self.password;
    [WCLoginTool loginWithParam:param success:^(WCLoginResult *loginResult) {
        [MBProgressHUD hideHUD];
        if (loginResult.error) {
            [MBProgressHUD showError:loginResult.errorMsg];
        }else{
            loginResult.entry.password = self.password;
            self.loginAccount = loginResult.entry;
            self.logining = YES;
            
            [CloudPushSDK bindAccount:param.gh withCallback:^(CloudPushCallbackResult *res) {
                if (res.success) {
                    WCLog(@"帐号%@绑定成功...",param.gh);
                }else{
                    WCLog(@"帐号 绑定 error = %@",res.error);
                }
            }];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            BOOL autoLogin = [userDefaults boolForKey:@"自动登录"];
            if (autoLogin) {
                [WCLoginTool saveLoginAccount:self.loginAccount];
            }
            [self.tableView reloadData];
            [self.navigationController popViewControllerAnimated:YES];
            if ([self.delegate respondsToSelector:@selector(loginViewControllerDidFinishLogin:)]) {
                [self.delegate loginViewControllerDidFinishLogin:self];
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark - loginArray
- (NSArray *)loginArray {
    if (!_loginArray) {
        _loginArray = @[@{@"titleLabel":@"用户名:",@"placeholder":@"工号",@"secret":@"NO",@"padding":@"0"},@{@"titleLabel":@"密码:",@"placeholder":@"请输入密码",@"secret":@"YES",@"padding":@"10"}];
    }
    return _loginArray;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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

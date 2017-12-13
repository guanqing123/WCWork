//
//  WCCheckAttendenceViewController.m
//  HYWork
//
//  Created by information on 16/3/30.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import "WCCheckAttendenceViewController.h"
#import "WCCheckAttendenceMapViewCell.h"
#import "WCCheckAttendenceBtnCell.h"
#import "WCCheckAttendenceSignInOrOutCell.h"

#import "WCCheckAttendenceTool.h"
#import "SFHFKeychainUtils.h"
#import "APIKey.h"

@interface WCCheckAttendenceViewController () <UITableViewDataSource,UITableViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,WCCheckAttendenceMapViewCellDelegate,WCCheckAttendenceBtnCellDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) MAMapView  *mapView;

@property (nonatomic, strong)  NSMutableArray *regions;

@property (nonatomic, weak) UITableView  *tableView;

@property (nonatomic, strong)  AMapLocationManager *locationManager;

@property (nonatomic, copy) NSString *wzStr;

@property (nonatomic, assign) CGRect *frame;

@property (nonatomic, strong)  WCCheckAttendenceResult *result;

@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *signInTime;

/**
 *  考勤按钮
 */
@property (nonatomic, copy) NSString *inImgName;

@property (nonatomic, copy) NSString *outImgName;
/**
 *  考勤按钮状态
 */
@property (nonatomic, assign) BOOL kqClick;

/**
 * 地址按钮状态
 */
@property (nonatomic, assign) BOOL click;
/**
 * 更新地址按钮
 */
@property (nonatomic, copy) NSString *btnImg;

@property (nonatomic, assign) int count;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *userName;

@end

@implementation WCCheckAttendenceViewController
@synthesize mapView = _mapView;

#pragma mark loadView
- (void)loadView {
    [super loadView];
    //1.初始化APIKey
    [self configureAPIKey];
    //2.初始化 mapView
    [self initMapView];
    //3.初始化数据
    [self initData];
}

- (void)initData {
    _wzStr = @"正在定位...";
    _inImgName = @"kqBtnNI";
    _outImgName = @"kqBtnNO";
    _kqClick = NO;
    _click = NO;
    _btnImg = @"shuaxindinweiH";
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    _userName = loginVc.loginAccount.userName;
}

- (void)configureAPIKey {
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}

- (MAMapView *)mapView {
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] init];
    }
    return _mapView;
}

- (void)initMapView {
    self.mapView.delegate = self;
}


#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configLocationManager];
    
    self.regions = [[NSMutableArray alloc] init];
    
    self.mapView.showsUserLocation = YES;
    
    [self setUp];
    
    [self initDateAndTime];
}

#pragma mark - 注册当app从后台进入前台的时候触发的事件
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)appWillEnterForegroundNotification {
    [self initDateAndTime];
    [self initData];
    [self.tableView reloadData];
    [self refreshLocationWithLocationManagerWhenAppActive:self.locationManager];
}

#pragma mark - 当view消失的时候 注销通知
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - viewDidAppear
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getCurrentLocation];
}

- (void)getCurrentLocation {
    [MBProgressHUD showMessage:@"定位中..." toView:self.view];
    __weak typeof(self) weakSelf = self;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [weakSelf didSomeThingWithReGeocode:regeocode Error:error];
        [weakSelf addCircleReionForCoordinate:location.coordinate Regeocode:regeocode NSError:error];
    }];
}

- (void)didSomeThingWithReGeocode:(AMapLocationReGeocode *)regeocode Error:(NSError *)error{
    if (error) {
        _wzStr = @"网络连接异常...";
    }else{
        _wzStr = regeocode.formattedAddress;
    }
    _btnImg = @"shuaxindinweiN";
    _click = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)addCircleReionForCoordinate:(CLLocationCoordinate2D)coordinate Regeocode:(AMapLocationReGeocode *)regeocode NSError:(NSError *)error {
    if (!error) {
        WCCheckAttendenceParam *checkAttendenceParam = [WCCheckAttendenceParam param:KQ1];
        checkAttendenceParam.gh = _userName;
        [WCCheckAttendenceTool checkAttendenceWithParam:checkAttendenceParam success:^(WCCheckAttendenceResult *result) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (result.errorMsg) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"errorcode:%@",result.errorMsg] toView:self.view];
            } else {
                _result = result;
                for (WCCheckAttendenceFence *fence in result.fence) {
                    [self circleWithLatitude:fence.lbs_latitude longitude:fence.lsb_longitude radius:[fence.lbs_radius floatValue] identifier:[NSString stringWithFormat:@"%@",fence]];
                }
                _count = [result.checkInTimes intValue];
                // 局部刷新
                NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
                NSIndexPath *fourthPath = [NSIndexPath indexPathForRow:3 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:@[firstPath,fourthPath] withRowAnimation:UITableViewRowAnimationFade];
                [self setVisiableMapRect:coordinate];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络异常,请刷新定位" toView:self.view];
        }];
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"定位异常,请刷新" toView:self.view];
    }
}

- (void)circleWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude radius:(CGFloat)radius identifier:(NSString *)identifier {
    //1.确定圆心
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    //2.创建围栏
    AMapLocationCircleRegion *circleRegion = [[AMapLocationCircleRegion alloc] initWithCenter:coordinate radius:radius identifier:identifier];
    //3.添加地理围栏
    [self.locationManager startMonitoringForRegion:circleRegion];
    //4.保存地理围栏
    [self.regions addObject:circleRegion];
    //5.添加Overlay
    MACircle *circle = [MACircle circleWithCenterCoordinate:coordinate radius:radius];
    [self.mapView addOverlay:circle];
}

- (void)setVisiableMapRect:(CLLocationCoordinate2D)coordinate {
    
    MACircle *visiable = [MACircle circleWithCenterCoordinate:coordinate radius:150];
    [self.mapView setVisibleMapRect:visiable.boundingMapRect];
    
    
    //指北针
    //self.mapView.compassOrigin = CGPointMake(10, 10);
    self.mapView.showsCompass = NO;
    
    for (AMapLocationCircleRegion *region in self.regions) {
        if ([region containsCoordinate:coordinate]) {
            _inImgName = @"kqBtnI";
            _outImgName = @"kqBtnO";
            _kqClick = YES;
            //局部刷新
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didEnterRegion:(AMapLocationRegion *)region {
    _inImgName = @"kqBtnI";
    _outImgName = @"kqBtnO";
    _kqClick = YES;
    //刷新按钮
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self refreshLocationWithLocationManager:manager];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didExitRegion:(AMapLocationRegion *)region {
    _inImgName = @"kqBtnNI";
    _outImgName = @"kqBtnNO";
    _kqClick = NO;
    //刷新按钮
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self refreshLocationWithLocationManager:manager];
}

#pragma mark - 封装进入和离开监控区域
- (void)refreshLocationWithLocationManager:(AMapLocationManager *)manager {
    __weak typeof(self) weakSelf = self;
    [manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [weakSelf didSomeThingWithReGeocode:regeocode Error:error];
        MACircle *circle = [MACircle circleWithCenterCoordinate:location.coordinate radius:150];
        [weakSelf.mapView setVisibleMapRect:circle.boundingMapRect];
    }];
}

#pragma mark - 封装进入和离开监控区域(重构) 因为后台进入前台要进行判断当前点是不是在圈内
- (void)refreshLocationWithLocationManagerWhenAppActive:(AMapLocationManager *)manager {
    [MBProgressHUD showMessage:@"刷新中..." toView:self.view];
    __weak typeof(self) weakSelf = self;
    [manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf didSomeThingWithReGeocode:regeocode Error:error];
        [weakSelf setVisiableMapRect:location.coordinate];
    }];
}

#pragma mark - MAMapViewDelegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonRenderer *polylineRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polylineRenderer.lineWidth = 5.0f;
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    else if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.lineWidth = 5.0f;
        circleRenderer.strokeColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:0.6];
        circleRenderer.fillColor = [UIColor colorWithRed:180.0f/255.0f green:180.0f/255.0f blue:180.0f/255.0 alpha:0.6];
        return circleRenderer;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation) {
        CGSize size = self.mapView.frame.size;
        CGPoint point = [self.mapView convertCoordinate:userLocation.coordinate toPointToView:self.mapView];
        if ((point.x <=0 || point.y <=0 || point.x >=size.width || point.y >=size.height) && _click) {
            MACircle *visiable = [MACircle circleWithCenterCoordinate:userLocation.coordinate radius:150];
            [self.mapView setVisibleMapRect:visiable.boundingMapRect];
        }
    }
}

#pragma mark - 初始化 locationManager
- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
}

#pragma mark - 初始化 导航 tableView
- (void)setUp {
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction)];
    self.navigationItem.leftBarButtonItem = left;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - 初始化日期 时间
- (void)initDateAndTime {
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    long week = [comps weekday];
    long year=[comps year];
    long month = [comps month];
    long day = [comps day];
    long hour = [comps hour];
    long  minute = [comps minute];
    _date = [NSString stringWithFormat:@"%@: %ld.%02ld.%02ld",[arrWeek objectAtIndex:week - 1],year,month,day];
    _time = [NSString stringWithFormat:@"当前时间: %02ld:%02ld",hour,minute];
}

#pragma mark - 页面退回 释放资源
- (void)returnAction {
    [self.regions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.locationManager stopMonitoringForRegion:(AMapLocationRegion *)obj];
    }];
    self.mapView.showsUserLocation = NO;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    self.mapView.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width;
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 30)];
        nameLabel.text = [WCLoginViewController instance].loginAccount.trueName;
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:nameLabel];
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, width - 120, 30)];
        descLabel.text = [NSString stringWithFormat:@"今日您已考勤 %zi 次", _count];
        descLabel.font = [UIFont systemFontOfSize:15];
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.textColor = RGBA(150, 150, 150, 0.8);
        [cell.contentView addSubview:descLabel];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 43, ScreenW - 30, 1)];
        view.backgroundColor = RGBA(238, 238, 238, 0.8);
        [cell.contentView addSubview:view];
        return cell;
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *xqView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 20, 20)];
        xqView.image = [UIImage imageNamed:@"rili"];
        [cell.contentView addSubview:xqView];
        
        UILabel *xqLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, width / 2 - 20, 20)];
        xqLabel.text = _date;
        xqLabel.font = [UIFont systemFontOfSize:14];
        xqLabel.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
        [cell.contentView addSubview:xqLabel];
        
        UIImageView *sjView = [[UIImageView alloc] initWithFrame:CGRectMake(width -145, 20, 20, 20)];
        sjView.image = [UIImage imageNamed:@"shijian"];
        [cell.contentView addSubview:sjView];
        
        UILabel *sjLabel = [[UILabel alloc] initWithFrame:CGRectMake(width - 125, 20, 110, 20)];
        sjLabel.text = _time;
        sjLabel.textAlignment = NSTextAlignmentRight;
        sjLabel.font = [UIFont systemFontOfSize:14];
        sjLabel.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
        [cell.contentView addSubview:sjLabel];
        return cell;
    }
    else if (indexPath.row == 2) {
        WCCheckAttendenceMapViewCell *mapViewCell = [WCCheckAttendenceMapViewCell cellWithTableView:tableView];
        mapViewCell.delegate = self;
        mapViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [mapViewCell setBtnImg:_btnImg andClick:_click];
        CGSize size = mapViewCell.frame.size;
        self.mapView.frame = CGRectMake(15, 40, size.width - 30, size.height - 40);
        [mapViewCell.contentView addSubview:self.mapView];
        mapViewCell.wz = _wzStr;
        return mapViewCell;
    }
    else if (indexPath.row == 3) {
        WCCheckAttendenceSignInOrOutCell *signInOrOutCell = [WCCheckAttendenceSignInOrOutCell cellWithTableView:tableView];
        signInOrOutCell.checkInLog = _result.checkInLog;
        return signInOrOutCell;
    }
    else if (indexPath.row == 4) {
        WCCheckAttendenceBtnCell *btnCell = [WCCheckAttendenceBtnCell cellWithTableView:tableView];
        btnCell.delegate = self;
        btnCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [btnCell setInBtnImg:_inImgName outBtnImg:_outImgName canClick:_kqClick];
        return btnCell;
    }
    return nil;
}

#pragma mark - WCCheckAttendenceMapViewCellDelegate
- (void)checkAttendenceMapViewCellBtnClickToRefreshLocation:(WCCheckAttendenceMapViewCell *)checkAttendenceMapViewCell {
    _btnImg = @"shuaxindinweiH";
    _click = NO;
    _wzStr = @"正在定位...";
    [checkAttendenceMapViewCell setBtnImg:@"shuaxindinweiH" andClick:NO];
    checkAttendenceMapViewCell.wz = @"正在定位...";
    if (self.regions.count > 0) {
        [self refreshLocationWithLocationManager:self.locationManager];
    }else{
        [self getCurrentLocation];
    }
}

/**
 *  屏幕截图
 */
- (void)jietu {
    [self.mapView takeSnapshotInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
        NSData *imageData = UIImagePNGRepresentation(resultImage);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *saveImagePath = [documentDirectory stringByAppendingPathComponent:@"saveFore1.png"];
        [imageData writeToFile:saveImagePath atomically:YES];
    }];
}

#pragma mark - UUID
- (NSString *)uuid {
    NSString *SERVICE_NAME = @"com.wuchan.WCWork";
    NSString *str = [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName:SERVICE_NAME error:nil];
    if ([str length] <= 0) {
        str = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SFHFKeychainUtils storeUsername:@"UUID" andPassword:str forServiceName:SERVICE_NAME updateExisting:1 error:nil];
    }
    return str;
}

#pragma mark - WCCheckAttendenceBtnCellDelegate
- (void)checkAttendenceBtnCellDelegateClickInBtn:(WCCheckAttendenceBtnCell *)checkAttendenceBtnCell {
    [checkAttendenceBtnCell setInBtnImg:@"kqBtnNI" outBtnImg:@"kqBtnNO" canClick:NO];
    NSDictionary *uuid = @{@"device":self.uuid};
    if ((_result.devices.count < 2) && ![_result.devices containsObject:uuid]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的手机第一次考勤需要绑定,确认绑定吗?" preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self) weakSelf = self;
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf kqAction:@"true" inOrOut:@"0"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if ((_result.devices.count <= 2) && [_result.devices containsObject:uuid]) {
        [self kqAction:@"false" inOrOut:@"0"];
    }
    if ((_result.devices.count == 2) && ![_result.devices containsObject:uuid]) {
        [MBProgressHUD showError:@"此手机未绑定,无法考勤"];
    }
    [checkAttendenceBtnCell setInBtnImg:@"kqBtnI" outBtnImg:@"kqBtnO" canClick:YES];
}

- (void)checkAttendenceBtnCellDelegateClickOutBtn:(WCCheckAttendenceBtnCell *)checkAttendenceBtnCell {
    [checkAttendenceBtnCell setInBtnImg:@"kqBtnNI" outBtnImg:@"kqBtnNO" canClick:NO];
    NSDictionary *uuid = @{@"device":self.uuid};
    if ((_result.devices.count < 2) && ![_result.devices containsObject:uuid]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的手机第一次考勤需要绑定,确认绑定吗?" preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self) weakSelf = self;
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf kqAction:@"true" inOrOut:@"1"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if ((_result.devices.count <= 2) && [_result.devices containsObject:uuid]) {
        [self kqAction:@"false" inOrOut:@"1"];
    }
    if ((_result.devices.count == 2) && ![_result.devices containsObject:uuid]) {
        [MBProgressHUD showError:@"此手机未绑定,无法考勤"];
    }
    [checkAttendenceBtnCell setInBtnImg:@"kqBtnI" outBtnImg:@"kqBtnO" canClick:YES];
}

#pragma mark - 考勤功能
- (void)kqAction:(NSString *)sign inOrOut:(NSString *)inOrOut {
    [MBProgressHUD showMessage:@"考勤中..." toView:self.view];
    WCDidCheckAttendenceParam *param = [WCDidCheckAttendenceParam param:KQ2];
    param.gh = _userName;
    param.did = self.uuid;
    param.kqlx = inOrOut;
    param.dz = _wzStr;
    param.sign = sign;
    [WCCheckAttendenceTool didCheckAttendenceWithParam:param success:^(WCDidCheckAttendenceResult *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result.errorMsg) {
            [MBProgressHUD showError:[NSString stringWithFormat:@"errorcode:%@",result.errorMsg] toView:self.view];
            self.result.devices = result.devices;
        } else {
            self.result.devices = result.devices;
            self.result.checkInLog = result.checkInLog;
            self.count = [result.checkInTimes intValue];
            NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
            NSIndexPath *fourthPath = [NSIndexPath indexPathForRow:3 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[firstPath,fourthPath] withRowAnimation:UITableViewRowAnimationFade];
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"考勤时间:%@",result.signTime] toView:self.view];
            if ([inOrOut isEqualToString:@"0"]) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:result.signTime forKey:@"signInTime"];
                [userDefaults synchronize];
            }
            if ([inOrOut isEqualToString:@"1"]) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:result.signTime forKey:@"signOutTime"];
                [userDefaults synchronize];
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络异常,稍后再试"];
    }];
}


#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44.0f;
    }else if (indexPath.row == 1) {
        return 60.0f;
    }else if (indexPath.row == 2) {
        return 230.0f;
    }else if (indexPath.row == 3) {
        return 60.0f;
    }else{
        return self.view.frame.size.height - 394.0f - WCTopNavH;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  AppDelegate.m
//  WCWork
//
//  Created by information on 2017/9/28.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAppDelegate.h"
#import "WCTabBarViewController.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import <UserNotifications/UserNotifications.h>
#import "WCNavigationController.h"
#import "WCPushNoticeViewController.h"
#import "ATAppUpdater.h"

static NSString *const aliyunPushAppKey = @"24714654";
static NSString *const aliyunPushAppSecret = @"e23a21f3e2474dc45626dd6932482ae4";

@interface WCAppDelegate () <UITabBarControllerDelegate,UNUserNotificationCenterDelegate>
{
    UNUserNotificationCenter *_notificationCenter;
}
@property (nonatomic, strong)  WCTabBarViewController *tabBarVc;

@end

@implementation WCAppDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    WCLoginViewController *loginVc = [WCLoginViewController instance];
    if ([viewController.tabBarItem.title isEqualToString:@"通讯录"]) {
        if (loginVc.logining) {
            return YES;
        }else{
            [((UINavigationController *)tabBarController.selectedViewController) pushViewController:loginVc animated:YES];
            return NO;
        }
    } else {
        return YES;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 app启动完毕就会调用
 
 @param application 当前应用
 @param launchOptions launchOptions
 @return 是否进入应用
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];
    // aliyun push
    // 向苹果APNs注册获取deviceToken并上报到阿里云推送服务器
    [self registerAPNs:application];
    
    // SDK初始化
    [self initCloudPush];
    
    // 监听推送通道打开动作
    [self listenerOnChannelOpened];
    
    // 监听推送消息到达
    [self registerMessageReceive];
    
    //点击通知将App从关闭状态启动时,将通知打开回执上报
    [CloudPushSDK sendNotificationAck:launchOptions];
    
    // 初始化用户的登录状态
    WCLoginAccount *loginAccount = [WCLoginTool loginAccount];
    if (loginAccount) {
        WCLoginViewController *loginVc = [WCLoginViewController instance];
        loginVc.loginAccount = loginAccount;
        loginVc.logining = YES;
        NSString *OAID = loginAccount.userName;
        [CloudPushSDK bindAccount:OAID withCallback:^(CloudPushCallbackResult *res) {
            if (res.success) {
                WCLog(@"帐号%@绑定成功...",OAID);
            }else{
                WCLog(@"帐号 绑定 error = %@",res.error);
            }
        }];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    WCTabBarViewController *tabBarVc = [[WCTabBarViewController alloc] init];
    tabBarVc.delegate = self;
    self.tabBarVc = tabBarVc;
    self.window.rootViewController = tabBarVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - SDK Init
- (void)initCloudPush {
    // 正式上线建议关闭
    [CloudPushSDK turnOnDebug];
    // SDK初始化
    [CloudPushSDK asyncInit:aliyunPushAppKey appSecret:aliyunPushAppSecret callback:^(CloudPushCallbackResult *res) {
        if(res.success){
            WCLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        }else{
            WCLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

#pragma mark - APNs Register
/**
 向APNs注册,获取deviceToken用于推送
 
 @param application 当前应用
 */
- (void)registerAPNs:(UIApplication *)application {
    float systemVersionNum = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(systemVersionNum >= 10.0){
        // IOS 10 notifications
        _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        // 创建 category,并注册到通知中心
        [self createCustomNotificationCategory];
        _notificationCenter.delegate = self;
        // 请求推送权限
        [_notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted){
                // granted
                WCLog(@"User authored notification.");
                // 向APNs注册,获取deviceToken
                dispatch_async(dispatch_get_main_queue(), ^{
                    [application registerForRemoteNotifications];
                });
            }else{
                // not granted
                WCLog(@"User denied notification.");
            }
        }];
    }else if (systemVersionNum >= 8.0){
        // iOS 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }else{
        // iOS < 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
#pragma clang diagnostic pop
    }
}

/**
 创建并注册通知category(iOS 10+)
 */
- (void)createCustomNotificationCategory {
    // 自定义`action1`和`action2`
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"test1" options: UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"test2" options: UNNotificationActionOptionNone];
    // 创建id为`test_category`的category，并注册两个action到category
    // UNNotificationCategoryOptionCustomDismissAction表明可以触发通知的dismiss回调
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"test_category" actions:@[action1, action2] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    // 注册category到通知中心
    [_notificationCenter setNotificationCategories:[NSSet setWithObjects:category, nil]];
}

/**
 APNs注册成功回调,将返回到deviceToken上传到CloudPush服务器
 
 @param application 当前应用
 @param deviceToken 成功后的deviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    WCLog(@"Upload deviceToken to CloudPush server.");
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            WCLog(@"Register deviceToken success = %@, deviceId : %@",[CloudPushSDK getApnsDeviceToken],[CloudPushSDK getDeviceId]);
        }else{
            WCLog(@"Register deviceToken failed, error: %@",res.error);
        }
    }];
}

/**
 APNs注册失败回调
 
 @param application 当前应用
 @param error 错误信息
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error {
    WCLog(@"didFailToRegisterForRemoteNotificationsWithError %@",error);
}

/**
 App处于前台时收到通知(iOS 10+)
 
 @param center 通知中心
 @param notification 通知
 @param completionHandler 回调
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    WCLog(@"Receive a notification in foregound.");
    //处理 iOS 10通知,并上报通知打开回执
    //[self handleiOS10Notification:notification];
    //通知不弹出来
    //    completionHandler(UNNotificationPresentationOptionNone);
    
    //通知弹出,且带有声音、内容和角标
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

/**
 处理iOS 10通知(iOS 10+)
 
 @param notification 通知
 */
- (void)handleiOS10Notification:(UNNotification *)notification {
    UNNotificationRequest *request = notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    // 通知时间
    NSDate *noticeDate = notification.date;
    // 标题
    NSString *title = content.title;
    // 副标题
    NSString *subtitle = content.subtitle;
    // 内容
    NSString *body = content.body;
    // 角标
    int badge = [content.badge intValue];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *urlPath = [userInfo valueForKey:@"url"];
    // 通知角标数清0
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 同步角标数到服务端
    // [self syncBadgeNum:0];
    // 通知打开回执上报
    [CloudPushSDK sendNotificationAck:userInfo];
    WCLog(@"Notification, date: %@, title: %@, subtitle: %@, body: %@, badge: %d, urlPath: %@.", noticeDate, title, subtitle, body, badge, urlPath);
    
    if (urlPath) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WCPushNoticeViewController *pushNotice = [[WCPushNoticeViewController alloc] initWithUrlPath:urlPath];
            WCNavigationController *pushNav = [[WCNavigationController alloc] initWithRootViewController:pushNotice];
            [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
        });
    }
}

/**
 触发通知动作时回调,比如点击、删除通知和点击自定义action(iOS 10+)
 
 @param center 通知中心
 @param response 反馈
 @param completionHandler 回调
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSString *userAction = response.actionIdentifier;
    // 点击通知打开
    if ([userAction isEqualToString:UNNotificationDefaultActionIdentifier]) {
        WCLog(@"User opened the notification.");
        // 处理iOS 10通知，并上报通知打开回执
        [self handleiOS10Notification:response.notification];
    }
    // 通知dismiss，category创建时传入UNNotificationCategoryOptionCustomDismissAction才可以触发
    if ([userAction isEqualToString:UNNotificationDismissActionIdentifier]) {
        WCLog(@"User dismissed the notification.");
    }
    NSString *customAction1 = @"action1";
    NSString *customAction2 = @"action2";
    // 点击用户自定义Action1
    if ([userAction isEqualToString:customAction1]) {
        WCLog(@"User custom action1.");
    }
    
    // 点击用户自定义Action2
    if ([userAction isEqualToString:customAction2]) {
        WCLog(@"User custom action2.");
    }
    completionHandler();
}

#pragma mark - Notification Open

/**
 App处于启动状态时，通知打开回调
 
 @param application 当前应用
 @param userInfo 信息
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    WCLog(@"Receive one notification.");
    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *urlPath = [userInfo valueForKey:@"url"]; //服务端中Extras字段，key是自己定义的
    WCLog(@"content = [%@], badge = [%ld], sound = [%@], urlPath = [%@]", content, (long)badge, sound, urlPath);
    if (urlPath) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WCPushNoticeViewController *pushNotice = [[WCPushNoticeViewController alloc] initWithUrlPath:urlPath];
            WCNavigationController *pushNav = [[WCNavigationController alloc] initWithRootViewController:pushNotice];
            [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
        });
    }
    // iOS badge 清0
    application.applicationIconBadgeNumber = 0;
    // 同步通知角标数到服务端
    // [self syncBadgeNum:0];
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    [CloudPushSDK sendNotificationAck:userInfo];
}

#pragma mark - Channel Opened
/**
 注册推送通道打开监听
 */
- (void)listenerOnChannelOpened {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChannelOpened:) name:@"CCPDidChannelConnectedSuccess" object:nil];
}

/**
 推送通道打开回调
 
 @param notification 通知
 */
- (void)onChannelOpened:(NSNotification *)notification{
    WCLog(@"推送通道打开回调...");
}

#pragma mark - Receive Message
/**
 注册推送消息到来监听
 */
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMessageReceived:) name:@"CCPDidReceiveMessageNotification" object:nil];
}

/**
 处理到来推送消息
 
 @param notification 通知本事
 */
- (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    NSString *content = [NSString stringWithFormat:@"Receive message title: %@, content: %@.", title, body];
    WCLog(@"Receive message title: %@,body: %@. content: %@.", title, body, content);
}

@end

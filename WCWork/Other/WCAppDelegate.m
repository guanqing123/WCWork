//
//  AppDelegate.m
//  WCWork
//
//  Created by information on 2017/9/28.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAppDelegate.h"
#import "WCTabBarViewController.h"

@interface WCAppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong)  WCTabBarViewController *tabBarVc;

@end

@implementation WCAppDelegate


/**
 app启动完毕就会调用
 
 @param application 当前应用
 @param launchOptions launchOptions
 @return 是否进入应用
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    WCLoginAccount *loginAccount = [WCLoginTool loginAccount];
    if (loginAccount) {
        WCLoginViewController *loginVc = [WCLoginViewController instance];
        loginVc.loginAccount = loginAccount;
        loginVc.logining = YES;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    WCTabBarViewController *tabBarVc = [[WCTabBarViewController alloc] init];
    tabBarVc.delegate = self;
    self.tabBarVc = tabBarVc;
    self.window.rootViewController = tabBarVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

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


@end

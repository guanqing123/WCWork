//
//  WCTabBarViewController.m
//  WCWork
//
//  Created by information on 2017/9/28.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCTabBarViewController.h"
#import "WCNavigationController.h"
#import "WCHomeViewController.h"
#import "WCAddressBookViewController.h"
#import "WCAddressBookFromOAViewController.h"
#import "WCFunctionViewController.h"
#import "WCMeViewController.h"

@interface WCTabBarViewController ()

@property (nonatomic, strong)  WCHomeViewController *home;
//@property (nonatomic, strong)  WCAddressBookViewController *addressBook;
@property (nonatomic, strong)  WCAddressBookFromOAViewController *addressBook;
@property (nonatomic, strong)  WCFunctionViewController *function;
@property (nonatomic, strong)  WCMeViewController *me;

@end

@implementation WCTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}


/**
 初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    WCHomeViewController *home = [[WCHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tab1" selectedImageName:@"tab1-1"];
    self.home = home;
    
    // 2.通讯录
    /*
    WCAddressBookViewController *addressBook = [[WCAddressBookViewController alloc] init];
    [self setupChildViewController:addressBook title:@"通讯录"imageName:@"tab2" selectedImageName:@"tab2-2"];
    self.addressBook = addressBook;
     */
    WCAddressBookFromOAViewController *addressBook = [[WCAddressBookFromOAViewController alloc] init];
    [self setupChildViewController:addressBook title:@"通讯录" imageName:@"tab2" selectedImageName:@"tab2-2"];
    self.addressBook = addressBook;
    
    // 3.功能
    WCFunctionViewController *function = [[WCFunctionViewController alloc] init];
    function.view.backgroundColor = [UIColor whiteColor];
    [self setupChildViewController:function title:@"功能" imageName:@"tab3" selectedImageName:@"tab3-3"];
    self.function = function;
    
    // 4.我的
    WCMeViewController  *me = [[WCMeViewController alloc] init];
    [self setupChildViewController:me title:@"我的" imageName:@"tab4" selectedImageName:@"tab4-4"];
    self.me = me;
}


/**
 初始化一个子控制器

 @param childVc           需要初始化的子控制器
 @param title             标题
 @param imageName         图标
 @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    if (![title isEqualToString:@"通讯录"]) {
        childVc.view.backgroundColor = [UIColor whiteColor];
    }
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置字体样式
    /*NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = tabBarTitleColorNomal;
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];*/
    // 设置选中的字体样式
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = tabBarTitleColorSelected;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 2.包装一个导航控制器
    WCNavigationController *nav = [[WCNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

#pragma mark -屏幕旋转设置
- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

@end

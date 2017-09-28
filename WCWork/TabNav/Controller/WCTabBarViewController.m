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

@interface WCTabBarViewController ()

@property (nonatomic, strong)  WCHomeViewController *home;

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
    //1.首页
    WCHomeViewController *home = [[WCHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tab1" selectedImageName:@"tab1-1"];
    self.home = home;
    
    WCHomeViewController *home2 = [[WCHomeViewController alloc] init];
    [self setupChildViewController:home2 title:@"首页" imageName:@"tab1" selectedImageName:@"tab1-1"];
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
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置字体样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = tabBarTitleColorNomal;
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 设置选中的字体样式
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = tabBarTitleColorSelected;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 2.包装一个导航控制器
    WCNavigationController *nav = [[WCNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end

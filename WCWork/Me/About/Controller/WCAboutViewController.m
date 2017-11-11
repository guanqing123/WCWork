//
//  WCAboutViewController.m
//  WCWork
//
//  Created by information on 2017/10/25.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAboutViewController.h"
#import "WCAboutHeaderView.h"
#import "WCAboutFooterView.h"

@interface WCAboutViewController ()

@end

@implementation WCAboutViewController

- (instancetype)init {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"WCAboutViewController" bundle:[NSBundle mainBundle]];
    return [storyBoard instantiateViewControllerWithIdentifier:@"wcAboutVc"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = [WCAboutHeaderView headerView];
    self.tableView.tableFooterView = [WCAboutFooterView footerView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

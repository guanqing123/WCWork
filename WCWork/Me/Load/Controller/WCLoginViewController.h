//
//  WCLoginViewController.h
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLoginTool.h"
@class WCLoginViewController;

@protocol WCLoginViewControllerDelegate <NSObject>
@optional

/**
 完成登录后回调

 @param loginVc 当前登录控制器
 */
- (void)loginViewControllerDidFinishLogin:(WCLoginViewController *)loginVc;

@end

@interface WCLoginViewController : UIViewController

@property (nonatomic, assign, getter=isLogined) BOOL logining;

@property (nonatomic, strong)  WCLoginAccount *loginAccount;

@property (nonatomic, weak) id<WCLoginViewControllerDelegate>  delegate;

+ (instancetype)instance;

@end

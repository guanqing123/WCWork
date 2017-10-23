//
//  WCNewArrivalDetailViewController.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WCNewArrivalDetailViewController : UIViewController

@property (nonatomic,copy) NSString *newsTitle;

@property (nonatomic,copy) NSString *newsTime;

@property (nonatomic,copy) NSString  *content;

@property (strong, nonatomic)  MBProgressHUD *progressHUD;

- (instancetype)initWithTitle:(NSString *)newsTitle time:(NSString *)newsTime content:(NSString *)newsContent;

@end

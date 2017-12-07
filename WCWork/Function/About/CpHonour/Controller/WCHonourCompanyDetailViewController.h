//
//  WCHonourCompanyDetailViewController.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WCHonourCompanyDetailViewController : UIViewController

@property (nonatomic,copy) NSString *newsTitle;

@property (nonatomic,copy) NSString *newsTime;

@property (nonatomic,copy) NSString  *content;

- (instancetype)initWithTitle:(NSString *)newsTitle time:(NSString *)newsTime content:(NSString *)newsContent;

@end

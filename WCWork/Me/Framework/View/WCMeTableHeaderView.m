//
//  WCMeTableHeaderView.m
//  WCWork
//
//  Created by information on 2017/10/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCMeTableHeaderView.h"

@interface WCMeTableHeaderView()
@property (nonatomic, weak) UILabel  *loginLabel;
@end

@implementation WCMeTableHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 0, 120.0f);
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, ScreenW, 120.0f);
        imageView.image = [UIImage imageNamed:@"bg"];
        [self addSubview:imageView];
        
        UILabel *loginLabel = [[UILabel alloc] init];
        loginLabel.frame = CGRectMake(0, 0, ScreenW, 120.0f);
        loginLabel.textAlignment = NSTextAlignmentCenter;
        loginLabel.textColor = [UIColor whiteColor];
        loginLabel.font = [UIFont systemFontOfSize:20.0f weight:2.0f];
        _loginLabel = loginLabel;
        [self addSubview:loginLabel];
    }
    return self;
}

+ (instancetype)headerView {
    return [[self alloc] init];
}

- (void)unactive {
    self.loginLabel.text = @"未登录";
}

- (void)active:(NSString *)loginMsg {
    self.loginLabel.text = loginMsg;
}

@end

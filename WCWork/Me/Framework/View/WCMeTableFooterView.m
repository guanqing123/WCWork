//
//  WCMeTableFooterView.m
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCMeTableFooterView.h"

@interface WCMeTableFooterView()
@property (nonatomic, weak) UIButton  *loginOrResignBtn;
@end

@implementation WCMeTableFooterView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 0, 100.0f);
        
        UIButton *loginOrResignBtn = [[UIButton alloc] init];
        loginOrResignBtn.frame = CGRectMake(20.0f, 50.0f, ScreenW - 40.0f, 40.0f);
        [loginOrResignBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginOrResignBtn addTarget:self action:@selector(loginOrResign) forControlEvents:UIControlEventTouchUpInside];
        loginOrResignBtn.layer.cornerRadius = 5.0f;
        loginOrResignBtn.layer.masksToBounds = YES;
        _loginOrResignBtn = loginOrResignBtn;
        [self addSubview:loginOrResignBtn];
    }
    return self;
}

+ (instancetype)footerView {
    return [[self alloc] init];
}

- (void)loginOrResign {
    if ([self.delegate respondsToSelector:@selector(meTableFooterViewDidLoginOrResignBtn:)]) {
        [self.delegate meTableFooterViewDidLoginOrResignBtn:self];
    }
}

- (void)active {
    [self.loginOrResignBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    self.loginOrResignBtn.backgroundColor = [UIColor redColor];
}

- (void)unactive {
    [self.loginOrResignBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginOrResignBtn.backgroundColor = WCThemeColor;
}

@end

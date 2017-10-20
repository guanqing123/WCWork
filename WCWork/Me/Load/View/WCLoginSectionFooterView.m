//
//  WCLoginSectionFooterView.m
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCLoginSectionFooterView.h"

@interface WCLoginSectionFooterView()
@property (nonatomic, weak) UIView  *lineView;
@property (nonatomic, weak) UIButton  *loginBtn;
@end

@implementation WCLoginSectionFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"loginSectionFooterView";
    WCLoginSectionFooterView *sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (sectionFooterView == nil) {
        sectionFooterView = [[WCLoginSectionFooterView alloc] initWithReuseIdentifier:ID];
    }
    return sectionFooterView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGB(238.0f, 238.0f, 238.0f);
        _lineView = lineView;
        [self.contentView addSubview:lineView];
        
        UIButton *loginBtn = [[UIButton alloc] init];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginBtn.backgroundColor = WCThemeColor;
        [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.layer.cornerRadius = 5.0f;
        loginBtn.layer.masksToBounds = YES;
        _loginBtn = loginBtn;
        [self.contentView addSubview:loginBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat parentW = self.frame.size.width;
    self.lineView.frame = CGRectMake(0, 0, parentW, 1);
    
    CGFloat loginBtnX = 20;
    CGFloat loginBtnY = 40;
    CGFloat loginBtnW = parentW - 2 * loginBtnX;
    CGFloat loginBtnH = 40;
    self.loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH);
}

- (void)loginBtnClick {
    if ([self.delegate respondsToSelector:@selector(loginSectionFooterViewDidClickLoginBtn:)]) {
        [self.delegate loginSectionFooterViewDidClickLoginBtn:self];
    }
}

@end

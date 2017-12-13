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
@property (nonatomic, weak) UILabel  *commentLabel;
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
        
        UILabel *commentLabel = [[UILabel alloc] init];
        commentLabel.text = @"注:请用OA账号登录,如有问题请致电0571-88001234.";
        commentLabel.numberOfLines = 0;
        commentLabel.font = [UIFont systemFontOfSize:15.0f];
        commentLabel.textColor = [UIColor orangeColor];
        _commentLabel = commentLabel;
        [self.contentView addSubview:commentLabel];
        
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
    
    CGFloat commentLabelX = 20;
    CGFloat commentLabelY = 10;
    CGFloat commentLabelW = ScreenW - 2 * commentLabelX;
    CGFloat commentLabelH = 36;
    self.commentLabel.frame = CGRectMake(commentLabelX, commentLabelY, commentLabelW, commentLabelH);
    
    CGFloat loginBtnX = 20;
    CGFloat loginBtnY = 60;
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

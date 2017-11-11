//
//  WCAddressBookCell.m
//  WCWork
//
//  Created by information on 2017/10/18.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookCell.h"

#define WCAddressBookCellHeight 67.0f

@interface WCAddressBookCell()
@property (nonatomic, weak) UILabel  *trueNameLabel;
@property (nonatomic, weak) UILabel  *userNameLabel;
@property (nonatomic, weak) UILabel  *mobileLabel;
@property (nonatomic, weak) UIButton  *callBtn;
@property (nonatomic, weak) UIView  *lineView;
@property (nonatomic, strong)  UIWebView *webView;
@end

@implementation WCAddressBookCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"addressBookCell";
    WCAddressBookCell *addressBookCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (addressBookCell == nil) {
        addressBookCell = [[WCAddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return addressBookCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 1.trueNameLabel
        UILabel *trueNameLabel = [[UILabel alloc] init];
        trueNameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _trueNameLabel = trueNameLabel;
        [self.contentView addSubview:trueNameLabel];
        
        // 2.userNameLabel
        UILabel *userNameLabel = [[UILabel alloc] init];
        userNameLabel.font = [UIFont systemFontOfSize:14];
        userNameLabel.textColor = RGB(150.0f, 150.0f, 150.0f);
        _userNameLabel = userNameLabel;
        [self.contentView addSubview:userNameLabel];
        
        // 3.mobileLabel
        UILabel *mobileLabel = [[UILabel alloc] init];
        mobileLabel.font = [UIFont systemFontOfSize:14];
        mobileLabel.textColor = RGB(150.0f, 150.0f, 150.0f);
        _mobileLabel = mobileLabel;
        [self.contentView addSubview:mobileLabel];
        
        // 4.callBtn
        UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [callBtn setImage:[UIImage imageNamed:@"mobile"] forState:UIControlStateNormal];
        [callBtn addTarget:self action:@selector(telephone) forControlEvents:UIControlEventTouchUpInside];
        _callBtn = callBtn;
        [self.contentView addSubview:callBtn];
        
        // 5.lineView
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGB(238.0f, 238.0f, 238.0f);
        _lineView = lineView;
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (void)telephone {
    if (!_mobile || ![_mobile length]) return;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_mobile]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat paddingX = 10;
    CGFloat paddingY = 0;
    
    CGFloat trueNameLabelW = (ScreenW - 60.0f) / 2;
    CGFloat trueNameLabelH = 36;
    _trueNameLabel.frame = CGRectMake(paddingX, paddingY, trueNameLabelW, trueNameLabelH);
    
    CGFloat mobileLabelX = CGRectGetMaxX(_trueNameLabel.frame);
    CGFloat mobileLabelW = ScreenW / 2;
    CGFloat mobileLabelH = 36;
    _mobileLabel.frame = CGRectMake(mobileLabelX, paddingY, mobileLabelW, mobileLabelH);
    
    CGFloat userNameLabelY = CGRectGetMaxY(_trueNameLabel.frame);
    CGFloat userNameLabelW = trueNameLabelW;
    CGFloat userNameLabelH = 30;
    _userNameLabel.frame = CGRectMake(paddingX, userNameLabelY, userNameLabelW, userNameLabelH);
    
    _callBtn.frame = CGRectMake(ScreenW - 60.0f, 18.0f, 30.0f, 30.0f);
    
    _lineView.frame = CGRectMake(0, 66.0f, ScreenW, 1.0f);
}

- (void)setTrueName:(NSString *)trueName {
    _trueName = trueName;
    self.trueNameLabel.text = trueName;
}

- (void)setUserName:(NSString *)userName {
    _userName = userName;
    self.userNameLabel.text = userName;
}

- (void)setMobile:(NSString *)mobile {
    _mobile = mobile;
    self.mobileLabel.text = mobile;
    //self.mobileLabel.text = @"xxxxxxxxxxx";
}

+ (CGFloat)height {
    return WCAddressBookCellHeight;
}

@end

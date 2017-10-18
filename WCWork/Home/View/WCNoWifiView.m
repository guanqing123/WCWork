//
//  WCNoWifiView.m
//  WCWork
//
//  Created by information on 2017/10/17.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCNoWifiView.h"

@interface WCNoWifiView()
@property (nonatomic, strong)  UIImageView  *indicatorView;
@property (nonatomic, strong)  UIButton  *refreshBtn;
@end

@implementation WCNoWifiView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenW, 180.0f);
        self.alpha = 0;
        // 1.indicatorView
        [self addSubview:self.indicatorView];
        // 2.titleLabel
        [self addSubview:self.refreshBtn];
    }
    return self;
}

- (UIImageView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIImageView alloc] init];
        _indicatorView.bounds = (CGRect){CGPointZero,CGSizeMake(160.0f, 140.0f)};
        _indicatorView.center = CGPointMake(ScreenW / 2, 70.0f);
        _indicatorView.image = [UIImage imageNamed:@"placeholder_no_network"];
    }
    return _indicatorView;
}

- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [[UIButton alloc] init];
        _refreshBtn.frame = CGRectMake(0, 150.0f, ScreenW, 20.0f);
        [_refreshBtn setAttributedTitle:self.attrTitle forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}


- (NSAttributedString *)attrTitle {
    NSString *text = @"网络不给力,请点击重试哦~";
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, text.length)];
    // 设置指定4个字体为蓝色
    [attrStr addAttribute:NSForegroundColorAttributeName value:RGB(0, 126, 229) range:NSMakeRange(7, 4)];
    
    return attrStr;
}

- (void)show {
    [UIView animateWithDuration:2.0 animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    self.alpha = 0;
}

- (void)refreshBtnClick {
    if ([self.delegate respondsToSelector:@selector(noWifiViewDidRefreshBtn:)]) {
        [self.delegate noWifiViewDidRefreshBtn:self];
    }
}

@end

//
//  WCSectionHeaderView.m
//  WCWork
//
//  Created by information on 2017/11/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCSectionHeaderView.h"
#import "DotActivityIndicatorView.h"
#import "CustomSegmentControl.h"

@interface WCSectionHeaderView()
@property (nonatomic, strong)  DotActivityIndicatorView *indicatorView;
@property (nonatomic, strong)  CustomSegmentControl *segmentBar;
@property (nonatomic, strong)  UIView *refreshView;
@property (nonatomic, weak) UILabel  *titleLabel;
@end

@implementation WCSectionHeaderView

+ (instancetype)headerView {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenW, 44.0f);
        // 0.topLineView
        UIView *topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = RGB(238, 238, 238);
        topLineView.frame = CGRectMake(0, 0, ScreenW, 1);
        [self addSubview:topLineView];
        // 1.添加指示器
        [self addSubview:self.indicatorView];
        // 2.添加segment
        [self addSubview:self.segmentBar];
        // 3.添加刷新按钮
        [self addSubview:self.refreshView];
        // 4.bottomLineView
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = RGB(238, 238, 238);
        bottomLineView.frame = CGRectMake(0, 43.0f, ScreenW, 1);
        [self addSubview:bottomLineView];
    }
    return self;
}

- (DotActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[DotActivityIndicatorView alloc] init];
        _indicatorView.alpha = 0;
        _indicatorView.bounds = (CGRect){CGPointZero, CGSizeMake(50, 10)};
        _indicatorView.center = CGPointMake(ScreenW / 2, 22);
        _indicatorView.dotParms = [self loadDotActivityIndicatorParms];
    }
    return _indicatorView;
}

- (DotActivityIndicatorParms *)loadDotActivityIndicatorParms{
    DotActivityIndicatorParms *dotParms = [DotActivityIndicatorParms new];
    dotParms.activityViewWidth = self.indicatorView.frame.size.width;
    dotParms.activityViewHeight = self.indicatorView.frame.size.height;
    dotParms.numberOfCircles = 5;
    dotParms.internalSpacing = 0.01;
    dotParms.animationDelay = 0.2;
    dotParms.animationDuration = 0.6;
    dotParms.animationFromValue = 0.3;
    dotParms.defaultColor = [UIColor lightGrayColor];
    dotParms.isDataValidationEnabled = YES;
    return dotParms;
}

- (CustomSegmentControl *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[CustomSegmentControl alloc] init];
        _segmentBar.alpha = 0;
        _segmentBar.frame = CGRectMake(0, 0, ScreenW, 44);
        _segmentBar.font = [UIFont systemFontOfSize:15];
        _segmentBar.textColor = RGB(100, 100, 100);
        _segmentBar.selectedTextColor = RGB(0, 0, 0);
        _segmentBar.backgroundColor = RGB(238, 238, 238);
        _segmentBar.selectionIndicatorColor = RGB(168, 168, 168);
        [_segmentBar addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentBar;
}

- (UIView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[UIView alloc] init];
        _refreshView.alpha = 0;
        _refreshView.frame = CGRectMake(0, 0, ScreenW, 44);
        
        UILabel *titleLabel = [[UILabel alloc] init];
//      titleLabel.text = @"世界上最遥远的距离就是断网";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.bounds = (CGRect){CGPointZero, CGSizeMake(ScreenW, 16)};
        titleLabel.center = CGPointMake(ScreenW / 2, 11);
        _titleLabel = titleLabel;
        [_refreshView addSubview:titleLabel];
        
        UIButton *refreshBtn = [[UIButton alloc] init];
        refreshBtn.bounds = (CGRect){CGPointZero, CGSizeMake(60, 20)};
        refreshBtn.center = CGPointMake(ScreenW / 2, 33);
        [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        refreshBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        refreshBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        refreshBtn.backgroundColor = [UIColor lightGrayColor];
        refreshBtn.layer.cornerRadius = 10;
        [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_refreshView addSubview:refreshBtn];
    }
    return _refreshView;
}

- (void)loading {
    self.segmentBar.alpha = 0;
    self.refreshView.alpha = 0;
    [UIView animateWithDuration:2.0 animations:^{
        self.indicatorView.alpha = 1;
        [self.indicatorView startAnimating];
    }];
}

- (void)show:(NSArray *)items {
    [self.indicatorView stopAnimating];
    self.indicatorView.alpha = 0;
    self.refreshView.alpha = 0;
    self.segmentBar.items = items;
    self.segmentBar.alpha = 1;
}

- (void)failure:(NSString *)error {
    [self.indicatorView stopAnimating];
    self.indicatorView.alpha = 0;
    self.segmentBar.alpha = 0;
    [UIView animateWithDuration:2.0 animations:^{
        self.titleLabel.text = error;
        self.refreshView.alpha = 1;
    }];
}

- (void)refreshBtnClick {
    if ([self.delegate respondsToSelector:@selector(sectionHeaderViewDidClickRefreshBtn:)]) {
        [self.delegate sectionHeaderViewDidClickRefreshBtn:self];
    }
}

- (void)changeSwipeViewIndex:(CustomSegmentControl *)segmentBar {
    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:selectedSegmentIndex:)]) {
        [self.delegate sectionHeaderView:self selectedSegmentIndex:segmentBar.selectedSegmentIndex];
    }
}

@end

//
//  WCSlideshowHeadView.m
//  WCWork
//
//  Created by information on 2017/10/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCSlideshowHeadView.h"
#import "WCSliderResult.h"
#import "DotActivityIndicatorView.h"
#import <SDCycleScrollView.h>

@interface WCSlideshowHeadView()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)  DotActivityIndicatorView *indicatorView;
@property (nonatomic, strong)  SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)  UIView *refreshView;
@property (nonatomic, strong)  NSArray *scrollViewArray;
@end

@implementation WCSlideshowHeadView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenW, ScreenW /  3);
        UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_back"]];
        [self setBackgroundColor:bgColor];
        // 1.添加指示器
        [self addSubview:self.indicatorView];
        // 2.添加滚动页
        [self addSubview:self.cycleScrollView];
        // 3.添加刷新按钮
        [self addSubview:self.refreshView];
    }
    return self;
}

- (UIView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[UIView alloc] init];
        _refreshView.alpha = 0;
        _refreshView.frame = CGRectMake(0, 0, ScreenW, ScreenW / 3);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"世界上最遥远的距离就是断网";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.bounds = (CGRect){CGPointZero, CGSizeMake(ScreenW, 16)};
        titleLabel.center = CGPointMake(ScreenW / 2, ScreenW / 6 - 10);
        [_refreshView addSubview:titleLabel];
        
        UIButton *refreshBtn = [[UIButton alloc] init];
        refreshBtn.bounds = (CGRect){CGPointZero, CGSizeMake(60, 20)};
        refreshBtn.center = CGPointMake(ScreenW / 2, ScreenW / 6 + 12);
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

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, ScreenW / 3) delegate:self placeholderImage:[UIImage imageNamed:@"home_img_loading"]];
        _cycleScrollView.alpha = 0;
        _cycleScrollView.delegate = self;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _cycleScrollView.autoScrollTimeInterval = 3.0;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}

- (DotActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[DotActivityIndicatorView alloc] init];
        _indicatorView.alpha = 0;
        _indicatorView.bounds = (CGRect){CGPointZero, CGSizeMake(50, 10)};
        _indicatorView.center = CGPointMake(ScreenW / 2, ScreenW /  6);
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

+ (instancetype)headerView {
    return [[self alloc] init];
}

- (void)loading {
    self.cycleScrollView.alpha = 0;
    self.refreshView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        self.indicatorView.alpha = 1;
        [self.indicatorView startAnimating];
    }];
}

- (void)show:(NSArray *)resultArray {
    _scrollViewArray = resultArray;
    [self.indicatorView stopAnimating];
    self.indicatorView.alpha = 0;
    self.refreshView.alpha = 0;
    self.cycleScrollView.imageURLStringsGroup = resultArray;
    [UIView animateWithDuration:1.0 animations:^{
        self.cycleScrollView.alpha = 1;
    }];
}

- (void)failure {
    [self.indicatorView stopAnimating];
    self.indicatorView.alpha = 0;
    self.cycleScrollView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        self.refreshView.alpha = 1;
    }];
}

- (void)refreshBtnClick {
    if ([self.delegate respondsToSelector:@selector(slideShowHeaderViewDidClickRefreshBtn:)]) {
        [self.delegate slideShowHeaderViewDidClickRefreshBtn:self];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(slideShowHeaderView:selectedIndex:)]) {
        [self.delegate slideShowHeaderView:self selectedIndex:index];
    }
}

@end

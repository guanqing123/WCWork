//
//  WCActivityIndicatorView.m
//  WCWork
//
//  Created by information on 2017/10/18.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCActivityIndicatorView.h"
#import "DotActivityIndicatorView.h"

@interface WCActivityIndicatorView()
@property (nonatomic, strong)  DotActivityIndicatorView *indicatorView;
@end

@implementation WCActivityIndicatorView

+ (instancetype)indicatorView {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenW, ScreenW /  3);
        self.alpha = 0;
        [self addSubview:self.indicatorView];
    }
    return self;
}

- (DotActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[DotActivityIndicatorView alloc] init];
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

- (void)show {
    [UIView animateWithDuration:1.0f animations:^{
        self.alpha = 1;
        [self.indicatorView startAnimating];
    }];
}

- (void)hide {
    self.alpha = 0;
    [self.indicatorView stopAnimating];
}

@end

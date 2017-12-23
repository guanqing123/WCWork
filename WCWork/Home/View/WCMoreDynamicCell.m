//
//  WCMoreDynamicCell.m
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCMoreDynamicCell.h"
#import "DotActivityIndicatorView.h"

@interface WCMoreDynamicCell()
@property (nonatomic, strong)  DotActivityIndicatorView *indicatorView;
@property (nonatomic, strong)  UIView *moreDynamic;
@property (nonatomic, strong)  UIView *refreshView;
@property (nonatomic, strong)  UIView *bottomLineView;
@end

@implementation WCMoreDynamicCell

static WCMoreDynamicCell *moreDynamicCell = nil;

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"moreDynamicCell";
    WCMoreDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WCMoreDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1.添加指示器
        [self.contentView addSubview:self.indicatorView];
        // 2.添加滚动页
        [self.contentView addSubview:self.moreDynamic];
        // 3.添加刷新按钮
        [self.contentView addSubview:self.refreshView];
        // 4.添加下划线
        [self.contentView addSubview:self.bottomLineView];
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

- (UIView *)moreDynamic {
    if (!_moreDynamic) {
        _moreDynamic = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        _moreDynamic.alpha = 0;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW / 2 - 60.0f, 10.0f, 100.0f, 20.0f)];
        titleLabel.text = @"查看更多动态";
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_moreDynamic addSubview:titleLabel];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 12.5f, 15.0f, 15.0f)];
        imgView.image = [UIImage imageNamed:@"more_32"];
        [_moreDynamic addSubview:imgView];
    }
    return _moreDynamic;
}

- (UIView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[UIView alloc] init];
        _refreshView.alpha = 0;
        _refreshView.frame = CGRectMake(0, 0, ScreenW, 44);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"世界上最遥远的距离就是断网";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.bounds = (CGRect){CGPointZero, CGSizeMake(ScreenW, 16)};
        titleLabel.center = CGPointMake(ScreenW / 2, 11);
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

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.frame = CGRectMake(0, 43, ScreenH, 1);
        _bottomLineView.backgroundColor = cellLineColor;
    }
    return _bottomLineView;
}

- (void)loading {
    self.moreDynamic.alpha = 0;
    self.refreshView.alpha = 0;
    [UIView animateWithDuration:2.0 animations:^{
        self.indicatorView.alpha = 1;
        [self.indicatorView startAnimating];
    }];
}

- (void)show {
    [self.indicatorView stopAnimating];
    self.indicatorView.alpha = 0;
    self.refreshView.alpha = 0;
    [UIView animateWithDuration:2.0 animations:^{
        self.moreDynamic.alpha = 1;
    }];
}

- (void)failure {
    [self.indicatorView stopAnimating];
    self.indicatorView.alpha = 0;
    self.moreDynamic.alpha = 0;
    [UIView animateWithDuration:2.0 animations:^{
        self.refreshView.alpha = 1;
    }];
}

- (void)refreshBtnClick {
    if ([self.delegate respondsToSelector:@selector(moreDynamicCellDidRefreshBtn:)]) {
        [self.delegate moreDynamicCellDidRefreshBtn:self];
    }
}

@end

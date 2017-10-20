//
//  ReusableView.m
//  HYWork
//
//  Created by information on 16/3/21.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import "WCFunctionReusableView.h"

@interface WCFunctionReusableView()
@property (nonatomic, weak) UIView  *leftColorView;
@property (nonatomic, weak) UILabel  *titleLabel;
@property (nonatomic, weak) UIView  *lineView;
@end

@implementation WCFunctionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGB(238.0f, 238.0f, 238.0f);
        _lineView = lineView;
        [self addSubview:lineView];
        
        UIView *leftColorView = [[UIView alloc] init];
        _leftColorView = leftColorView;
        [self addSubview:leftColorView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel = titleLabel;
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat parentW = self.frame.size.width;
    self.lineView.frame = CGRectMake(0, 0, parentW, 1);
    self.leftColorView.frame = CGRectMake(0, 0, 5, 30);
    self.titleLabel.frame = CGRectMake(15, 5, 100, 20);
}

- (void)setGroup:(WCGroup *)group {
    _group = group;
    
    self.titleLabel.text = group.header;
    self.leftColorView.backgroundColor = RGB(group.r, group.g, group.b);
}

@end

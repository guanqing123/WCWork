//
//  WCCustomButton.m
//  WCWork
//
//  Created by information on 2017/12/9.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCCustomButton.h"
#import "Masonry.h"

@implementation WCCustomButton

+ (instancetype)customButton {
    return [[self alloc] init];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // 高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /** 设置titleLabel */
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.6);
    }];
    
    /** 设置image */
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.4);
    }];
}


@end

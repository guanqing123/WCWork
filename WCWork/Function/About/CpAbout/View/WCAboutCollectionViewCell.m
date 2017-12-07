//
//  WCAboutCollectionViewCell.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAboutCollectionViewCell.h"
#import "WCAboutItem.h"
#import <Masonry.h>

@interface WCAboutCollectionViewCell()
/** imageView */
@property (nonatomic, weak) UIImageView  *imageView;
/** titleLabel */
@property (nonatomic, weak) UILabel  *titleLabel;
@end

@implementation WCAboutCollectionViewCell

#pragma mark - initial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self.imageView.mas_bottom) setOffset:10];
    }];
}

- (void)setAboutItem:(WCAboutItem *)aboutItem {
    _aboutItem = aboutItem;
    self.imageView.image = [UIImage imageNamed:aboutItem.image];
    self.titleLabel.text = aboutItem.title;
}

@end

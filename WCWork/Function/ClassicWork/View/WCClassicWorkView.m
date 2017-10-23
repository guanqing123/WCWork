//
//  WCClassicWorkView.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCClassicWorkView.h"
#import "UIImageView+WebCache.h"

@interface WCClassicWorkView()

@property (nonatomic, weak) UIImageView  *imageView;

@property (nonatomic, weak) UILabel  *titleLabel;

@end

@implementation WCClassicWorkView

- (instancetype)init {
    if (self = [super init]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel = titleLabel;
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(1.0f, 0.0f, self.frame.size.width - 2.0f, self.frame.size.width / 3 * 2);
    
    self.titleLabel.frame = CGRectMake(1.0f, _imageView.frame.size.height, self.frame.size.width - 2.0f, 30.0f);
}

- (void)setClassicWork:(WCClassicWork *)classicWork {
    _classicWork = classicWork;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:classicWork.image] placeholderImage:[UIImage imageNamed:@"home_img_loading"]];
    
    self.titleLabel.text = classicWork.title;
}

@end

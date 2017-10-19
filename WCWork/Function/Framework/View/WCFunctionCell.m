//
//  WCFunctionCell.m
//  WCWork
//
//  Created by information on 2017/10/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCFunctionCell.h"

@interface WCFunctionCell()
@property (nonatomic, weak) UIImageView  *imageView;
@property (nonatomic, weak) UILabel  *titleLabel;
@end

@implementation WCFunctionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        // 1.图片
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
        
        // 2.标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:12.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat parentW = self.frame.size.width;
    CGFloat padding = 10;
    
    CGFloat imageViewX = padding;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = parentW - 2 * imageViewX;
    CGFloat imageViewH = imageViewW;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = CGRectGetMaxY(self.imageView.frame) + 5;
    CGFloat titleLabelW = parentW;
    CGFloat titleLabelH = 15;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
}

- (void)setItem:(WCItem *)item {
    _item = item;
    
    self.imageView.image = [UIImage imageNamed:item.image];
    
    self.titleLabel.text = item.title;
}

@end

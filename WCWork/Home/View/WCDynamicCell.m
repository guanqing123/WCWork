//
//  WCDynamicCell.m
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCDynamicCell.h"
#import "NSString+GQExtension.h"
#import "UIImageView+WebCache.h"

#define titleFont [UIFont systemFontOfSize:15]
#define summaryFont [UIFont systemFontOfSize:14]
#define timeFont  [UIFont systemFontOfSize:12]

@interface WCDynamicCell()
@property (nonatomic, weak) UILabel  *titleLabel;
@property (nonatomic, weak) UILabel  *timeLabel;
@property (nonatomic, weak) UIImageView  *imgView;
@property (nonatomic, weak) UILabel  *summaryLabel;
@property (nonatomic, weak) UIView   *bottomLineView;
@end

@implementation WCDynamicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"dynamicCell";
    WCDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WCDynamicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1.time
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = timeFont;
        timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 2.title
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = titleFont;
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 3.imageView
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
        
        // 4.Summary
        UILabel *summaryLabel = [[UILabel alloc] init];
        summaryLabel.font = summaryFont;
        summaryLabel.textColor = [UIColor lightGrayColor];
        summaryLabel.numberOfLines = 3;
        [self.contentView addSubview:summaryLabel];
        self.summaryLabel = summaryLabel;
        
        // 5.bottomLineView
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = cellLineColor;
        [self.contentView addSubview:bottomLineView];
        self.bottomLineView = bottomLineView;
    }
    return self;
}

- (void)setWcDynamic:(WCDynamic *)wcDynamic {
    _wcDynamic = wcDynamic;
    
    self.timeLabel.text = wcDynamic.AddDate;
    
    self.titleLabel.text = wcDynamic.Title;
    
    if (wcDynamic.IsImg) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:wcDynamic.Img] placeholderImage:[UIImage imageNamed:@"img_loading"]];
    }
    
    self.summaryLabel.text = wcDynamic.Summary;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat paddingX = 10;
    CGFloat paddingY = 0;
    CGFloat parentW = self.frame.size.width;
    CGFloat parentH = self.frame.size.height;
    
    CGFloat timeLabelX = paddingX;
    CGFloat timeLabelY = paddingY;
    CGFloat timeLabelW = 70.0f;
    CGFloat timeLabelH = 20.0f;
    self.timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat titleLabelX = CGRectGetMaxX(_timeLabel.frame);
    CGFloat titleLabelY = paddingY;
    CGFloat titleLabelW = parentW - titleLabelX - paddingX;
    CGSize  titleSize = [self.titleLabel.text sizeWithFont:titleFont maxSize:CGSizeMake(titleLabelW, 36.0f)];
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleSize.height);
    
    CGFloat imgViewW = 0;
    CGFloat imgViewH = 0;
    if (_wcDynamic.IsImg) {
        imgViewW = 90;
        imgViewH = 70;
    }
    CGFloat imgViewX = parentW - paddingX - imgViewW;
    CGFloat imgViewY = parentH - imgViewH - 4.0f;
    self.imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    
    CGFloat summaryLabelX = paddingX;
    CGFloat summaryLabelY = CGRectGetMaxY(_titleLabel.frame);
    CGFloat summaryLabelW = imgViewX - paddingX;
    CGFloat summaryLabelH = parentH - summaryLabelY - 4.0f;
    self.summaryLabel.frame = CGRectMake(summaryLabelX, summaryLabelY, summaryLabelW, summaryLabelH);
    
    self.bottomLineView.frame = CGRectMake(0, parentH - 1, ScreenW, 1.0f);
}



@end

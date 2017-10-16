//
//  WCDynamicCell.m
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCDynamicCell.h"

#define titleFont [UIFont systemFontOfSize:15]
#define timeFont  [UIFont systemFontOfSize:12]

@interface WCDynamicCell()
@property (nonatomic, weak) UILabel  *titleLabel;
@property (nonatomic, weak) UILabel  *timeLabel;
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
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = titleFont;
        titleLabel.numberOfLines = 2;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = timeFont;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = cellLineColor;
        [self.contentView addSubview:bottomLineView];
        self.bottomLineView = bottomLineView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat paddingX = 10;
    CGFloat paddingY = 0;
    
    self.titleLabel.frame = CGRectMake(paddingX, paddingY, ScreenW - 2 * paddingX, 25.0f);
    
    self.timeLabel.frame = CGRectMake(paddingX, CGRectGetMaxY(self.titleLabel.frame), ScreenW - 2 * paddingX, 18.0f);
    
    self.bottomLineView.frame = CGRectMake(0, 43.0f, ScreenW, 1.0f);
}

- (void)setDynamicResult:(WCDynamicResult *)dynamicResult {
    _dynamicResult = dynamicResult;
    
    self.titleLabel.text = dynamicResult.Title;
    
    self.timeLabel.text = dynamicResult.AddDate;
}

@end

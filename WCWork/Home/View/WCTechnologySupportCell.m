//
//  WCTechnologySupportCell.m
//  WCWork
//
//  Created by information on 2017/12/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCTechnologySupportCell.h"

@interface WCTechnologySupportCell()
@property (nonatomic, weak) UILabel  *supportLabel;
@end

@implementation WCTechnologySupportCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"technologySupportCell";
    WCTechnologySupportCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WCTechnologySupportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *supportLabel = [[UILabel alloc] init];
        supportLabel.textAlignment = NSTextAlignmentCenter;
        supportLabel.font = [UIFont systemFontOfSize:14];
        supportLabel.text = @"技术支持 浙江物产信息技术有限公司";
        _supportLabel = supportLabel;
        [self.contentView addSubview:supportLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.supportLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end

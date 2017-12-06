//
//  WCNewArrivalCell.m
//  HYWork
//
//  Created by information on 16/6/29.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import "WCNewArrivalCell.h"
#import "UIImageView+WebCache.h"

@interface WCNewArrivalCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation WCNewArrivalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"WCNewArrivalCell";
    WCNewArrivalCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WCNewArrivalCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setArrival:(WCNewArrival *)arrival {
    _arrival = arrival;
//    
//    NSURL *url = [NSURL URLWithString:arrival.img_url];
//    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_img_loading"]]; //加载
//    
//    self.nameLabel.text = arrival.title;
    
    self.timeLabel.text = arrival.submit_date;
}

@end

//
//  WCHonourCompanyCell.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCHonourCompanyCell.h"

@interface WCHonourCompanyCell()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WCHonourCompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"WCHonourCompanyCell";
    WCHonourCompanyCell *honourCompanyCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (honourCompanyCell == nil) {
        honourCompanyCell = [[[NSBundle mainBundle] loadNibNamed:@"WCHonourCompanyCell" owner:nil options:nil] lastObject];
    }
    return honourCompanyCell;
}

- (void)setHonour:(WCHonourCompany *)honour {
    _honour = honour;
    self.dateLabel.text = honour.honor_date;
    self.titleLabel.text = honour.introduction;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

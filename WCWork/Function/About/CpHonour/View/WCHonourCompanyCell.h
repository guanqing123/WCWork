//
//  WCHonourCompanyCell.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCHonourCompany.h"

@interface WCHonourCompanyCell : UITableViewCell

@property (nonatomic, strong)  WCHonourCompany *honour;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

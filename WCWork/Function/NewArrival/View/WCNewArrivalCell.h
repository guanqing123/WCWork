//
//  WCNewArrivalCell.h
//  HYWork
//
//  Created by information on 16/6/29.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCNewArrival.h"

@interface WCNewArrivalCell : UITableViewCell

@property (nonatomic, strong)  WCNewArrival *arrival;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

//
//  WCCheckAttendenceSignInOrOutCell.h
//  WCWork
//
//  Created by information on 2017/12/9.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCCheckInLog.h"

@interface WCCheckAttendenceSignInOrOutCell : UITableViewCell

@property (nonatomic, strong)  WCCheckInLog *checkInLog;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

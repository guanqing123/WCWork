//
//  WCAddCommonCell.h
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCItem.h"

@interface WCAddCommonCell : UITableViewCell

@property (nonatomic, strong)  WCItem *item;

@property (nonatomic, assign, getter=isChoosed)  BOOL choose;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

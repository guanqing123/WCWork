//
//  WCDynamicCell.h
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCDynamicResult.h"

@interface WCDynamicCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)  WCDynamicResult *dynamicResult;

@end

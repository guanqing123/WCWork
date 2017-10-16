//
//  WCCommonUseCell.h
//  WCWork
//
//  Created by information on 2017/10/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCItem.h"
@class WCCommonUseCell;

@protocol WCCommonUseCellDelegate <NSObject>
@optional
- (void)commonUseCell:(WCCommonUseCell *)commonUseCell btnDidClickWithWCItem:(WCItem *)item;
@end

@interface WCCommonUseCell : UITableViewCell

@property (nonatomic, weak) id<WCCommonUseCellDelegate>  delegate;

@property (strong, nonatomic) NSMutableArray *commonUseArray;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

//
//  WCMoreDynamicCell.h
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCMoreDynamicCell;

@protocol WCMoreDynamicCellDelegate <NSObject>
@optional
- (void)moreDynamicCellDidRefreshBtn:(WCMoreDynamicCell *)moreDynamicCell;
@end

@interface WCMoreDynamicCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<WCMoreDynamicCellDelegate>  delegate;

- (void)loading;

- (void)show;

- (void)failure;

@end

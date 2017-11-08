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

/**
 失败后的刷新按钮

 @param moreDynamicCell 当前刷新按钮所在的cell
 */
- (void)moreDynamicCellDidRefreshBtn:(WCMoreDynamicCell *)moreDynamicCell;
@end

@interface WCMoreDynamicCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<WCMoreDynamicCellDelegate>  delegate;

- (void)loading;

- (void)show;

- (void)failure;

@end

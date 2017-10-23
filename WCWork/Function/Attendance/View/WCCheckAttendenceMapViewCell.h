//
//  KqViewCell.h
//  HYWork
//
//  Created by information on 16/3/31.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCCheckAttendenceMapViewCell;

@protocol WCCheckAttendenceMapViewCellDelegate <NSObject>
@optional

/**
 刷新当前地图页面

 @param checkAttendenceMapViewCell 当前cell
 */
- (void)checkAttendenceMapViewCellBtnClickToRefreshLocation:(WCCheckAttendenceMapViewCell *)checkAttendenceMapViewCell;

@end

@interface WCCheckAttendenceMapViewCell : UITableViewCell

@property (nonatomic, copy) NSString *wz;

@property (nonatomic, assign, getter=isClick) BOOL click;

@property (nonatomic, copy) NSString *imgName;

@property (nonatomic, weak) id<WCCheckAttendenceMapViewCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setBtnImg:(NSString *)imgName andClick:(BOOL)click;

@end

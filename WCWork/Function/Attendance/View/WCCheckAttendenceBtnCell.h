//
//  WCCheckAttendenceBtnCell.h
//  HYWork
//
//  Created by information on 16/4/1.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCCheckAttendenceBtnCell;

@protocol WCCheckAttendenceBtnCellDelegate <NSObject>
@optional

/**
 点击入按钮

 @param checkAttendenceBtnCell 当前btn cell
 */
- (void)checkAttendenceBtnCellDelegateClickInBtn:(WCCheckAttendenceBtnCell *)checkAttendenceBtnCell;

/**
 点击出按钮
 
 @param checkAttendenceBtnCell 当前btn cell
 */
- (void)checkAttendenceBtnCellDelegateClickOutBtn:(WCCheckAttendenceBtnCell *)checkAttendenceBtnCell;

@end

@interface WCCheckAttendenceBtnCell : UITableViewCell

@property (nonatomic, copy) NSString *inBtnImg;
@property (nonatomic, copy) NSString *outBtnImg;

@property (nonatomic, assign, getter=isBtnClick) BOOL btnClick;

@property (nonatomic, weak) id<WCCheckAttendenceBtnCellDelegate>  delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setInBtnImg:(NSString *)inBtnImg outBtnImg:(NSString *)outBtnImg canClick:(BOOL)click;

@end

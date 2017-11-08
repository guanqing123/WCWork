//
//  WCSectionHeaderView.h
//  WCWork
//
//  Created by information on 2017/11/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCSectionHeaderView;

@protocol WCSectionHeaderViewDelegate <NSObject>
@optional

/**
 点击刷新按钮

 @param headerView 当前headerView
 */
- (void)sectionHeaderViewDidClickRefreshBtn:(WCSectionHeaderView *)headerView;

/**
 点击segment的索引

 @param headerView 当前headerView
 @param selectedSegmentIndex 选中的索引
 */
- (void)sectionHeaderView:(WCSectionHeaderView *)headerView selectedSegmentIndex:(NSInteger)selectedSegmentIndex;

@end

@interface WCSectionHeaderView : UIView

@property (nonatomic, weak) id<WCSectionHeaderViewDelegate>  delegate;

+ (instancetype)headerView;

- (void)loading;

- (void)show:(NSArray *)items;

- (void)failure:(NSString *)error;

@end

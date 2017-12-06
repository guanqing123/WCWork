//
//  WCSlideshowHeadView.h
//  WCWork
//
//  Created by information on 2017/10/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCSlideshowHeadView;

@protocol WCSlideshowHeadViewDelegate <NSObject>
@optional

/**
 网络异常,点击重新刷新按钮

 @param headerView 当前头部View
 */
- (void)slideShowHeaderViewDidClickRefreshBtn:(WCSlideshowHeadView *)headerView;


/**
 点击当前图片,跳转方法

 @param headerView 当前头部View
 @param index 选择索引
 */
- (void)slideShowHeaderView:(WCSlideshowHeadView *)headerView selectedIndex:(NSInteger)index;

@end

@interface WCSlideshowHeadView : UIView

@property (nonatomic, weak) id<WCSlideshowHeadViewDelegate> delegate;

+ (instancetype)headerView;

- (void)loading;

- (void)show:(NSArray *)resultArray;

- (void)failure;

@end

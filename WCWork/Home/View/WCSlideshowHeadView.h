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

- (void)slideShowHeaderViewDidClickRefreshBtn:(WCSlideshowHeadView *)headerView;

@end

@interface WCSlideshowHeadView : UIView

@property (nonatomic, weak) id<WCSlideshowHeadViewDelegate> delegate;

+ (instancetype)headerView;

- (void)loading;

- (void)show:(NSArray *)resultArray;

- (void)failure;

@end

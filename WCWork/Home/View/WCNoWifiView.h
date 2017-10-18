//
//  WCNoWifiView.h
//  WCWork
//
//  Created by information on 2017/10/17.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCNoWifiView;

@protocol WCNoWifiViewDelegate <NSObject>
@optional
- (void)noWifiViewDidRefreshBtn:(WCNoWifiView *)noWifiView;
@end

@interface WCNoWifiView : UIView

- (void)show;

- (void)hide;

@property (nonatomic, weak) id<WCNoWifiViewDelegate>  delegate;

@end

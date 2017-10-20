//
//  WCMeTableFooterView.h
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCMeTableFooterView;

@protocol WCMeTableFooterViewDelegate <NSObject>
@optional

/**
 点击 登录/注销 按钮

 @param meTableFooterView  me Table FooterView
 */
- (void)meTableFooterViewDidLoginOrResignBtn:(WCMeTableFooterView *)meTableFooterView;

@end

@interface WCMeTableFooterView : UIView

@property (nonatomic, weak) id<WCMeTableFooterViewDelegate>  delegate;

+ (instancetype)footerView;

- (void)active;

- (void)unactive;

@end

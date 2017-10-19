//
//  WCAddressBookSearchHeaderView.h
//  WCWork
//
//  Created by information on 2017/10/17.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCAddressBookSearchHeaderView;

@protocol WCAddressBookSearchHeaderViewDelegate <NSObject>
@optional

/**
 点击搜索🔍按钮

 @param searchHeaderView 搜索headerView
 */
- (void)addressBookSearchHeaderViewDidSearchBtn:(WCAddressBookSearchHeaderView *)searchHeaderView;

@end

@interface WCAddressBookSearchHeaderView : UIView

+ (instancetype)headerView;

@property (nonatomic, weak) id<WCAddressBookSearchHeaderViewDelegate>  delegate;

@end

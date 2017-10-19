//
//  WCAddressBookSearchTitleView.h
//  WCWork
//
//  Created by information on 2017/10/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCAddressBookSearchTitleView;

@protocol WCAddressBookSearchTitleViewDelegate  <NSObject>
@optional

/**
 点击取消按钮

 @param searchTitleView 当前搜索view
 */
- (void)addressBookSearchTitleViewDidClickCancleBtn:(WCAddressBookSearchTitleView *)searchTitleView;


/**
 编辑搜索🔍内容

 @param searchTitleView 当前搜索view
 @param text 查询内容
 */
- (void)addressBookSearchTitleView:(WCAddressBookSearchTitleView *)searchTitleView textFieldDidChange:(NSString *)text;

@end

@interface WCAddressBookSearchTitleView : UIView

+ (instancetype)searchTitleView;

- (void)active;

- (void)unactive;

@property (nonatomic, weak) id<WCAddressBookSearchTitleViewDelegate>  delegate;

@end

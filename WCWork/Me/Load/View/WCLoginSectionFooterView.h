//
//  WCLoginSectionFooterView.h
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCLoginSectionFooterView;

@protocol WCLoginSectionFooterViewDelegate <NSObject>
@optional

/**
 点击登录按钮

 @param footerView 当前 section footerView
 */
- (void)loginSectionFooterViewDidClickLoginBtn:(WCLoginSectionFooterView *)footerView;

@end

@interface WCLoginSectionFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<WCLoginSectionFooterViewDelegate>  delegate;

+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

@end

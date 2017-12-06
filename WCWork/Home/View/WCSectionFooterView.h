//
//  WCSectionFooterView.h
//  WCWork
//
//  Created by information on 2017/12/5.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCSectionFooterView;

@protocol WCSectionFooterViewDelegate <NSObject>
@optional

/**
 网络异常,点击重新刷新按钮
 
 @param footerView 当前section footerView
 */
- (void)sectionFooterViewDidClickRefreshBtn:(WCSectionFooterView *)footerView;


/**
 点击当前图片,跳转方法
 
 @param footerView 当前section footerView
 @param index 选中索引
 */
- (void)sectionFooterView:(WCSectionFooterView *)footerView selectedIndex:(NSInteger)index;

@end

@interface WCSectionFooterView : UIView

@property (nonatomic, weak) id<WCSectionFooterViewDelegate>  delegate;

+ (instancetype)footerView;

- (void)loading;

- (void)show:(NSArray *)resultArray;

- (void)failure;

@end

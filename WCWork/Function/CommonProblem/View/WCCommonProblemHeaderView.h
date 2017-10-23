//
//  WCCommonProblemHeaderView.h
//  HYWork
//
//  Created by information on 16/7/7.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCCommonProblem.h"
@class WCCommonProblemHeaderView;

@protocol WCCommonProblemHeaderViewDelegate <NSObject>
- (void)headerViewDidClickedNameView:(WCCommonProblemHeaderView *)headerView;
@end

@interface WCCommonProblemHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)  WCCommonProblem *commonProblem;

@property (nonatomic, weak) id<WCCommonProblemHeaderViewDelegate>  delegate;

@end

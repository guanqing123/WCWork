//
//  WCMeTableHeaderView.h
//  WCWork
//
//  Created by information on 2017/10/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCMeTableHeaderView : UIView

+ (instancetype)headerView;

- (void)active:(NSString *)loginMsg;

- (void)unactive;

@end

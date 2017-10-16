//
//  WCAddCommonController.h
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCAddCommonController;

@protocol WCAddCommonControllerDelegate <NSObject>
@optional
- (void)addCommonControllerDidChooseBtn:(WCAddCommonController *)addCommonVc;
@end

@interface WCAddCommonController : UIViewController

@property (nonatomic, weak) id<WCAddCommonControllerDelegate>  delegate;

@end

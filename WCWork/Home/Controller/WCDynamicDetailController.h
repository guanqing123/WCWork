//
//  WCDynamicDetailController.h
//  WCWork
//
//  Created by information on 2017/10/17.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCDynamic.h"

@interface WCDynamicDetailController : UIViewController

@property (nonatomic, strong)  WCDynamic *wcDynamic;

- (instancetype)initWithWcDynamic:(WCDynamic *)wcDynamic;

@end

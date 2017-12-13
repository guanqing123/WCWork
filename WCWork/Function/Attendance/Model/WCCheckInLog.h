//
//  WCCheckInLog.h
//  WCWork
//
//  Created by information on 2017/12/9.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCCheckInLog : NSObject

@property (nonatomic, assign) NSNumber *Checkin;
@property (nonatomic, assign) NSNumber *Checkout;
@property (nonatomic, copy) NSString *ErrCode;
@property (nonatomic, copy) NSString *ErrMsg;

@end

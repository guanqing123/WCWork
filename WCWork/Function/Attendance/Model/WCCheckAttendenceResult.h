//
//  WCCheckAttendenceResult.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCCheckAttendenceFence.h"
#import "WCCheckInLog.h"

@interface WCCheckAttendenceResult : NSObject

@property (nonatomic, strong)  WCCheckInLog *checkInLog;
@property (nonatomic, assign) NSNumber *checkInTimes;
@property (nonatomic, strong)  NSArray *devices;
@property (nonatomic, strong)  NSArray *fence;
@property (nonatomic, assign) NSNumber *hasDevice;
@property (nonatomic, copy)   NSString *errorMsg;

- (instancetype)initWithErrorMsg:(NSString *)errorMsg;
+ (instancetype)errorMsg:(NSString *)errorMsg;

@end

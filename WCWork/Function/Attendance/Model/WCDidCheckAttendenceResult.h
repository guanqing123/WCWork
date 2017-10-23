//
//  WCDidCheckAttendenceResult.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCDidCheckAttendenceResult : NSObject

@property (nonatomic, assign) NSNumber *checkInTimes;

@property (nonatomic, strong)  NSArray *devices;

@property (nonatomic, copy) NSString *errorMsg;

@property (nonatomic, copy) NSString *signTime;

- (instancetype)initWithErrorMsg:(NSString *)errorMsg;
+ (instancetype)errorMsg:(NSString *)errorMsg;

@end

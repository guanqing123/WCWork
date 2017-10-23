//
//  WCDidCheckAttendenceResult.m
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCDidCheckAttendenceResult.h"

@implementation WCDidCheckAttendenceResult

- (instancetype)initWithErrorMsg:(NSString *)errorMsg {
    if (self = [super init]) {
        _errorMsg = errorMsg;
    }
    return self;
}

+ (instancetype)errorMsg:(NSString *)errorMsg {
    return [[self alloc] initWithErrorMsg:errorMsg];
}

@end

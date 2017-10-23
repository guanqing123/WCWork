//
//  WCCheckAttendenceTool.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCCheckAttendenceParam.h"
#import "WCCheckAttendenceResult.h"

#import "WCDidCheckAttendenceParam.h"
#import "WCDidCheckAttendenceResult.h"

@interface WCCheckAttendenceTool : NSObject

/**
 获取打卡次数与考勤范围

 @param checkAttendenceParam 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)checkAttendenceWithParam:(WCCheckAttendenceParam *)checkAttendenceParam success:(void(^)(WCCheckAttendenceResult *result))success failure:(void(^)(NSError *error))failure;


/**
 打卡后 获取打卡次数与设备

 @param didCheckAttendenceParam 完成打卡(顺带绑定)
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)didCheckAttendenceWithParam:(WCDidCheckAttendenceParam *)didCheckAttendenceParam success:(void(^)(WCDidCheckAttendenceResult *result))success failure:(void(^)(NSError *error))failure;

@end

//
//  WCDidCheckAttendenceParam.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCBaseParam.h"

@interface WCDidCheckAttendenceParam : WCBaseParam

/**
 *  工号
 */
@property (nonatomic, copy) NSString *gh;

/**
 *  设备ID
 */
@property (nonatomic, copy) NSString *did;

/**
 考勤类型
 */
@property (nonatomic, copy) NSString *kqlx;

/**
 地址
 */
@property (nonatomic, copy) NSString *dz;

/**
 *  是否需要绑定设备ID
 */
@property (nonatomic, assign, getter=isSign) NSString *sign;

@end

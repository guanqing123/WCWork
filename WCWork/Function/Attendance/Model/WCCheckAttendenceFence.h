//
//  WCCheckAttendenceFence.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WCCheckAttendenceFence : NSObject

/**
 *  地址
 */
@property (nonatomic, copy) NSString *address;

/**
 *  城市编号
 */
@property (nonatomic, copy) NSString *citycode;

/**
 *  围栏ID
 */
@property (nonatomic, assign) NSNumber *fenceid;

/**
 *  维度
 */
@property (nonatomic, assign) CLLocationDegrees latitude;

/**
 *  经度
 */
@property (nonatomic, assign) CLLocationDegrees longitude;

/**
 *  半径
 */
@property (nonatomic, assign) NSNumber *radius;

@end

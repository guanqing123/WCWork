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
 *  维度
 */
@property (nonatomic, assign) CLLocationDegrees lbs_latitude;

/**
 *  经度
 */
@property (nonatomic, assign) CLLocationDegrees lsb_longitude;

/**
 *  半径
 */
@property (nonatomic, assign) NSNumber *lbs_radius;


/**
 lbs_name
 */
@property (nonatomic, copy) NSString *lbs_name;

@end

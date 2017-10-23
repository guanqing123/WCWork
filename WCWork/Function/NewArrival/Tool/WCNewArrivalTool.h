//
//  WCNewArrivalTool.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCNewArrivalParam.h"
#import "WCNewArrivalResult.h"

@interface WCNewArrivalTool : NSObject

+ (void)newArrivalWithParam:(WCNewArrivalParam *)newArrivalParam success:(void(^)(WCNewArrivalResult *result))success failure:(void(^)(NSError *error))failure;

@end

//
//  WCHomeTool.h
//  WCWork
//
//  Created by information on 2017/10/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCSliderParam.h"
#import "WCSliderResult.h"

#import "WCDynamicParam.h"
#import "WCDynamicResult.h"

@interface WCHomeTool : NSObject

+ (void)homeSliderWithParam:(WCSliderParam *)sliderParam success:(void(^)(NSArray *sliderResult))success failure:(void(^)(NSError *error))failure;


+ (void)homeDynamicWithParam:(WCDynamicParam *)dynamicParam success:(void(^)(NSArray *dynamicResult))success failure:(void(^)(NSError *error))failure;

@end

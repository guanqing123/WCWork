//
//  WCClassicWorkTool.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCClassicWorkParam.h"
#import "WCClassicWorkResult.h"

@interface WCClassicWorkTool : NSObject

/**
 获取经典作品

 @param classicWorkParam 入参
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)classicWorkWithParam:(WCClassicWorkParam *)classicWorkParam success:(void(^)(WCClassicWorkResult *result))success failure:(void(^)(NSError *error))failure;

@end

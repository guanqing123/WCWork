//
//  WCOverViewCompanyTool.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCOverViewCompanyParam.h"

@interface WCOverViewCompanyTool : NSObject

/**
 获取企业概况

 @param overViewCompanyParam 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)overViewCompanyWithParam:(WCOverViewCompanyParam *)overViewCompanyParam success:(void(^)(NSString *content))success failure:(void(^)(NSError *error))failure;

@end

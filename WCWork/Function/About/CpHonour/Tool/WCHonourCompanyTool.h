//
//  WCHonourCompanyTool.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCHonourCompanyParam.h"
#import "WCHonourCompanyResult.h"

@interface WCHonourCompanyTool : NSObject

+ (void)honourCompanyListWithParam:(WCHonourCompanyParam *)honourCompanyParam success:(void(^)(WCHonourCompanyResult *result))success failure:(void(^)(NSError *error))failure;

@end

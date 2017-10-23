//
//  WCCommonProblemTool.h
//  WCWork
//
//  Created by information on 2017/10/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCCommonProbleParam.h"
#import "WCCommonProblem.h"

@interface WCCommonProblemTool : NSObject

+ (void)commomProblemWithParam:(WCCommonProbleParam *)commonProblemParam success:(void(^)(NSArray *commonProblem))success failure:(void(^)(NSError *error))failure;

+ (NSMutableArray *)jsonArrayToModelArray:(NSArray *)array;

@end

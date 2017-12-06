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

#import "WCSectionFooterViewParam.h"
#import "WCSectionFooterViewResult.h"

#import "WCSectionHeaderViewParam.h"
#import "WCSectionHeaderViewResult.h"

#import "WCDynamicParam.h"
#import "WCDynamicResult.h"

#import "WCDynamicDetailParam.h"
#import "WCDynamicDetailResult.h"

@interface WCHomeTool : NSObject


/**
 获取首页滚动数据

 @param sliderParam 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)homeSliderWithParam:(WCSliderParam *)sliderParam success:(void(^)(NSArray *sliderResult))success failure:(void(^)(NSError *error))failure;

/**
获取sectionFooterView内容

 @param sectionFooterViewParam 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)homeSectionFooterViewParam:(WCSectionFooterViewParam *)sectionFooterViewParam success:(void(^)(NSArray *sectionFooterViewResult))success failure:(void(^)(NSError *error))failure;

/**
 获取sectionHeaderView内容

 @param sectionHeaderViewParam 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)homeSectionHeaderViewParam:(WCSectionHeaderViewParam *)sectionHeaderViewParam success:(void(^)(NSArray *sectionHeaderViewResult))success failure:(void(^)(NSError *error))failure;

/**
 获取4大新闻内容

 @param dynamicParam 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)homeDynamicWithParam:(WCDynamicParam *)dynamicParam success:(void(^)(WCDynamicResult *dynamicResult))success failure:(void(^)(NSError *error))failure;

/**
 获取某条新闻的具体内容

 @param dynamicDetailParam 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)dynamicDetailWithParam:(WCDynamicDetailParam *)dynamicDetailParam success:(void(^)(WCDynamicDetailResult *dynamicDetailResult))success failure:(void(^)(NSError *error))failure;

@end

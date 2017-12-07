//
//  WCHonourCompanyParam.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCBaseParam.h"

@interface WCHonourCompanyParam : WCBaseParam
/** 是否要分页 */
@property (nonatomic, copy) NSString *need_paginate;
/** 第几页 */
@property (nonatomic, assign) NSNumber *page_number;
/** 每页几条 */
@property (nonatomic, assign) NSNumber *page_size;
@end

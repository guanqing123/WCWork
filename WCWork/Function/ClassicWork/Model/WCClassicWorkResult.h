//
//  WCClassicWorkResult.h
//  WCWork
//
//  Created by information on 2017/10/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCClassicWork.h"

@interface WCClassicWorkResult : NSObject

@property (nonatomic, assign) NSNumber *pageNumber;

@property (nonatomic, assign) NSNumber *totalRow;

@property (nonatomic, strong)  NSArray *list;

@property (nonatomic, assign) NSNumber *pageSize;

@property (nonatomic, assign) NSNumber *totalPage;

@property (nonatomic, copy)   NSString *errorMsg;

- (instancetype)initWithErrorMsg:(NSString *)errorMsg;
+ (instancetype)errorMsg:(NSString *)errorMsg;

@end

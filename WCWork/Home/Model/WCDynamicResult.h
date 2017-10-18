//
//  WCDynamicResult.h
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCDynamic.h"

@interface WCDynamicResult : NSObject

@property (nonatomic, copy) NSString *ColumnId;
@property (nonatomic, assign) NSNumber *PageSize;
@property (nonatomic, assign) NSNumber *CurrentPage;
@property (nonatomic, assign) NSNumber *RCount;
@property (nonatomic, strong)  NSArray *NewsList;

@end

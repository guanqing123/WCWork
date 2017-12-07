//
//  WCHonourCompanyResult.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "WCHonourCompany.h"

@interface WCHonourCompanyResult : NSObject

@property (nonatomic, assign) NSNumber *firstPage;
@property (nonatomic, assign) NSNumber *lastPage;
@property (nonatomic, strong)  NSArray *list;
@property (nonatomic, assign) NSNumber *pageNumber;
@property (nonatomic, assign) NSNumber *pageSize;
@property (nonatomic, assign) NSNumber *totalPage;
@property (nonatomic, assign) NSNumber *totalRow;

@end

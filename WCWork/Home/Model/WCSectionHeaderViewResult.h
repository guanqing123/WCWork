//
//  WCSectionHeaderViewResult.h
//  WCWork
//
//  Created by information on 2017/11/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCSectionHeaderViewResult : NSObject

@property (nonatomic, copy) NSString *ColumnId;
@property (nonatomic, assign) NSNumber *PageSize;
@property (nonatomic, copy) NSString *ColumnName;
@property (nonatomic, assign) NSNumber *CountNum;

@end

//
//  WCLoginResult.h
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCLoginAccount.h"

@interface WCLoginResult : NSObject

@property (nonatomic, assign) NSNumber *code;
@property (nonatomic, strong)  WCLoginAccount *entry;
@property (nonatomic, copy) NSString *groupIdsStr;
@property (nonatomic, copy) NSString *serviceName;

@property (nonatomic, assign) BOOL error;
@property (nonatomic, copy) NSString *errorMsg;

+ (instancetype)result;

@end

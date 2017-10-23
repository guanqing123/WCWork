//
//  WCLoginTool.h
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCLoginParam.h"
#import "WCLoginResult.h"

@interface WCLoginTool : NSObject

+ (void)loginWithParam:(WCLoginParam *)loginParam success:(void(^)(WCLoginResult *loginResult))success failure:(void(^)(NSError *error))failure;

+ (void)saveLoginAccount:(WCLoginAccount *)loginAccount;

+ (WCLoginAccount *)loginAccount;

@end

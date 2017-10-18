//
//  WCAddressBookTool.h
//  WCWork
//
//  Created by information on 2017/10/18.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WCAddressBookListParam.h"
#import "WCAddressBookListResult.h"

@interface WCAddressBookTool : NSObject

+ (void)addressBookListWithParam:(WCAddressBookListParam *)addressBookListParam success:(void(^)(WCAddressBookListResult *addressBookListResult))success failure:(void(^)(NSError *error))failure;

@end

//
//  WCLoginAccount.h
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCLoginAccount : NSObject<NSCoding>

@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;

@end

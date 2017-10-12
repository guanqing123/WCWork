//
//  SPBaseParam.h
//  HYSmartPlus
//
//  Created by information on 2017/9/15.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCBaseParam : NSObject
@property (nonatomic, copy) NSString *trdate;
@property (nonatomic, copy) NSString *trcode;
@property (nonatomic, copy) NSString *appseq;

- (instancetype)initParam:(NSString *)trcode;
+ (instancetype)param:(NSString *)trcode;
@end

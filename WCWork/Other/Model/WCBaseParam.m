//
//  SPBaseParam.m
//  HYSmartPlus
//
//  Created by information on 2017/9/15.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCBaseParam.h"

@implementation WCBaseParam

- (instancetype)initParam:(NSString *)trcode {
    if (self = [super init]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *trdate = [formatter stringFromDate:[NSDate date]];
        self.trdate = trdate;
        self.trcode = trcode;
        self.appseq = @"IOS";
    }
    return self;
}

+ (instancetype)param:(NSString *)trcode {
    return [[self alloc] initParam:trcode];
}

@end

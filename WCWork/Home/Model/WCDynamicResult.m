//
//  WCDynamicResult.m
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCDynamicResult.h"
#import "MJExtension.h"

@implementation WCDynamicResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"NewsList" : [WCDynamic class]};
}

@end

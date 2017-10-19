//
//  WCGroup.m
//  WCWork
//
//  Created by information on 2017/10/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCGroup.h"
#import "WCItem.h"

@implementation WCGroup

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.header = dict[@"header"];
        self.r = [dict[@"r"] floatValue];
        self.g = [dict[@"g"] floatValue];
        self.b = [dict[@"b"] floatValue];
        NSArray *dictArray = dict[@"items"];
        NSMutableArray *itemArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            WCItem *item = [WCItem itemWithDict:dict];
            [itemArray addObject:item];
        }
        self.items = itemArray;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end

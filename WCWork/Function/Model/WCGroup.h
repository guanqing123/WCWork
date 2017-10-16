//
//  WCGroup.h
//  WCWork
//
//  Created by information on 2017/10/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCGroup : NSObject

@property (nonatomic,copy) NSString *header;
@property (strong, nonatomic)  NSArray *items;
@property (assign, nonatomic) CGFloat r;
@property (assign, nonatomic) CGFloat g;
@property (assign, nonatomic) CGFloat b;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;

@end

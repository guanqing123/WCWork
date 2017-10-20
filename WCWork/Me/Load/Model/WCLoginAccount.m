//
//  WCLoginAccount.m
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCLoginAccount.h"

@implementation WCLoginAccount

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.trueName = [aDecoder decodeObjectForKey:@"trueName"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.trueName forKey:@"trueName"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.email forKey:@"email"];
}

@end

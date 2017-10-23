//
//  WCCommonProblem.m
//  WCWork
//
//  Created by information on 2017/10/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCCommonProblem.h"

@implementation WCCommonProblem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _question = [dict objectForKey:@"faq_question"];
        
        _solution = [dict objectForKey:@"faq_solution"];
        
        _reason = [dict objectForKey:@"faq_reason"];
        
        _isOpened = NO;
        
        _indexArry = [[NSMutableArray alloc] init];
        
        _solutionHight = 150;
        _reasonHight = 150;
    }
    return self;
}

+ (instancetype)commonProblemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end

//
//  WCCommonProblem.h
//  WCWork
//
//  Created by information on 2017/10/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCCommonProblem : NSObject

@property (strong, nonatomic) NSString *question;

@property (strong, nonatomic) NSString *solution;

@property (strong, nonatomic) NSString *reason;

@property (assign, nonatomic) BOOL isOpened;

@property (strong, nonatomic) NSMutableArray *questionArry;

@property (strong, nonatomic) NSMutableArray *listArry;

@property (strong, nonatomic) NSMutableArray *indexArry;

@property (assign, nonatomic) float reasonHight;

@property (assign, nonatomic) float solutionHight;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)commonProblemWithDict:(NSDictionary *)dict;

@end

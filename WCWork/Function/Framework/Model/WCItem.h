//
//  WCItem.h
//  WCWork
//
//  Created by information on 2017/10/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCItem : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *destVcClass;
@property (nonatomic, assign) NSNumber *order;
@property (nonatomic, copy) NSString *load;
@property (nonatomic, copy) NSString *firstShow;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)itemWithDict:(NSDictionary *)dict;


@end

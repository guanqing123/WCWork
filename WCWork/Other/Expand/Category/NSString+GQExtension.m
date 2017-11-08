//
//  NSString+GQExtension.m
//  WCWork
//
//  Created by information on 2017/11/8.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "NSString+GQExtension.h"

@implementation NSString (GQExtension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end

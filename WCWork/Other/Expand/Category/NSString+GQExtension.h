//
//  NSString+GQExtension.h
//  WCWork
//
//  Created by information on 2017/11/8.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GQExtension)

/**
 根据字体和最大区域返回所占用的尺寸

 @param font 字体
 @param maxSize 最大区域
 @return 具体尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;



/**
 md5 加密

 @param input 输入参数
 @return 返回加密结果
 */
+ (NSString *)md5DigestWithString:(NSString *)input;

@end

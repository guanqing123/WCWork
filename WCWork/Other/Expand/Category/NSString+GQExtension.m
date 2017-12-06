//
//  NSString+GQExtension.m
//  WCWork
//
//  Created by information on 2017/11/8.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "NSString+GQExtension.h"

extern unsigned char *CC_MD5(const void *data, uint32_t len, unsigned char *md)
__OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

@implementation NSString (GQExtension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSString *)md5DigestWithString:(NSString *)input {
    const char *str = [input UTF8String];
    unsigned char result[16];
    CC_MD5(str, (uint32_t)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:16 * 2];
    for (int i = 0; i<16; i++) {
        [ret appendFormat:@"%02x",(unsigned)(result[i])];
    }
    return ret;
}

@end

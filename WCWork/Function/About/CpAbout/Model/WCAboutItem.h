//
//  WCAboutItem.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCAboutItem : NSObject

/** 照片 */
@property (nonatomic, copy) NSString *image;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 目标控制器 */
@property (nonatomic, copy) NSString *destVcClass;

@end

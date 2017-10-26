//
//  WCAboutFooterView.m
//  WCWork
//
//  Created by information on 2017/10/26.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAboutFooterView.h"

@implementation WCAboutFooterView

+ (instancetype)footerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WCAboutFooterView" owner:self options:nil] lastObject];
}

@end

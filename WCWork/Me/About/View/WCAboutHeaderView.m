//
//  WCAboutHeaderView.m
//  WCWork
//
//  Created by information on 2017/10/26.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAboutHeaderView.h"

@interface WCAboutHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation WCAboutHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WCAboutHeaderView" owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [dict objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"版本号%@",version];
}

@end

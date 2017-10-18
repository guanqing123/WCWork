//
//  WCAddressBookSectionHeaderView.m
//  WCWork
//
//  Created by information on 2017/10/18.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookSectionHeaderView.h"

#define WCSectionHeaderViewHeight 25.0f

@interface WCAddressBookSectionHeaderView()
@property (nonatomic, weak) UILabel  *titleLabel;
@end

@implementation WCAddressBookSectionHeaderView

+ (instancetype)sectionHeaderViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"addressBookSectionHeaderView";
    WCAddressBookSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (sectionHeaderView == nil) {
        sectionHeaderView = [[WCAddressBookSectionHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return sectionHeaderView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGB(244.0f, 244.0f, 244.0f);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat paddingX = 10;
    CGFloat parentW = self.frame.size.width;
    CGFloat parentH = self.frame.size.height;
    self.titleLabel.frame = CGRectMake(paddingX, 0, parentW - 2 * paddingX, parentH);
}

- (void)setSectionKey:(NSString *)sectionKey {
    _sectionKey = sectionKey;
    self.titleLabel.text = sectionKey;
}

+ (CGFloat)height {
    return WCSectionHeaderViewHeight;
}

@end

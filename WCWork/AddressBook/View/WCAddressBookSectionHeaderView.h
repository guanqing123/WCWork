//
//  WCAddressBookSectionHeaderView.h
//  WCWork
//
//  Created by information on 2017/10/18.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCAddressBookSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *sectionKey;

+ (instancetype)sectionHeaderViewWithTableView:(UITableView *)tableView;

+ (CGFloat)height;

@end

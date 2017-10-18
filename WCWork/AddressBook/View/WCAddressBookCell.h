//
//  WCAddressBookCell.h
//  WCWork
//
//  Created by information on 2017/10/18.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCAddressBookCell : UITableViewCell

@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *mobile;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)height;

@end

//
//  WCLoginCell.h
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCLoginCell;

@protocol WCLoginCellDelegate <NSObject>
@optional

- (void)loginCell:(WCLoginCell *)loginCell didEditTextFieldChange:(NSString *)text;

@end

@interface WCLoginCell : UITableViewCell

@property (nonatomic, weak) id<WCLoginCellDelegate> delegate;

@property (nonatomic, strong)  NSDictionary *loginDict;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

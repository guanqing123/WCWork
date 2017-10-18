//
//  WCDynamicListController.h
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCDynamicListController : UITableViewController

@property (nonatomic, copy) NSString *columnId;

- (instancetype)initWithColumnId:(NSString *)columnId;

@end

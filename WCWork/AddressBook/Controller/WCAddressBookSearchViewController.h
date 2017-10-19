//
//  WCAddressBookSearchViewController.h
//  WCWork
//
//  Created by information on 2017/10/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCAddressBookListResult.h"

@interface WCAddressBookSearchViewController : UIViewController

@property (nonatomic, strong)  WCAddressBookListResult *addressBookListResult;

- (instancetype)initWithAddressBookListResult:(WCAddressBookListResult *)addressBookListResult;

@end

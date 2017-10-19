//
//  WCAddressBookSearchHeaderView.m
//  WCWork
//
//  Created by information on 2017/10/17.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookSearchHeaderView.h"

@interface WCAddressBookSearchHeaderView()

@end

@implementation WCAddressBookSearchHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0.0f, 0.0f, ScreenW, 44.0f);
        
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.frame = CGRectMake(0.0f, 0.0f, ScreenW, 44.0f);
        searchBar.placeholder = @"关键字搜索";
        searchBar.userInteractionEnabled = YES;
        searchBar.backgroundImage = [UIImage imageNamed:@"searchBarBackImage"];
        
        UITextField *searchTextFiled = [searchBar valueForKey:@"_searchField"];
        searchTextFiled.backgroundColor = RGB(244.0f, 244.0f, 244.0f);
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame = CGRectMake(0.0f, 0.0f, ScreenW, 44.0f);
        [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [searchBar addSubview:searchBtn];
        [self addSubview:searchBar];
    }
    return self;
}

+ (instancetype)headerView {
    return [[self alloc] init];
}

- (void)searchBtnClick {
    if ([self.delegate respondsToSelector:@selector(addressBookSearchHeaderViewDidSearchBtn:)]) {
        [self.delegate addressBookSearchHeaderViewDidSearchBtn:self];
    }
}

@end

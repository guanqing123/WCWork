//
//  WCAddressBookSearchTitleView.m
//  WCWork
//
//  Created by information on 2017/10/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddressBookSearchTitleView.h"
#import "YLYSearchBar.h"

@interface WCAddressBookSearchTitleView()
@property (nonatomic, strong)  YLYSearchBar *searchBar;
@property (nonatomic, strong)  UIButton *cancleBtn;
@end

@implementation WCAddressBookSearchTitleView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenW, WCNaviH);
        self.backgroundColor = [UIColor clearColor];
        // 1.searchBar
        [self addSubview:self.searchBar];
        // 2.cancleBtn
        [self addSubview:self.cancleBtn];
    }
    return self;
}

+ (instancetype)searchTitleView {
    return [[self alloc] init];
}

- (YLYSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[YLYSearchBar alloc] init];
        _searchBar.keyboardType = UIKeyboardTypeWebSearch;
        _searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _searchBar.layer.borderWidth = 0.2;
        _searchBar.layer.cornerRadius = 4;
//        _searchBar.delegate = self;
        _searchBar.backgroundColor = RGB(244.0f, 244.0f, 244.0f);
        _searchBar.frame = CGRectMake(0.0f, 5.0f, ScreenW - 60.0f, 32.0f);
        [_searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_searchBar];
    }
    return _searchBar;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame), 5.0f, 60.0f, 32.0f);
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleBtn];
    }
    return _cancleBtn;
}

- (void)active {
    [self.searchBar becomeFirstResponder];
}

- (void)unactive {
    [self.searchBar resignFirstResponder];
}

- (void)cancleBtnClick {
    if ([self.delegate respondsToSelector:@selector(addressBookSearchTitleViewDidClickCancleBtn:)]) {
        [self.delegate addressBookSearchTitleViewDidClickCancleBtn:self];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(addressBookSearchTitleView:textFieldDidChange:)]) {
        [self.delegate addressBookSearchTitleView:self textFieldDidChange:textField.text];
    }
}

@end

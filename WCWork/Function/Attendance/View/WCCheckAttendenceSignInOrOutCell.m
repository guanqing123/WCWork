//
//  WCCheckAttendenceSignInOrOutCell.m
//  WCWork
//
//  Created by information on 2017/12/9.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCCheckAttendenceSignInOrOutCell.h"
#import "WCCustomButton.h"
#import <Masonry.h>

@interface WCCheckAttendenceSignInOrOutCell()
@property (nonatomic, weak) WCCustomButton  *signInBtn;
@property (nonatomic, weak) UILabel  *signInLabel;
@property (nonatomic, weak) WCCustomButton  *signOutBtn;
@property (nonatomic, weak) UILabel  *signOutLabel;
@property (nonatomic, weak) UIView  *bottomLineView;
@end

@implementation WCCheckAttendenceSignInOrOutCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"WCCheckAttendenceSignInOrOutCell";
    WCCheckAttendenceSignInOrOutCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WCCheckAttendenceSignInOrOutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WCCustomButton *signInBtn = [[WCCustomButton alloc] init];
        [signInBtn setTitle:@"签到" forState:UIControlStateNormal];
        [signInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        signInBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _signInBtn = signInBtn;
        [self.contentView addSubview:signInBtn];
        
        UILabel *signInLabel = [[UILabel alloc] init];
        signInLabel.font = [UIFont systemFontOfSize:14.0];
        _signInLabel = signInLabel;
        [self.contentView addSubview:signInLabel];
        
        WCCustomButton *signOutBtn = [[WCCustomButton alloc] init];
        [signOutBtn setTitle:@"签退" forState:UIControlStateNormal];
        [signOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        signOutBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _signOutBtn = signOutBtn;
        [self.contentView addSubview:signOutBtn];
        
        UILabel *signOutLabel = [[UILabel alloc] init];
        signOutLabel.font = [UIFont systemFontOfSize:14.0];
        _signOutLabel = signOutLabel;
        [self.contentView addSubview:signOutLabel];
        
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = RGBA(238, 238, 238, 0.8);
        _bottomLineView = bottomLineView;
        [self.contentView addSubview:bottomLineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.equalTo(self) setOffset:5];
        make.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self.signInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.equalTo(self) setOffset:5];
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.signInBtn.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.bottom.equalTo(self) setOffset:-5];
        make.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self.signOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.bottom.equalTo(self) setOffset:-5];
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.signOutBtn.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        [make.left.mas_equalTo(self) setOffset:15];
        [make.right.mas_equalTo(self) setOffset:-15];
        make.height.mas_equalTo(1);
    }];
}

- (void)setCheckInLog:(WCCheckInLog *)checkInLog {
    _checkInLog = checkInLog;
    if ([checkInLog.Checkin intValue] == 1) {
        [self.signInBtn setImage:[UIImage imageNamed:@"home_func_unselect"] forState:UIControlStateNormal];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.signInLabel.text = [userDefaults objectForKey:@"signInTime"];
    }else{
        [self.signInBtn setImage:[UIImage imageNamed:@"home_func_select"] forState:UIControlStateNormal];
        self.signInLabel.text = @"";
    }
    
    if ([checkInLog.Checkout intValue] == 1) {
        [self.signOutBtn setImage:[UIImage imageNamed:@"home_func_unselect"] forState:UIControlStateNormal];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.signOutLabel.text = [userDefaults objectForKey:@"signOutTime"];
    }else{
        [self.signOutBtn setImage:[UIImage imageNamed:@"home_func_select"] forState:UIControlStateNormal];
        self.signOutLabel.text = @"";
    }
}

@end

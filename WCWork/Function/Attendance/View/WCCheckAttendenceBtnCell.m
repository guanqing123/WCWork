//
//  WCCheckAttendenceBtnCell.m
//  HYWork
//
//  Created by information on 16/4/1.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import "WCCheckAttendenceBtnCell.h"

@interface WCCheckAttendenceBtnCell()

@property (nonatomic, weak) UIButton  *kqInBtn;

@property (nonatomic, weak) UIButton  *kqOutBtn;

@end

@implementation WCCheckAttendenceBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"WCCheckAttendenceBtnCell";
    WCCheckAttendenceBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WCCheckAttendenceBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *kqInBtn = [[UIButton alloc] init];
        [kqInBtn addTarget:self action:@selector(inBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _kqInBtn = kqInBtn;
        [self.contentView addSubview:kqInBtn];
        
        UIButton *kqOutBtn = [[UIButton alloc] init];
        [kqOutBtn addTarget:self action:@selector(outBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _kqOutBtn = kqOutBtn;
        [self.contentView addSubview:kqOutBtn];
    }
    return self;
}

- (void)inBtnClick {
    if (_btnClick && [self.delegate respondsToSelector:@selector(checkAttendenceBtnCellDelegateClickInBtn:)]) {
        [self.delegate checkAttendenceBtnCellDelegateClickInBtn:self];
    }
}

- (void)outBtnClick {
    if (_btnClick && [self.delegate respondsToSelector:@selector(checkAttendenceBtnCellDelegateClickOutBtn:)]) {
        [self.delegate checkAttendenceBtnCellDelegateClickOutBtn:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat parentW = self.frame.size.width;
    CGFloat parentH = self.frame.size.height;
    
    CGFloat paddingX = (parentW - 200) / 4;
    CGFloat paddingY = parentH / 2 - 50;
    
    self.kqInBtn.frame = CGRectMake(paddingX, paddingY, 100, 100);
    
    self.kqOutBtn.frame = CGRectMake(CGRectGetMaxX(_kqInBtn.frame) + 2 * paddingX, paddingY, 100, 100);
}

- (void)setInBtnImg:(NSString *)inBtnImg outBtnImg:(NSString *)outBtnImg canClick:(BOOL)click {
    _inBtnImg = inBtnImg;
    _outBtnImg = outBtnImg;
    _btnClick = click;
    
    [self.kqInBtn setImage:[UIImage imageNamed:inBtnImg] forState:UIControlStateNormal];
    [self.kqInBtn setImage:[UIImage imageNamed:inBtnImg] forState:UIControlStateHighlighted];
    
    [self.kqOutBtn setImage:[UIImage imageNamed:outBtnImg] forState:UIControlStateNormal];
    [self.kqOutBtn setImage:[UIImage imageNamed:outBtnImg] forState:UIControlStateHighlighted];
}

@end

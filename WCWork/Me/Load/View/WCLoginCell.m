//
//  WCLoginCell.m
//  WCWork
//
//  Created by information on 2017/10/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCLoginCell.h"

@interface WCLoginCell()
@property (nonatomic, weak) UILabel  *titleLabel;
@property (nonatomic, weak) UITextField  *editTextField;
@property (nonatomic, weak) UIView  *lineView;
@end

@implementation WCLoginCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"loginCell";
    WCLoginCell *loginCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (loginCell == nil) {
        loginCell = [[WCLoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return loginCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGB(238.0f, 238.0f, 238.0f);
        _lineView = lineView;
        [self.contentView addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.textColor = [UIColor grayColor];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        
        UITextField *editTextField = [[UITextField alloc] init];
        editTextField.borderStyle = UITextBorderStyleNone;
        editTextField.returnKeyType = UIReturnKeyDone;
        [editTextField addTarget:self action:@selector(editTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _editTextField = editTextField;
        [self.contentView addSubview:editTextField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat parentW = self.frame.size.width;
    
    CGFloat titleLabelX = 0.0f;
    CGFloat titleLabelY = 12.0f;
    CGFloat titleLabelW = 80.0f;
    CGFloat titleLabelH = 20.0f;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat editTextFieldX = CGRectGetMaxX(_titleLabel.frame);
    CGFloat editTextFieldY = titleLabelY;
    CGFloat editTextFieldW = parentW - editTextFieldX;
    CGFloat editTextFieldH = titleLabelH;
    self.editTextField.frame = CGRectMake(editTextFieldX, editTextFieldY, editTextFieldW, editTextFieldH);
}

- (void)setLoginDict:(NSDictionary *)loginDict {
    _loginDict = loginDict;
    
    CGFloat lineViewX = [loginDict[@"padding"] floatValue];
    self.lineView.frame = CGRectMake(lineViewX, 0, ScreenW - 2 * lineViewX, 1);
    
    self.titleLabel.text = loginDict[@"titleLabel"];
    
    self.editTextField.placeholder = loginDict[@"placeholder"];
    self.editTextField.secureTextEntry = [loginDict[@"secret"] boolValue];
    self.editTextField.text = @"";
}

- (void)editTextFieldChange:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(loginCell:didEditTextFieldChange:)]) {
        [self.delegate loginCell:self didEditTextFieldChange:textField.text];
    }
}

@end

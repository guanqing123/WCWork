//
//  WCAddCommonCell.m
//  WCWork
//
//  Created by information on 2017/10/16.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAddCommonCell.h"

@interface WCAddCommonCell()
@property (nonatomic, weak) UIImageView  *imgView;
@property (nonatomic, weak) UILabel  *label;
@property (nonatomic, weak) UIImageView  *choosedImgView;
@end

@implementation WCAddCommonCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"addCommonCell";
    WCAddCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WCAddCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView = imgView;
        [self.contentView addSubview:imgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)];
        _label = label;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        UIImageView *choosedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 40, 10, 20, 20)];
        _choosedImgView = choosedImgView;
        [self.contentView addSubview:choosedImgView];
        
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenW, 1)];
        subView.backgroundColor = cellLineColor;
        [self.contentView addSubview:subView];
    }
    return self;
}

- (void)setItem:(WCItem *)item {
    _item = item;
    
    self.imgView.image = [UIImage imageNamed:item.image];
    
    self.label.text = item.title;
}

- (void)setChoose:(BOOL)choose {
    _choose = choose;
    if (choose) {
        self.choosedImgView.image = [UIImage imageNamed:@"home_func_unselect"];
    }else{
        self.choosedImgView.image = [UIImage imageNamed:@"home_func_select"];
    }
}

@end

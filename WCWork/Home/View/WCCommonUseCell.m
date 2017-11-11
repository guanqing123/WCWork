//
//  WCCommonUseCell.m
//  WCWork
//
//  Created by information on 2017/10/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCCommonUseCell.h"

@implementation WCCommonUseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    WCCommonUseCell *commonUseCell = [[WCCommonUseCell alloc] init];
    commonUseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return commonUseCell;
}

- (void)setCommonUseArray:(NSMutableArray *)commonUseArray {
    _commonUseArray = commonUseArray;
    
    //0. 总列数
    int totalColumns = 4;
    
    //1. 功能尺寸
    CGFloat appW = ScreenW / 5 ;
    CGFloat appH = 60;
    
    //2.间隙 = (cell的宽度 - totalColumns * appW) / totalColumns + 1;
    CGFloat marginX = (ScreenW - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginY = 10;
    
    for (int index = 0; index < _commonUseArray.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY + row * (appH + marginY);
        button.frame = CGRectMake(appX, appY, appW, appH);
        
        
        WCItem  *item = [_commonUseArray objectAtIndex:index];
        UIImage *image = [UIImage imageNamed:item.image];
        [button setImage:image forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        CGFloat imageW = image.size.width;
        CGFloat edgX = (appW - imageW) * 0.5;
        CGFloat edgY = appH - image.size.height;
        //设置按钮图片的内边距
        button.imageEdgeInsets = UIEdgeInsetsMake(0, edgX, edgY, edgX);
        [button setTitle:item.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:WCThemeColor forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(image.size.height + 10, -imageW, 0, 0);
        
        [button addTarget:self action:@selector(btnItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
    }
}

- (void)btnItemClick:(UIButton *)btn {
    WCItem *item = [_commonUseArray objectAtIndex:btn.tag];
    if ([self.delegate respondsToSelector:@selector(commonUseCell:btnDidClickWithWCItem:)]) {
        [self.delegate commonUseCell:self btnDidClickWithWCItem:item];
    }
}

@end

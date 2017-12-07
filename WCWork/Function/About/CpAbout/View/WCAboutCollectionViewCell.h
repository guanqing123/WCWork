//
//  WCAboutCollectionViewCell.h
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCAboutItem;

@interface WCAboutCollectionViewCell : UICollectionViewCell

/** item 数据 */
@property (nonatomic, strong)  WCAboutItem *aboutItem;

@end

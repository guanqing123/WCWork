//
//  WCFunctionViewController.m
//  WCWork
//
//  Created by information on 2017/9/29.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCFunctionViewController.h"
#import "XLPlainFlowLayout.h"

#import "WCFunctionCell.h"
#import "ReusableView.h"

#import "WCGroup.h"

@interface WCFunctionViewController ()
@property (nonatomic, strong)  NSArray *functions;
@end

@implementation WCFunctionViewController

static NSString * const reuseIdentifier = @"functionViewControllerCell";
static NSString * const sectionHeaderIdentifier = @"functionViewControllerSectionHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[WCFunctionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Register section header classes
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeaderIdentifier];
    
    // Do any additional setup after loading the view.
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

- (instancetype)init {
    // 流水布局
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    
    // 每个cell的尺寸
    layout.itemSize = CGSizeMake((ScreenW - 50) / 4, (ScreenW - 50) / 4);
    // 设置cell之间的水平间距
    layout.minimumInteritemSpacing = 10;
    // 设置cell之间的垂直间距
    layout.minimumLineSpacing = 10;
    // 设置四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return [super initWithCollectionViewLayout:layout];
}

#pragma mark - functions
- (NSArray *)functions {
    if (!_functions) {
        // JSON文件的路径
        NSString *functionPath = [[NSBundle mainBundle] pathForResource:@"function" ofType:@"json"];
        
        // 加载JSON文件
        NSData *functionData = [NSData dataWithContentsOfFile:functionPath];
        
        // 将JSON数据转为NSArray或者NSDictionary
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:functionData options:NSJSONReadingMutableContainers error:nil];
        
        // 将字典转成模型
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *funDict in dictArray) {
            WCGroup *group = [WCGroup groupWithDict:funDict];
            [tempArray addObject:group];
        }
        _functions = tempArray;
    }
    return _functions;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.functions.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    WCGroup *group = self.functions[section];
    return group.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCFunctionCell *functionCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    WCGroup *group = self.functions[indexPath.section];
    WCItem *item = group.items[indexPath.item];
    functionCell.item = item;
    
    return functionCell;
}

// 定义并返回每个headerView或footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WCGroup *group = self.functions[indexPath.section];
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeaderIdentifier forIndexPath:indexPath];
        [headerView initText:group.header r:group.r g:group.g b:group.b];
        reusableView = headerView;
    }
    return reusableView;
}

/*
 上面这个方法使用时必须要注意的一点是，如果布局没有为headerView或footerView设置size的话(默认size为CGSizeZero)，则该方法不会被调用。所以如果需要显示header或footer，需要手动设置size。
可以通过设置UICollectionViewFlowLayout的headerReferenceSize和footerReferenceSize属性来全局控制size。或者通过重载以下代理方法来分别设置
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
 */

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 35);
}

#pragma mark <UICollectionViewDelegate>
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark -屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end

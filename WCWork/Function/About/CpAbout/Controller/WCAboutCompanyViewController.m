//
//  WCAboutViewController.m
//  WCWork
//
//  Created by information on 2017/12/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "WCAboutCompanyViewController.h"
#import "WCAboutItem.h"
#import "WCAboutCollectionViewCell.h"
#import "MJExtension.h"


@interface WCAboutCompanyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)  UICollectionView *collectionView;
@property (nonatomic, strong)  NSMutableArray<WCAboutItem *> *itemList;

@end

static NSString *const WCAboutCollectionViewCellID = @"WCAboutCollectionViewCell";

@implementation WCAboutCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[WCAboutCollectionViewCell class] forCellWithReuseIdentifier:WCAboutCollectionViewCellID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray<WCAboutItem *> *)itemList {
    if (!_itemList) {
        _itemList = [WCAboutItem mj_objectArrayWithFilename:@"ItemList.plist"];
    }
    return _itemList;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCAboutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WCAboutCollectionViewCellID forIndexPath:indexPath];
    WCAboutItem *aboutItem = self.itemList[indexPath.row];
    cell.aboutItem = aboutItem;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WCAboutItem *aboutItem = self.itemList[indexPath.row];
    if (!aboutItem.destVcClass) return;
    UIViewController *destVc = [[NSClassFromString(aboutItem.destVcClass) alloc] init];
    destVc.title = aboutItem.title;
    [self.navigationController pushViewController:destVc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenW / 3, ScreenW / 3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

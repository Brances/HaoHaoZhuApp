//
//  ZMBrowseViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBrowseViewController.h"
#import "ZMBrowseModel.h"
#import "ZMBrowseCollectionCell.h"

#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "ZMBrowseListVC.h"

#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface ZMBrowseViewController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZMBrowseViewController
{
    NSInteger page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    page = 1;
    [self setupNavView];
    [self configureUI];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.centerButton setTitle:@"看图" forState:UIControlStateNormal];
    //    [self.navView.leftButton setImage:[UIImage imageNamed:@"icon_uniform_back_b"] forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"ich_search"] forState:UIControlStateNormal];
    self.navView.isHaveLine = YES;
}

- (void)configureUI{
    //感谢 Nelson Tai   with  https://github.com/chiahsien/CHTCollectionViewWaterfallLayout
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    layout.headerHeight = 15;
    layout.footerHeight = 10;
    layout.minimumColumnSpacing = 15;
    layout.minimumInteritemSpacing = 20;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kScreenWidth, kScreenHeight - self.navView.bottom - 64) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ZMBrowseCollectionCell class] forCellWithReuseIdentifier:@"ZMBrowseCollectionCell"];
    [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:FOOTER_IDENTIFIER];
    [self.view addSubview:self.collectionView];
    @weakify(self);
    self.collectionView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
        [ZMHelpUtil openNormalShakeFeedback];
        page = 1;
        [weak_self getPhotoList];
    }];
    self.collectionView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:^{
        page ++;
        [weak_self getPhotoList];
    }];
    [self getPhotoList];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMBrowseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMBrowseCollectionCell"
                                                                                                               forIndexPath:indexPath];
    cell.model = [self.dataArray safeObjectAtIndex:indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
        reusableView.backgroundColor = [ZMColor appBgGrayColor];
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
    }
    
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.dataArray.count) {
        ZMBrowseListVC *vc = [[ZMBrowseListVC alloc] init];
        vc.dataArray = self.dataArray;
        vc.selectedIndex = indexPath.row;
        vc.page = page;
        @weakify(self);
        vc.updateBlock = ^(NSInteger pages) {
            page = pages;
            [weak_self.collectionView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    HBLog(@"点击了%ld",indexPath.row);
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMBrowseModel *model = [self.dataArray safeObjectAtIndex:indexPath.row];
    return CGSizeMake(model.photo.image.width, model.cellHeight);
//    return [self.cellSizes[indexPath.item % 4] CGSizeValue];
}

- (void)getPhotoList{
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIBrowsePhotoList withParameters:nil withSuccessBlock:^(id response) {
        if (KVerifyHttpSuccessCode(response)) {
            NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"rows"]];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            for (NSDictionary *dic in list) {
                ZMBrowseModel *model = [[ZMBrowseModel alloc] initWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            //主线程更新
            dispatch_async(dispatch_get_main_queue(), ^{
                if (page == 1) {
                    [self.collectionView.mj_header endRefreshing];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                }
                [self.collectionView reloadData];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"错误");
    }];
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

@end

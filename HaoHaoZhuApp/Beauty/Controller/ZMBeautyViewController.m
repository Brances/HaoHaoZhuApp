//
//  ZMBeautyViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBeautyViewController.h"
#import "ZMSearchView.h"
#import "TYCyclePagerView.h"
#import "ZMAdvertListModel.h"
#import "ZMBeautyTopBannerCell.h"
#import "ZMBeautyNodeCell.h"
#import "ZMSearchKeywordViewController.h"

@interface ZMBeautyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) ZMSearchView          *searchView;
//@property (nonatomic, strong) TYCyclePagerView      *pagerView;
@property (nonatomic, strong) NSArray<ZMAdvertBannerModel *> *advertArray;
@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, strong) NSArray<ZMBeautyNodeModel *> *beautyNodeArray;

@end

@implementation ZMBeautyViewController

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 100);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置CollectionView的属性
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [ZMColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollEnabled = YES;
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.collectionView registerClass:[ZMBeautyTopBannerCollectionCell class] forCellWithReuseIdentifier:@"ZMBeautyTopBannerCollectionCell"];
        [self.collectionView registerClass:[ZMBeautyNodeCell class] forCellWithReuseIdentifier:@"ZMBeautyNodeCell"];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        @weakify(self);
        self.collectionView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
            [ZMHelpUtil openNormalShakeFeedback];
            [weak_self requestGroupTask];
        }];
        self.collectionView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:nil];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self requestGroupTask];
//    [self configureUI];
}

- (void)setupNavView{
    [super setupNavView];
    self.navView.isHaveLine = YES;
    self.searchView = [[ZMSearchView alloc] initWithFrame:CGRectMake(20, self.navView.height - 34 - 5, self.navView.width - 20 * 2, 34)];
    self.searchView.enable = NO;
    self.searchView.placeHolder = @"大家都在搜：岛台";
    [self.navView addSubview:self.searchView];
    @weakify(self);
    self.searchView.didClickButtonBlock = ^(UIButton *btn) {
        HBLog(@"已经点击了按钮");
        ZMSearchKeywordViewController *vc = [[ZMSearchKeywordViewController alloc] init];
        vc.keyword = @"网红绿植";
        [weak_self.navigationController pushViewController:vc animated:NO];
    };
}


- (void)configureUI{
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat tabBarheight = [ZMHelpUtil getCurrenAppdegate].mainViewController.tabBar.height;
    self.collectionView.frame = CGRectMake(0, self.navView.bottom, kScreenWidth, kScreenHeight - tabBarheight - self.navView.height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section != 0) {
            UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            for (UIView *subView in view.subviews) {
                [subView removeFromSuperview];
            }
            view.backgroundColor = [ZMColor whiteColor];
            UILabel *nameLabel = [UILabel new];
            nameLabel.textColor = [ZMColor blackColor];
            nameLabel.font = [ZMFont boldGothamWithSize:18];
            [view addSubview:nameLabel];
            nameLabel.text = [self.beautyNodeArray objectAtIndex:indexPath.section - 1].name;
            [nameLabel sizeToFit];
            nameLabel.left = 20;
            nameLabel.top = view.height - nameLabel.height - 20;
            return view;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(kScreenWidth, 100);
}

#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    self.collectionView.mj_footer.hidden = !self.beautyNodeArray.count;
    if (self.advertArray.count) {
        return 1 + self.beautyNodeArray.count;
    }
    return self.beautyNodeArray.count;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    ZMBeautyNodeModel *model = [self.beautyNodeArray safeObjectAtIndex:section - 1];
    return model.bannerArray.count;
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!_beautyNodeArray.count){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [ZMColor clearColor];
        return cell;
    };
    if (indexPath.section == 0) {
        ZMBeautyTopBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMBeautyTopBannerCollectionCell" forIndexPath:indexPath];
        cell.advertArray = self.advertArray;
        return cell;
    }
    ZMBeautyNodeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMBeautyNodeCell" forIndexPath:indexPath];
    ZMBeautyNodeModel *model = [self.beautyNodeArray objectAtIndex:indexPath.section - 1];
    cell.model = [model.bannerArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!_beautyNodeArray.count) return CGSizeMake(0,0);
    if (indexPath.section == 0) {
        CGFloat height = 375 * kScreenWidth / 750;
        return CGSizeMake(kScreenWidth, height);
    }
    ZMBeautyNodeModel *model = [self.beautyNodeArray objectAtIndex:indexPath.section - 1];
    return  CGSizeMake(model.cellWidth,model.cellHeight);
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 15;
}

#pragma mark - 任务组
- (void)requestGroupTask{
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.全局异步队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //banner
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"type"] = @"40";
        [ZMNetWorkManager requestWithType:Post withUrlString:KAPIBeautyTopBanner withParameters:param withSuccessBlock:^(id response) {
            if (KVerifyHttpSuccessCode(response)) {
                NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"banner_list"]];
                NSMutableArray *temp = [NSMutableArray new];
                for (int i = 0; i < list.count; i++) {
                    NSDictionary *dic = [list safeObjectAtIndex:i];
                    ZMAdvertBannerModel *model = [[ZMAdvertBannerModel alloc] initWithDictionary:dic];
                    [temp addObject:model];
                }
                self.advertArray = temp;
            }
            dispatch_group_leave(group);
        } withFailureBlock:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    });
    //装修前中后期
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"type"] = @"5";
        [ZMNetWorkManager requestWithType:Post withUrlString:KAPIBeautyNodeList withParameters:param withSuccessBlock:^(id response) {
            if (KVerifyHttpSuccessCode(response)) {
                HBLog(@"ss = %@",response);
                NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"list"]];
                NSMutableArray *temp = [NSMutableArray new];
                for (int i = 0; i < list.count; i++) {
                    NSDictionary *node = [list safeObjectAtIndex:i];
                    ZMBeautyNodeModel *model = [[ZMBeautyNodeModel alloc] initWithDictionary:node];
                    [temp addObject:model];
                }
                self.beautyNodeArray = temp;
            }
            dispatch_group_leave(group);
        } withFailureBlock:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    });
    //4.队列组所有请求完成回调刷新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"请求完毕，主线程中刷新UI");
        if (self.advertArray.count) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        }
    });
}

@end

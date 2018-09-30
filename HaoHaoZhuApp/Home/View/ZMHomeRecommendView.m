//
//  ZMHomeRecommendView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHomeRecommendView.h"
#import "ZMRecommendHeadMenuCell.h"
#import "ZMHomeRecommendCell.h"
#import "ZMHouseExampleViewController.h"
//#import "AppDelegate.h"

@interface ZMHomeRecommendView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView          *collectionView;

@end

@implementation ZMHomeRecommendView
{
    CGFloat marginSpace;
    NSInteger page;
}
- (ZMHomeModel *)homeModel{
    if (!_homeModel) {
        _homeModel = [[ZMHomeModel alloc] init];
    }
    return _homeModel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        marginSpace = 15;
        page = 1;
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.backgroundColor = [ZMColor appBgGrayColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height) collectionViewLayout:flowLayout];
    CGFloat height = [ ZMHelpUtil getCurrenAppdegate].mainViewController.tabBar.height;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, -height, 0);
    self.collectionView.backgroundColor = [ZMColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.alwaysBounceVertical = YES;
    [self addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[ZMRecommendHeadMenuCell class] forCellWithReuseIdentifier:@"ZMRecommendHeadMenuCell"];
    [self.collectionView registerClass:[ZMHomeRecommendCell class] forCellWithReuseIdentifier:@"ZMHomeRecommendCell"];
    @weakify(self);
    self.collectionView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
        [ZMHelpUtil openNormalShakeFeedback];
        page = 1;
        [weak_self requestGroupTask];
    }];
    self.collectionView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:^{
        page ++;
        [weak_self loadMoreData];
    }];
    [self requestGroupTask];
}

#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    self.collectionView.mj_footer.hidden = _homeModel.recommendList.list == 0;
    NSInteger count = (_homeModel.menuList.list.count ? 1 : 0) + (_homeModel.recommendList.list.count ? 1 : 0);
    return count;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _homeModel.menuList.list.count >= 4 ? 4 : 0;
    }else{
        return _homeModel.recommendList.list.count;
    }
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!_homeModel.menuList.list.count && !_homeModel.recommendList.list.count){
        static NSString *identify = @"cell";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        cell.backgroundColor = [ZMColor clearColor];
        return cell;
    };
    if (indexPath.section == 0) {
        ZMRecommendHeadMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMRecommendHeadMenuCell" forIndexPath:indexPath];
        cell.backgroundColor = [ZMColor whiteColor];
        cell.model = [self.homeModel.menuList.list safeObjectAtIndex:indexPath.row];
        return cell;
    }
    ZMHomeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMHomeRecommendCell" forIndexPath:indexPath];
    cell.backgroundColor = [ZMColor randomColor];
    cell.model = [_homeModel.recommendList.list safeObjectAtIndex:indexPath.row];
    return cell;
}


#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && self.homeModel.menuList.list.count) {
        return  CGSizeMake((self.collectionView.width - marginSpace * 2) / 4,(self.collectionView.width - marginSpace * 2) / 4 + 70);
    }else if (indexPath.section == 1 && self.homeModel.recommendList.list.count){
        ZMRecommendModel *model = [_homeModel.recommendList.list safeObjectAtIndex:indexPath.row];
        return  CGSizeMake(kScreenWidth,model.cellHeight);
    }
    return  CGSizeMake(0,0);
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, marginSpace, 5, marginSpace);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //整屋案例
            ZMHouseExampleViewController *vc = [[ZMHouseExampleViewController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            
        }
    }else if(indexPath.section == 1){
        //点击文章详情
        HBLog(@"点击了%ld",indexPath.row);
        
    }
}

#pragma mark - 任务组
- (void)requestGroupTask{
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.全局异步队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //头部标签
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [ZMNetWorkManager requestWithType:Post withUrlString:KAPIHomeRecommendMergeHead withParameters:nil withSuccessBlock:^(id response) {
            if (KVerifyHttpSuccessCode(response)) {
//                HBLog(@"结果=%@",response);
                //找出type = 1006 的
                NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"list"]];
                for (int i = 0; i < list.count; i++) {
                    NSDictionary *dic = [list safeObjectAtIndex:i];
                    NSString *name = [ZMHelpUtil dispose:dic[@"type"]];
                    if ([name isEqualToString:@"1006"]) {
                        ZMHomeMenuListModel *model = [[ZMHomeMenuListModel alloc] initWithDictionary:dic];
                        self.homeModel.menuList = model;
                        break;
                    }
                }
            }
            dispatch_group_leave(group);
        } withFailureBlock:^(NSError *error) {
            HBLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    //列表
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"page"] = @(page);
        param[@"refresh"] = @"0";
        [ZMNetWorkManager requestWithType:Post withUrlString:KAPIHomeRecommendMergedList withParameters:param withSuccessBlock:^(id response) {
//            HBLog(@"结果=%@",response);
            if (KVerifyHttpSuccessCode(response)) {
                if (page == 1) {
                    [self.collectionView.mj_footer resetNoMoreData];
                    ZMRecommendListModel *model = [[ZMRecommendListModel alloc] initWithDictionary:response[@"data"][@"recommend"]];
                    self.homeModel.recommendList = model;
                }else{
                    NSArray *recommendArray = [ZMHelpUtil arrDispose:response[@"data"][@"recommend"][@"list"]];
                    for (NSDictionary *dic in recommendArray) {
                        ZMRecommendModel *model = [[ZMRecommendModel alloc] initWithDictionary:dic];
                        if (model.type == 1) {
                            [self.homeModel.recommendList.list addObject:model];
                        }
                    }
                }
            }
            dispatch_group_leave(group);
        } withFailureBlock:^(NSError *error) {
            HBLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    //4.队列组所有请求完成回调刷新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"请求完毕，主线程中刷新UI");
        if (page == 1) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer resetNoMoreData];
        }else{
            if (_homeModel.recommendList.is_over) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
        }
        [self.collectionView reloadData];
    });
}

#pragma mark - 加载更多
- (void)loadMoreData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    param[@"refresh"] = @"1";
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIHomeRecommendMergedList withParameters:param withSuccessBlock:^(id response) {
        if (KVerifyHttpSuccessCode(response)) {
            if (page == 1) {
                ZMRecommendListModel *model = [[ZMRecommendListModel alloc] initWithDictionary:response[@"data"][@"recommend"]];
                self.homeModel.recommendList = model;
            }else{
                NSArray *recommendArray = [ZMHelpUtil arrDispose:response[@"data"][@"recommend"][@"list"]];
                for (NSDictionary *dic in recommendArray) {
                    ZMRecommendModel *model = [[ZMRecommendModel alloc] initWithDictionary:dic];
                    if (model.type == 1) {
                        [self.homeModel.recommendList.list addObject:model];
                    }
                }
            }
            //主线程更新
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_homeModel.recommendList.list.count < 1) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                }
                [self.collectionView reloadData];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"%@",error);
    }];
}

@end

//
//  ZMSearchKeywordViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMSearchKeywordViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "ZMSearchTagCell.h"

@interface ZMSearchKeywordViewController ()<UICollectionViewDataSource, UICollectionViewDelegateLeftAlignedLayout>

@property (nonatomic, strong) ZMSearchView          *searchView;
@property (nonatomic, strong) UICollectionView          *collectionView;
@property (nonatomic, strong) NSArray<ZMSearchTagModel *> *tagArray;

@end

@implementation ZMSearchKeywordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupNavView{
    [super setupNavView];
    self.navView.isHaveLine = YES;
    [self.navView.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    self.searchView = [[ZMSearchView alloc] initWithFrame:CGRectMake(20, self.navView.height - 34 - 5, self.navView.rightButton.left - 20 - 10, 34)];
    self.searchView.enable = YES;
    [self.navView addSubview:self.searchView];
    @weakify(self);
    self.navView.rightButtonBlock = ^{
        HBLog(@"已经点击了取消按钮");
        [weak_self.view endEditing:YES];
        [weak_self.navigationController popViewControllerAnimated:NO];
    };
}

- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    [self setupNavView];
    [self configureUI];
    [self getAllTagData];
    self.searchView.placeHolder = keyword;
    //延迟弹出键盘
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchView.textField becomeFirstResponder];
    });
}

- (void)configureUI{
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kScreenWidth, kScreenHeight - self.navView.bottom) collectionViewLayout:layout];
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [ZMColor whiteColor];
    [self.collectionView registerClass:[ZMSearchTagCell class] forCellWithReuseIdentifier:@"ZMSearchTagCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        for (UIView *subView in view.subviews) {
            [subView removeFromSuperview];
        }
        view.backgroundColor = [ZMColor whiteColor];
        UILabel *nameLabel = [UILabel new];
        nameLabel.textColor = [ZMColor blackColor];
        nameLabel.font = [ZMFont defaultAppFontWithSize:18];
        [view addSubview:nameLabel];
        nameLabel.text = @"大家都在搜";
        [nameLabel sizeToFit];
        nameLabel.left = 20;
        nameLabel.top = view.height - nameLabel.height;
        return view;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 55);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (!_tagArray.count) return 0;
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tagArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.tagArray.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    ZMSearchTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMSearchTagCell" forIndexPath:indexPath];
    cell.model = [self.tagArray objectAtIndex:indexPath.row];
    cell.didClickBtnBlock = ^(ZMSearchTagModel *model) {
        HBLog(@"点击了啦");
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HBLog(@"点击了%ld",indexPath.row);
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.tagArray.count) {
        return CGSizeMake(0, 0);
    }
    ZMSearchTagModel *model = [self.tagArray safeObjectAtIndex:indexPath.row];
    return CGSizeMake(model.width, model.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

#pragma mark - 请求标签数据
- (void)getAllTagData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"1";
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPISearchAllTagList withParameters:param withSuccessBlock:^(id response) {
        HBLog(@"结果=%@",response);
        if (KVerifyHttpSuccessCode(response)) {
            NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"rows"]];
            NSMutableArray *temp = [NSMutableArray new];
            for (int i = 0; i < list.count; i++) {
                NSDictionary *dic = [list safeObjectAtIndex:i];
                ZMSearchTagModel *model = [[ZMSearchTagModel alloc] initWithDictionary:dic];
                [temp addObject:model];
            }
            self.tagArray = temp;
            //刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"%@",error);
    }];
}

@end

//
//  ZMArticleRelaRecommendCell.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/10/10.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleRelaRecommendCell.h"

@implementation ZMArticleRelaRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [ZMFont boldGothamWithSize:18];
    self.nameLabel.textColor = [ZMColor blackColor];
    [self.contentView addSubview:self.nameLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumInteritemSpacing = 30;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.backgroundColor = [ZMColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.contentView addSubview:self.collectionView];
    //注册CellZMArticleRelaRecommendCellView
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[ZMArticleRelaRecommendCellView class] forCellWithReuseIdentifier:@"ZMArticleRelaRecommendCellView"];
    
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = [ZMColor appBorderColor];
    [self.contentView addSubview:self.bottomLine];
    
}

#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return MIN(3, self.model.list.count);
    return self.model.list.count;
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.model.list.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [ZMColor whiteColor];
        return cell;
    }
    ZMArticleRelaRecommendCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMArticleRelaRecommendCellView" forIndexPath:indexPath];
    cell.model = [self.model.list objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZMArticleRelaRecommendModel *model = [self.model.list objectAtIndex:0];
    if (model) {
        return CGSizeMake(model.cellWidth, model.article_info.mainContentHeight);
    }
    return CGSizeMake(0, 0);
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (void)setModel:(ZMArticleRelaRecommendInfoModel *)model{
    _model = model;
    self.nameLabel.text = model.title;
    [self.collectionView reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel sizeToFit];
    self.nameLabel.left = 20;
    self.nameLabel.top = 30;
    ZMArticleRelaRecommendModel *model = [self.model.list objectAtIndex:0];
    self.collectionView.frame = CGRectMake(0, self.nameLabel.bottom + 15, self.width, model.article_info.mainContentHeight);
    self.bottomLine.frame = CGRectMake(20, self.height - 0.5, self.width - 20 * 2, 0.5);
}

@end

@implementation ZMArticleRelaRecommendCellView

- (UIBezierPath *)cornerRadiusPath{
    if (!_cornerRadiusPath) {
        _cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.coverImage.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
    }
    return _cornerRadiusPath;
}

- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc ] init];
        _shapeLayer.frame = self.coverImage.bounds;
        _shapeLayer.path = self.cornerRadiusPath.CGPath;
    }
    return _shapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    
    self.mainView = [UIView new];
    self.mainView.layer.cornerRadius = 5;
    self.mainView.layer.borderColor = [ZMColor colorWithHexString:@"#EAEAEA"].CGColor;
    self.mainView.layer.borderWidth = 1;
    self.mainView.backgroundColor = [ZMColor whiteColor];
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.layer.shadowOpacity = 0.9;
    self.mainView.layer.shadowColor = [ZMColor colorWithHexString:@"#F7F7F7"].CGColor;
    [self.contentView addSubview:self.mainView];
    
    self.coverImage = [ZMImageView new];
//    self.coverImage.layer.cornerRadius = 5;
//    self.coverImage.clipsToBounds = YES;
    [self.mainView addSubview:self.coverImage];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [ZMFont boldGothamWithSize:15];
    self.titleLabel.textColor = [ZMColor blackColor];
    [self.mainView addSubview:self.titleLabel];
    
    self.iconView = [ZMImageView new];
    self.iconView.size = CGSizeMake(20, 20);
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    [self.mainView addSubview:self.iconView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [ZMFont defaultAppFontWithSize:13];
    self.nameLabel.textColor = [ZMColor blackColor];
    [self.mainView addSubview:self.nameLabel];
    
    self.tagLabel = [UILabel new];
    self.tagLabel.font = [ZMFont defaultAppFontWithSize:13];
    self.tagLabel.textColor = [ZMColor appSubColor];
    [self.mainView addSubview:self.tagLabel];
    
}

- (void)setModel:(ZMArticleRelaRecommendModel *)model{
    _model = model;
    [self.coverImage setAnimationLoadingImage:[NSURL URLWithString:model.article_info.cover_pic_url] placeholder:placeholderAvatarImage];
    [self.titleLabel setText:model.article_info.title lineSpacing:0];
    [self.iconView setAnimationLoadingImage:[NSURL URLWithString:model.user_info.big_avatar] placeholder:placeholderAvatarImage];
    self.nameLabel.text = model.user_info.nick;
    self.tagLabel.text = [NSString stringWithFormat:@"%@室 %@平米",model.article_info.construction,model.article_info.house_size];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 5, self.width, self.height - 10);
    self.coverImage.frame = CGRectMake(0, 0, self.width, self.model.article_info.image.height);
    self.coverImage.layer.mask = self.shapeLayer;
    self.titleLabel.width = self.width - 30;
    self.titleLabel.height = self.model.article_info.titleHeight;
    self.titleLabel.left = 15;
    self.titleLabel.top = self.coverImage.bottom + 20;
    
    self.iconView.left = 15;
    self.iconView.top = self.titleLabel.bottom + 20;
    
    [self.tagLabel sizeToFit];
    self.tagLabel.left = self.width - self.tagLabel.width - 15;
    self.tagLabel.centerY = self.iconView.centerY;
    
    [self.nameLabel sizeToFit];
    self.nameLabel.width = self.tagLabel.left - self.iconView.right - 15;
    self.nameLabel.left = self.iconView.right + 10;
    self.nameLabel.centerY = self.iconView.centerY;
    
}

@end



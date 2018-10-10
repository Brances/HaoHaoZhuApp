//
//  ZMArticleRelaRecommendCell.h
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/10/10.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMArticleRelaRecommendModel.h"
@class ZMArticleRelaRecommendCellView;
@interface ZMArticleRelaRecommendCell : YYTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UIImageView   *icon;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UICollectionView                               *collectionView;
@property (nonatomic, strong) ZMArticleRelaRecommendInfoModel *model;


@end


@interface ZMArticleRelaRecommendCellView : UICollectionViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) ZMImageView *coverImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZMImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) ZMArticleRelaRecommendModel *model;
@property (nonatomic, strong) CAShapeLayer              *shapeLayer;
@property (nonatomic, strong) UIBezierPath                  *cornerRadiusPath;
@end


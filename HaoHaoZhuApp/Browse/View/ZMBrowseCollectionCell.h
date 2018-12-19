//
//  ZMBrowseCollectionCell.h
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/12/19.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMBrowseModel.h"

@interface ZMBrowseCollectionCell : UICollectionViewCell

@property (nonatomic, strong) ZMImageView       *imageView;
@property (nonatomic, strong) UILabel               *descLabel;
@property (nonatomic, strong) UILabel               *nameLabel;
@property (nonatomic, strong) ZMImageView              *iconView;
@property (nonatomic, strong) UILabel               *countLabel;
@property (nonatomic, strong) UIImageView       *favoriteView;
@property (nonatomic, strong) ZMBrowseModel   *model;

@end

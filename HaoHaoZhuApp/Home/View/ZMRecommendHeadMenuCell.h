//
//  ZMRecommendHeadMenuCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMHomeMenuListModel.h"

@interface ZMRecommendHeadMenuCell : UICollectionViewCell

@property (nonatomic, strong) ZMImageView   *iconView;
@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UIView            *bottomLine;
@property (nonatomic, strong) ZMHomeMenuModel *model;


@end

//
//  ZMArticleDetailPhotoContentCell.h
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/10/7.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMArticleDetailModel.h"
@interface ZMArticleDetailPhotoContentCell : YYTableViewCell

@property (nonatomic, strong) ZMImageView *coverImg;
@property (nonatomic, strong) UILabel           *remarkLabel;
@property (nonatomic, strong) ZMArticlePhotoContentInfoModel *model;

@end

//
//  ZMArticleUserProfileCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "YYTableViewCell.h"

@interface ZMArticleUserProfileCell : YYTableViewCell

@property (nonatomic, strong) ZMImageView *iconView;
@property (nonatomic, strong) UILabel          *nameLabel;
@property (nonatomic, strong) UILabel          *remarkLabel;
@property (nonatomic, strong) UIButton        *followBtn;
@property (nonatomic, strong) ZMUser          *model;
@property (nonatomic, strong) UIView            *topLine;
@property (nonatomic, strong) UIView            *bottomLine;

@end

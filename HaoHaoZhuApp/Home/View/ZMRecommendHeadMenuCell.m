//
//  ZMRecommendHeadMenuCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMRecommendHeadMenuCell.h"

@implementation ZMRecommendHeadMenuCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.iconView = [ZMImageView new];
    self.iconView.width = self.width - 18 * 2;
    self.iconView.height = self.iconView.width;
    self.iconView.left = (self.width - self.iconView.width) * 0.5;
    self.iconView.top = 30;
    [self.contentView addSubview:self.iconView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.width = self.width;
    self.nameLabel.height = 20;
    self.nameLabel.top = self.iconView.bottom + 10;
    self.nameLabel.textColor = [ZMColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.nameLabel];
    
    self.bottomLine = [UIView new];
    self.bottomLine.width = self.width;
    self.bottomLine.height = 0.5;
    self.bottomLine.top = self.height - self.bottomLine.height - 20;
    self.bottomLine.backgroundColor = [ZMColor colorWithHexString:@"#F5F5F5"];
    [self.contentView addSubview:self.bottomLine];
}

- (void)setModel:(ZMHomeMenuModel *)model{
    _model = model;
//    [self.iconView setImageWithURL:[NSURL URLWithString:model.pic_url] placeholder:[YYImage imageWithColor:[ZMColor randomColor]]];
    [self.iconView setAnimationLoadingImage:[NSURL URLWithString:model.pic_url] placeholder:placeholderAvatarImage];
    self.nameLabel.text = model.title;
}

@end

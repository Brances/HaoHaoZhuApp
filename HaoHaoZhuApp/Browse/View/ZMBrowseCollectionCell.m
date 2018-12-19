//
//  ZMBrowseCollectionCell.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/12/19.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBrowseCollectionCell.h"

@implementation ZMBrowseCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.imageView = [ZMImageView new];
//    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:self.imageView];
    
    self.descLabel = [UILabel new];
    self.descLabel.hidden = YES;
    self.descLabel.numberOfLines = 2;
    self.descLabel.font = [ZMFont defaultAppFontWithSize:12];
    self.descLabel.textColor = [ZMColor blackColor];
    [self.contentView addSubview:self.descLabel];

    self.iconView = [ZMImageView new];
    self.iconView.size = CGSizeMake(20, 20);
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    [self.contentView addSubview:self.iconView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [ZMFont defaultAppFontWithSize:12];
    self.nameLabel.textColor = [ZMColor appSubColor];
    [self.contentView addSubview:self.nameLabel];
    
    self.countLabel = [UILabel new];
    self.countLabel.font = [ZMFont defaultAppFontWithSize:12];
    self.countLabel.textColor = [ZMColor appSubColor];
    [self.contentView addSubview:self.countLabel];
    
    self.favoriteView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collect_water"]];
//    self.favoriteView.image = [UIImage imageNamed:@"collect_water~iphone"];
    [self.contentView addSubview:self.favoriteView];
    
}

- (void)setModel:(ZMBrowseModel *)model{
    _model = model;
//    [self.imageView setImageWithURL:[NSURL URLWithString:model.photo.o_500_url] placeholder:placeholderAvatarImage];
    [self.imageView setAnimationLoadingImage:[NSURL URLWithString:model.photo.o_500_url] placeholder:placeholderAvatarImage];
    if (model.photo.remark.length) {
        self.descLabel.hidden = NO;
        [self.descLabel setText:model.photo.remark lineSpacing:3];
    }else{
        self.descLabel.hidden = YES;
    }
    [self.iconView setAnimationLoadingImage:[NSURL URLWithString:model.user_info.avatar] placeholder:placeholderAvatarImage];
    self.nameLabel.text = model.user_info.nick;
    self.countLabel.text = model.counter.favorite;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.width, self.model.photo.image.height);
    if (self.model.photo.remark.length) {
        self.descLabel.width = self.model.photo.image.width;
        self.descLabel.height = self.model.remarkHeight;
        self.descLabel.left = 0;
        self.descLabel.top = self.imageView.bottom + 5;

        self.iconView.top = self.descLabel.bottom + 5;

    }else{
        self.iconView.top = self.imageView.bottom + 10;
    }
    self.iconView.left = 0;
    
    [self.countLabel sizeToFit];
    self.countLabel.left = self.width - self.countLabel.width;
    self.countLabel.centerY = self.iconView.centerY;
    
    self.favoriteView.left = self.countLabel.left - self.favoriteView.width - 5;
    self.favoriteView.centerY = self.iconView.centerY;
    
    [self.nameLabel sizeToFit];
    self.nameLabel.width = self.favoriteView.left - self.iconView.right - 10;
    self.nameLabel.left = self.iconView.right + 5;
    self.nameLabel.centerY = self.iconView.centerY;
    
}


@end

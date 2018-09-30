//
//  ZMBeautyNodeCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBeautyNodeCell.h"

@implementation ZMBeautyNodeCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.bannerView = [[ZMImageView alloc] init];
    self.bannerView.frame = CGRectMake(0, 0, self.width, self.height);
    self.bannerView.clipsToBounds = YES;
    self.bannerView.layer.cornerRadius = 3;
    [self.contentView addSubview:self.bannerView];
    
}

- (void)setModel:(ZMAdvertBannerModel *)model{
    _model = model;
    [self.bannerView setAnimationLoadingImage:[NSURL URLWithString:model.banner] placeholder:placeholderAvatarImage];
//    [self.bannerView sd_setImageWithURL:[NSURL URLWithString:model.banner] placeholderImage:placeholderAvatarImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end

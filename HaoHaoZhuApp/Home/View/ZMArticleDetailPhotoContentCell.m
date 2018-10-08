//
//  ZMArticleDetailPhotoContentCell.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/10/7.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleDetailPhotoContentCell.h"

@implementation ZMArticleDetailPhotoContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}


- (void)configureUI{
    
    self.coverImg = [ZMImageView new];
    [self.contentView addSubview:self.coverImg];
    
    self.remarkLabel = [UILabel new];
    self.remarkLabel.numberOfLines = 0;
    self.remarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.remarkLabel.font = [ZMFont defaultAppFontWithSize:15];
    self.remarkLabel.textColor = [ZMColor blackColor];
    [self.contentView addSubview:self.remarkLabel];
    
}

- (void)setModel:(ZMArticlePhotoContentInfoModel *)model{
    _model = model;
//    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:model.ori_pic_url] placeholderImage:placeholderAvatarImage];
    [self.coverImg setAnimationLoadingImage:[NSURL URLWithString:model.ori_pic_url] placeholder:placeholderAvatarImage];
    [self.remarkLabel setText:model.remark lineSpacing:10];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverImg.width = self.model.image.width;
    self.coverImg.height = self.model.image.height;
    self.coverImg.left = 20;
    self.coverImg.top = 0;
    
    self.remarkLabel.width = kScreenWidth - 20 * 2;
    self.remarkLabel.height = self.model.remarkHeight;
    self.remarkLabel.left = 20;
    self.remarkLabel.top = self.coverImg.bottom + 10;
    
}

@end

//
//  ZMHouseExampleCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/29.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHouseExampleCell.h"

@implementation ZMHouseExampleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    
    self.mainView = [UIView new];
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 3;
    self.mainView.layer.borderWidth = 0.5;
    self.mainView.layer.borderColor = [ZMColor appBorderColor].CGColor;
    [self.contentView addSubview:self.mainView];
    
    self.coverView = [ZMImageView new];
    [self.mainView addSubview:self.coverView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.textColor = [ZMColor blackColor];
    self.nameLabel.font = [ZMFont boldGothamWithSize:15];
    [self.mainView addSubview:self.nameLabel];
    
    self.tagLabel = [UILabel new];
    self.tagLabel.textColor = [ZMColor colorWithHexString:@"#989898"];
    self.tagLabel.font = [ZMFont defaultAppFontWithSize:12];
    [self.mainView addSubview:self.tagLabel];
    
    
}

- (void)setModel:(ZMHouseExampleModel *)model{
    _model = model;
//    [self.coverView setImageWithURL:[NSURL URLWithString:model.article_info.cover_pic_url] placeholder:placehoderRectangleImage];
    [self.coverView setAnimationLoadingImage:[NSURL URLWithString:model.article_info.cover_pic_url] placeholder:placeholderAvatarImage];
//    [self.coverView sd_setImageWithURL:[NSURL URLWithString:model.article_info.cover_pic_url] placeholderImage:placehoderRectangleImage];
    self.nameLabel.text = model.article_info.title;
    self.tagLabel.text = model.article_info.tag;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.width = kScreenWidth - 20 * 2;
    self.mainView.height = self.model.cellHeight - self.model.cellBottom;
    self.mainView.left = 20;
    self.mainView.top = 0;
    
//    self.mainView.layer.borderWidth = 0.5;
//    self.mainView.layer.borderColor = [ZMColor appBorderColor].CGColor;
    
    self.coverView.width = self.model.article_info.image.width;
    self.coverView.height = self.model.article_info.image.height;
    self.coverView.top = 0;
    self.coverView.left = 0;
    
    self.nameLabel.width = self.mainView.width - 20 * 2;
    self.nameLabel.height = self.model.article_info.titleHeight;
    self.nameLabel.left = 20;
    self.nameLabel.top = self.coverView.bottom + self.model.article_info.titleMarginTop;
    
    self.tagLabel.width = self.mainView.width - 20 * 2;
    self.tagLabel.height = self.model.article_info.tagHeight;
    self.tagLabel.left = 20;
    self.tagLabel.top = self.nameLabel.bottom + self.model.article_info.titleMarginBottom;
    
}

@end

//
//  ZMArticleUserProfileCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleUserProfileCell.h"

@implementation ZMArticleUserProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.topLine = [UIView new];
    self.topLine.backgroundColor = [ZMColor appBorderColor];
    [self.contentView addSubview:self.topLine];
    
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = [ZMColor appBorderColor];
    [self.contentView addSubview:self.bottomLine];
    
    self.iconView = [ZMImageView new];
    self.iconView.size = CGSizeMake(45, 45);
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    self.iconView.layer.borderWidth = 0.5;
    self.iconView.layer.borderColor = [ZMColor appBorderColor].CGColor;
    [self.contentView addSubview:self.iconView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = [ZMColor blackColor];
    self.nameLabel.font = [ZMFont boldGothamWithSize:15];
    [self.contentView addSubview:self.nameLabel];
    
    self.remarkLabel = [UILabel new];
    self.remarkLabel.textColor = [ZMColor blackColor];
    self.remarkLabel.font = [ZMFont defaultAppFontWithSize:15];
    [self addSubview:self.remarkLabel];
    
    self.followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.followBtn.titleLabel.font = [ZMFont boldGothamWithSize:15];
    self.followBtn.layer.masksToBounds = YES;
    self.followBtn.layer.cornerRadius = 20;
    [self.followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.followBtn setTitleColor:[ZMColor appMainThemeColor] forState:UIControlStateNormal];
    self.followBtn.backgroundColor = [ZMColor colorWithHexString:@"F3FAFA"];
    [self.contentView addSubview:self.followBtn];
}

- (void)setModel:(ZMUser *)model{
    _model = model;
    [self.iconView setAnimationLoadingImage:[NSURL URLWithString:model.big_avatar] placeholder:placeholderAvatarImage];
    self.nameLabel.text = model.nick;
    self.remarkLabel.text = model.profile;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.left = 20;
    self.iconView.top = (self.height - self.iconView.height) * 0.5;
    
    self.followBtn.width = 80;
    self.followBtn.height = 35;
    self.followBtn.left = self.width - self.followBtn.width - 20;
    self.followBtn.top = (self.height - self.followBtn.height) * 0.5;
    
    [self.nameLabel sizeToFit];
    self.nameLabel.width = self.followBtn.left - self.iconView.right - 20 * 2;
    self.nameLabel.left = self.iconView.right + 20;
    self.nameLabel.top = self.iconView.top;
    
    [self.remarkLabel sizeToFit];
    self.remarkLabel.width = self.nameLabel.width;
    self.remarkLabel.left = self.iconView.right + 20;
    self.remarkLabel.top = self.nameLabel.bottom + 2;
    
    self.topLine.frame = CGRectMake(0, 0, self.width, 0.5);
    self.bottomLine.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
    
}

@end

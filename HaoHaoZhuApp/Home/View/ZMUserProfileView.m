//
//  ZMUserProfileView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMUserProfileView.h"

@implementation ZMUserProfileView

- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 75;
    }
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.backgroundColor = [ZMColor whiteColor];
    self.iconView = [ZMImageView new];
    self.iconView.size = CGSizeMake(45, 45);
    self.iconView.left = 20;
    self.iconView.centerY = self.centerY;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    self.iconView.layer.borderWidth = 0.5;
    self.iconView.layer.borderColor = [ZMColor colorWithHexString:@"#F0F0F0"].CGColor;
    [self addSubview:self.iconView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = [ZMColor blackColor];
    self.nameLabel.font = [ZMFont boldGothamWithSize:15];
    [self addSubview:self.nameLabel];
    
}

- (void)setUser:(ZMUser *)user{
    _user = user;
    [self.iconView setAnimationLoadingImage:[NSURL URLWithString:user.big_avatar] placeholder:placeholderAvatarImage];
    self.nameLabel.text = user.nick;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel sizeToFit];
    self.nameLabel.left = self.iconView.right + 20;
    self.nameLabel.centerY = self.centerY;
    
}

@end

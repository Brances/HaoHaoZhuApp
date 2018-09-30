//
//  ZMRecommendContentView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMRecommendContentView.h"

@implementation ZMRecommendContentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.coverView = [ZMImageView new];
    [self addSubview:self.coverView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [ZMFont boldGothamWithSize:15];
    self.titleLabel.textColor = [ZMColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.tagLabel = [UILabel new];
    self.tagLabel.textColor = [ZMColor colorWithHexString:@"#989898"];
    self.tagLabel.font = [ZMFont defaultAppFontWithSize:12];
    [self addSubview:self.tagLabel];
    
    self.remarkLabel = [UILabel new];
    self.remarkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.remarkLabel.numberOfLines = 4;
    self.remarkLabel.font = [ZMFont defaultAppFontWithSize:15];
    self.remarkLabel.textColor = [ZMColor blackColor];
    [self addSubview:self.remarkLabel];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn.titleLabel.font = [ZMFont defaultAppFontWithSize:15];
    [self.moreBtn setTitle:@"查看全文" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[ZMColor appMainThemeColor] forState:UIControlStateNormal];
    [self addSubview:self.moreBtn];
    
}

- (void)setModel:(ZMArticleModel *)model{
    _model = model;
    [self.coverView setAnimationLoadingImage:[NSURL URLWithString:model.cover_pic_url] placeholder:placeholderAvatarImage];
    self.titleLabel.text = model.title;
    self.tagLabel.text = model.tag;
    [self.remarkLabel setText:model.remark lineSpacing:10];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.coverView.size = CGSizeMake(kScreenWidth, self.model.image.height);
    self.coverView.left = 0;
    self.coverView.top = 0;
    
    self.titleLabel.width = kScreenWidth - KRecommendMarginLeftSpace * 2;
    self.titleLabel.height = self.model.titleHeight;
    self.titleLabel.left = KRecommendMarginLeftSpace;
    self.titleLabel.top = self.coverView.bottom + self.model.titleMarginTop;
    
    self.tagLabel.width = kScreenWidth - 20 * 2;
    self.tagLabel.height = self.model.tagHeight;
    self.tagLabel.left = KRecommendMarginLeftSpace;
    self.tagLabel.top = self.titleLabel.bottom + self.model.titleMarginBottom;
    
    self.remarkLabel.width = kScreenWidth - 20 * 2;
    self.remarkLabel.height = self.model.remarkHeight;
    self.remarkLabel.left = KRecommendMarginLeftSpace;
    self.remarkLabel.top = self.tagLabel.bottom + self.model.remarkMarginTop;
    
    self.moreBtn.width = self.model.moreWidth;
    self.moreBtn.height = self.model.moreHeight;
    self.moreBtn.left = KRecommendMarginLeftSpace;
    self.moreBtn.top = self.remarkLabel.bottom + self.model.remarkMarginBottom;
}

@end

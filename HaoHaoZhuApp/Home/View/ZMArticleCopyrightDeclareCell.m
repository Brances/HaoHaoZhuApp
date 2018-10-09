//
//  ZMArticleCopyrightDeclareCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleCopyrightDeclareCell.h"

@implementation ZMArticleCopyrightDeclareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.nameLabel = [UILabel new];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.textColor = [ZMColor appSubColor];
    self.nameLabel.font = [ZMFont defaultAppFontWithSize:12];
    [self.contentView addSubview:self.nameLabel];
    
}

- (void)setModel:(ZMArticleDetailModel *)model{
    _model = model;
    [self.nameLabel setText:model.article_info.head_info.declareContent lineSpacing:5];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.width = kScreenWidth - 20 * 2;
    self.nameLabel.height = self.model.article_info.head_info.declareHeight;
    self.nameLabel.left = 20;
    self.nameLabel.top = (self.height - self.model.article_info.head_info.declareHeight) * 0.5;
    
}

@end

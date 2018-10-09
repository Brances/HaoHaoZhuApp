//
//  ZMArticleCommentCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleCommentCell.h"

@implementation ZMArticleCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [ZMFont defaultAppFontWithSize:14];
    self.contentLabel.textColor = [ZMColor appSubColor];
    [self.contentView addSubview:self.contentLabel];
    
}

- (void)setModel:(ZMArticleCommentInfoModel *)model{
    _model = model;
    [self.contentLabel setText:model.content lineSpacing:5];
    [self.contentLabel setCommentText:model.content lineSpacing:5 beginColorRange:NSMakeRange(0, model.title.length)];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentLabel.width = kScreenWidth - 20 * 2;
    self.contentLabel.height = self.model.contentHeight;
    self.contentLabel.left = 20;
    self.contentLabel.top = 5;
}

@end

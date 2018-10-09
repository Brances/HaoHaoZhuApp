//
//  ZMArticleQuestionAskCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleQuestionAskCell.h"

@implementation ZMArticleQuestionAskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}


- (void)configureUI{
    
    self.mainView = [UIView new];
    self.mainView.layer.cornerRadius = 5;
    self.mainView.layer.borderColor = [ZMColor colorWithHexString:@"#EDEDED"].CGColor;
    self.mainView.layer.borderWidth = 0.5;
    self.mainView.backgroundColor = [ZMColor whiteColor];
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.layer.shadowOpacity = 0.3;
    self.mainView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:self.mainView];
    
    self.leftLineView = [UIView new];
    self.leftLineView.backgroundColor = [ZMColor appMainThemeColor];
    [self.mainView addSubview:self.leftLineView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.numberOfLines = 0;
//    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.nameLabel.textColor = [ZMColor blackColor];
    self.nameLabel.font = [ZMFont boldGothamWithSize:18];
    [self.mainView addSubview:self.nameLabel];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [ZMColor blackColor];
    self.contentLabel.font = [ZMFont defaultAppFontWithSize:15];
    [self.mainView addSubview:self.contentLabel];
    
}

- (void)setModel:(ZMArticleQuestionAskModel *)model{
    _model = model;
    [self.nameLabel setText:model.title lineSpacing:5];
    [self.contentLabel setText:model.text lineSpacing:5];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.width = kScreenWidth - 20 * 2;
    self.mainView.height = self.height - 10;
    self.mainView.left = 20;
    self.mainView.top = 5;
    
    self.leftLineView.size = CGSizeMake(3, 20);
    self.leftLineView.left = 20;
    self.leftLineView.top = 22;
    
    self.nameLabel.width = self.mainView.width - 20 * 2 - 10;
    self.nameLabel.height = self.model.titleHeight;
    self.nameLabel.left = self.leftLineView.right + 6;
    self.nameLabel.top = 20;
    
    self.contentLabel.width = self.nameLabel.width;
    self.contentLabel.height = self.model.contentHeight;
    self.contentLabel.left = self.nameLabel.left;
    self.contentLabel.top = self.nameLabel.bottom + 5;
    
}

@end

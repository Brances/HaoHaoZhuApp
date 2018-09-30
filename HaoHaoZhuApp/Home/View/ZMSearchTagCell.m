//
//  ZMSearchTagCell.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMSearchTagCell.h"

@implementation ZMSearchTagCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tagButton.clipsToBounds = YES;
    self.tagButton.layer.cornerRadius = 3;
    self.tagButton.titleLabel.font = [ZMFont defaultAppFontWithSize:12];
    [self.tagButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
    self.tagButton.backgroundColor = [ZMColor appBgGrayColor];
    [self.contentView addSubview:self.tagButton];
    [self.tagButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 点击标签
- (void)clickButton:(UIButton *)btn{
    if (self.didClickBtnBlock) {
        self.didClickBtnBlock(self.model);
    }
}

- (void)setModel:(ZMSearchTagModel *)model{
    _model = model;
    [self.tagButton setTitle:model.name forState:UIControlStateNormal];
    if (model.shouldClick) {
        [self.tagButton setTitleColor:[ZMColor appMainThemeColor] forState:UIControlStateNormal];
        self.tagButton.backgroundColor = [ZMColor colorWithHexString:@"#28B4B5" alpha:0.1];
    }else{
        [self.tagButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        self.tagButton.backgroundColor = [ZMColor appBgGrayColor];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tagButton.width = self.model.width;
    self.tagButton.height = self.model.height;
    self.tagButton.left = 0;
    self.tagButton.top = 0;
}

@end

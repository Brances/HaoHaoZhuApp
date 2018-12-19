//
//  ZMPopCommentCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/17.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMPopCommentCell.h"

@implementation ZMPopCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self configureUI];
    }
    return self;
}


- (void)configureUI{
    self.iconView = [ZMImageView new];
    self.iconView.clipsToBounds = YES;
    self.iconView.size = CGSizeMake(30, 30);
    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    [self.contentView addSubview:self.iconView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [ZMColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.nameLabel];
    
    self.authorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ich_comment_wz"]];
    self.authorView.hidden = YES;
    [self.contentView addSubview:self.authorView];
    
//    self.likeBtn = [[ZMOperationButton alloc] initWithFrame:CGRectZero icon:@"ich_nice_n" type:3] ;
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:[UIImage imageNamed:@"ich_nice_n"] forState:UIControlStateNormal];
//    self.likeBtn.tag = 3;
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn addTarget:self action:@selector(clickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.createTimeLabel = [UILabel new];
    self.createTimeLabel.textColor = [ZMColor appSubColor];
    self.createTimeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.createTimeLabel];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [ZMFont defaultAppFontWithSize:14];
    self.contentLabel.textColor = [ZMColor blackColor];
    [self.contentView addSubview:self.contentLabel];
    
    self.separateLine = [UIView new];
    self.separateLine.hidden = YES;
    self.separateLine.backgroundColor = [ZMColor appSubColor];
    [self.contentView addSubview:self.separateLine];
    
    self.replayContentLabel = [UILabel new];
    self.replayContentLabel.hidden = YES;
    self.replayContentLabel.numberOfLines = 0;
    self.replayContentLabel.font = [ZMFont defaultAppFontWithSize:14];
    self.replayContentLabel.textColor = [ZMColor appSubColor];
    [self.contentView addSubview:self.replayContentLabel];
    
}

#pragma mark - 点击赞
- (void)clickOperationButton:(UIButton *)btn{
    
}

- (void)setModel:(ZMPopCommentInfoModel *)model{
    _model = model;
//    [self.iconView setImageWithURL:[NSURL URLWithString:model.user_info.avatar] placeholder:[UIImage imageNamed:@""]];
    [self.iconView setAnimationLoadingImage:[NSURL URLWithString:model.user_info.avatar] placeholder:placeholderAvatarImage];
    self.nameLabel.text = model.user_info.nick;
    self.authorView.hidden = !model.isAuthor;
    self.createTimeLabel.text = model.comment.createTimeTip;
    [self.contentLabel setText:model.content lineSpacing:5];

    self.replayContentLabel.hidden = !model.replay_info;
    self.separateLine.hidden = !model.replay_info;
    if (model.replayContent.length) {
        self.replayContentLabel.text = model.replayContent;
    }else{
        self.replayContentLabel.text = @"";
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [ZMColor whiteColor];
    self.iconView.top = 20;
    self.iconView.left = 20;
    
    [self.nameLabel sizeToFit];
    self.nameLabel.left = self.iconView.right + 10;
    self.nameLabel.top = self.iconView.top;
    
    self.authorView.left = self.nameLabel.right + 5;
    self.authorView.top = self.nameLabel.top + 2;
    
    //计算大小
    self.likeBtn.width = 40;
    self.likeBtn.height = 40;
    self.likeBtn.left = self.width - self.likeBtn.width - 10;
    self.likeBtn.centerY = self.iconView.centerY;
    
    [self.createTimeLabel sizeToFit];
    self.createTimeLabel.left = self.iconView.right + 10;
    self.createTimeLabel.top = self.nameLabel.bottom + 5;
    
    if (self.model.replay_info) {
        self.replayContentLabel.width = self.width - 60 - 20 - 13;
        self.replayContentLabel.height = self.model.replayContentHeight;
        self.replayContentLabel.left = self.iconView.right + 10 + 10;
        self.replayContentLabel.top = self.iconView.bottom + 10;
        
        self.separateLine.width = 3;
        self.separateLine.height = self.model.replayContentHeight - 10;
        self.separateLine.left = self.iconView.right + 10;
        self.separateLine.centerY = self.replayContentLabel.centerY;
        self.contentLabel.top = self.replayContentLabel.bottom + 10;
    }else{
        self.contentLabel.top = self.iconView.bottom + 10;
    }
    self.contentLabel.width = self.width - 60 - 20;
    self.contentLabel.height = self.model.contentHeight;
    self.contentLabel.left = self.iconView.right + 10;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    UIColor *backgroundColor = [ZMColor whiteColor];
    if (selected) {
        backgroundColor = [ZMColor appBgGrayColor];
        self.backgroundColor = backgroundColor;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = backgroundColor;
        } completion:^(BOOL finished) {
            [self setNeedsLayout];
        }];
        
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    UIColor *backgroundColor = [ZMColor whiteColor];
    if (highlighted) {
        backgroundColor = [ZMColor appBgGrayColor];
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = backgroundColor;
    }];
    
}


@end

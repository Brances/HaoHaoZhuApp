//
//  ZMPopCommentCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/17.
//  Copyright © 2018年 Brances. All rights reserved.
//  弹出评论列表cell

#import <UIKit/UIKit.h>
#import "ZMPopCommentInfoModel.h"
#import "ZMOperationView.h"

@interface ZMPopCommentCell : YYTableViewCell

@property (nonatomic, strong) ZMImageView *iconView;
@property (nonatomic, strong) UILabel          *nameLabel;
@property (nonatomic, strong) UIImageView   *authorView;
@property (nonatomic, strong) UIButton         *likeBtn;
@property (nonatomic, strong) UILabel           *createTimeLabel;
@property (nonatomic, strong) UILabel           *contentLabel;
@property (nonatomic, strong) ZMPopCommentInfoModel *model;

@property (nonatomic, strong) UILabel       *replayContentLabel;
@property (nonatomic, strong) UIView        *separateLine;

@end


//
//  ZMArticleQuestionAskCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//  问答

#import "YYTableViewCell.h"
#import "ZMArticleDetailModel.h"

@interface ZMArticleQuestionAskCell : YYTableViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) ZMArticleQuestionAskModel *model;

@end

//
//  ZMArticleCommentCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMArticleCommentInfoModel.h"

@interface ZMArticleCommentCell : YYTableViewCell

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) ZMArticleCommentInfoModel *model;

@end

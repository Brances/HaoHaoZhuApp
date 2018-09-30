//
//  ZMCounter.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//  分享评论收藏点赞

#import "ZMBaseModel.h"

@interface ZMCounter : ZMBaseModel

/** 图标与文字的公共间距 */
@property (nonatomic, assign) CGFloat marginSpace;
@property (nonatomic, assign) CGFloat marginLeft;

@property (nonatomic, copy) NSString *comment;
@property (nonatomic, strong) UIImage *commentIcon;
@property (nonatomic, copy) NSString *commentUrl;
@property (nonatomic, assign) CGFloat commentW;
@property (nonatomic, assign) CGFloat commentX;

@property (nonatomic, copy) NSString *like;
@property (nonatomic, strong) UIImage *likeIcon;
@property (nonatomic, copy) NSString *likeUrl;
@property (nonatomic, assign) CGFloat likeW;
@property (nonatomic, assign) CGFloat likeX;

@property (nonatomic, copy) NSString *favorite;
@property (nonatomic, strong) UIImage *favoriteIcon;
@property (nonatomic, copy) NSString *favoriteUrl;
@property (nonatomic, assign) CGFloat favoriteW;
@property (nonatomic, assign) CGFloat favoriteX;

@property (nonatomic, copy) NSString *share;
@property (nonatomic, copy) NSString *read;

/** 底部分享视图等的高度 */
@property (nonatomic, assign) CGFloat         operationTotalHeight;
@property (nonatomic, assign) CGFloat         operationHeight;
@property (nonatomic, assign) CGFloat         operationTop;
@property (nonatomic, assign) CGFloat         operationBottom;


@end

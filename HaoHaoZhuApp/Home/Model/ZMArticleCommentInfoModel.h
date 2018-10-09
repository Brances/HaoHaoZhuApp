//
//  ZMArticleCommentInfoModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
@class ZMArticleCommentModel,ZMArticleReplayModel;
@interface ZMArticleCommentInfoModel : ZMBaseModel

@property (nonatomic, strong) ZMUser                             *user_info;
@property (nonatomic, strong) ZMArticleCommentModel   *comment;
@property (nonatomic, strong) ZMArticleReplayModel       *replay_info;
/** 左边回复人 */
@property (nonatomic, copy) NSString    *title;
/** 整个内容（包括回复人标题） */
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) CGFloat  contentHeight;
@property (nonatomic, assign) CGFloat  cellHeight;

@end

/** 评论 */
@interface ZMArticleCommentModel : ZMBaseModel

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *parentid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) long long addtime;
@property (nonatomic, copy) NSString *like_num;
@property (nonatomic, assign) BOOL  is_owner;
@property (nonatomic, assign) BOOL  is_like;

@end

/** 被评论人信息 */
@interface ZMArticleReplayModel : ZMBaseModel

@property (nonatomic, strong) ZMUser *user_info;
@property (nonatomic, strong) ZMArticleCommentModel *comment;

@end

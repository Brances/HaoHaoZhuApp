//
//  ZMPopCommentInfoModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/17.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMArticleCommentInfoModel.h"

@interface ZMPopCommentInfoModel : ZMBaseModel

@property (nonatomic, strong) ZMUser                             *user_info;
@property (nonatomic, strong) ZMArticleCommentModel   *comment;
@property (nonatomic, strong) ZMArticleReplayModel       *replay_info;
@property (nonatomic, assign) BOOL          isAuthor;  //评论人是否是作者

/** 整个内容（包括回复人标题） */
@property (nonatomic, copy) NSString    *content;
@property (nonatomic, assign) CGFloat   userInfoHeight; //用户头像、昵称、评论时间高度
@property (nonatomic, assign) CGFloat   contentHeight;
@property (nonatomic, assign) CGFloat   cellHeight;
/** 回复内容，包括左边昵称 */
@property (nonatomic, copy) NSString    *replayContent;
@property (nonatomic, assign) CGFloat   replayContentHeight;
@end

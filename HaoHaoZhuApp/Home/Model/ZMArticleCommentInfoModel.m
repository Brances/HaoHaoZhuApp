//
//  ZMArticleCommentInfoModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleCommentInfoModel.h"

@implementation ZMArticleCommentInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.user_info = [[ZMUser alloc] initWithDictionary:dict[@"user_info"]];
        self.comment = [[ZMArticleCommentModel alloc] initWithDictionary:dict[@"comment"]];
        if (dict[@"replay_info"]) {
            self.replay_info = [[ZMArticleReplayModel alloc] initWithDictionary:dict[@"replay_info"]];
        }
        
        //标题
        if (self.replay_info && [self.comment.parentid isEqualToString:self.replay_info.comment.cid]) {
            self.title = [NSString stringWithFormat:@"%@ 回复 %@：",self.user_info.nick,self.replay_info.user_info.nick];
        }else{
            self.title = [NSString stringWithFormat:@"%@：",self.user_info.nick];
        }
        //整个评论内容
        self.content = [NSString stringWithFormat:@"%@%@",self.title,self.comment.content];
        //高度
        self.contentHeight = [UILabel text:self.content heightWithFontSize:14 width:kScreenWidth - 20 * 2 lineSpacing:5];
        self.cellHeight = 5 + self.contentHeight + 5;
        
    }
    return self;
}

- (instancetype)initPopCommentWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.user_info = [[ZMUser alloc] initWithDictionary:dict[@"user_info"]];
        self.comment = [[ZMArticleCommentModel alloc] initWithDictionary:dict[@"comment"]];
        if (dict[@"replay_info"]) {
            self.replay_info = [[ZMArticleReplayModel alloc] initWithDictionary:dict[@"replay_info"]];
        }
        
        //标题
        if (self.replay_info && [self.comment.parentid isEqualToString:self.replay_info.comment.cid]) {
            self.title = [NSString stringWithFormat:@"%@ 回复 %@：",self.user_info.nick,self.replay_info.user_info.nick];
        }else{
            self.title = [NSString stringWithFormat:@"%@：",self.user_info.nick];
        }
        //整个评论内容
        self.content = [NSString stringWithFormat:@"%@",self.comment.content];
        //高度
        self.contentHeight = [UILabel text:self.content heightWithFontSize:14 width:kScreenWidth - 20 * 2 - 30 lineSpacing:5];
        self.cellHeight = 20 + 10 + self.contentHeight + 20;
        
    }
    return self;
}

@end

@implementation ZMArticleCommentModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.cid = [ZMHelpUtil dispose:dict[@"id"]];
        self.uid = [ZMHelpUtil dispose:dict[@"uid"]];
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        self.parentid = [ZMHelpUtil dispose:dict[@"parentid"]];
        self.content = [ZMHelpUtil dispose:dict[@"content"]];
        self.addtime = [[ZMHelpUtil dispose:dict[@"addtime"]] longLongValue];
        self.createTimeTip = [ZMHelpUtil getCurrenFormatTime:self.addtime];
        self.like_num = [ZMHelpUtil dispose:dict[@"like_num"]];
        self.is_owner = [[ZMHelpUtil dispose:dict[@"is_owner"]] boolValue];
        self.is_like = [[ZMHelpUtil dispose:dict[@"is_like"]] boolValue];
    }
    return self;
}

@end

@implementation ZMArticleReplayModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.user_info = [[ZMUser alloc] initWithDictionary:dict[@"user_info"]];
        self.comment = [[ZMArticleCommentModel alloc] initWithDictionary:dict[@"comment"]];
    }
    return self;
}

@end

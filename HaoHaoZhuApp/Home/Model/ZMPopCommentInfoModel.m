//
//  ZMPopCommentInfoModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/17.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMPopCommentInfoModel.h"

@implementation ZMPopCommentInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.replayContentHeight = 0;
        self.user_info = [[ZMUser alloc] initWithDictionary:dict[@"user_info"]];
        self.comment = [[ZMArticleCommentModel alloc] initWithDictionary:dict[@"comment"]];
        if (dict[@"replay_info"]) {
            self.replay_info = [[ZMArticleReplayModel alloc] initWithDictionary:dict[@"replay_info"]];
        }
        
        self.userInfoHeight = 30;
        //整个评论内容
        self.content = self.comment.content;
        //评论内容高度
        self.contentHeight = [UILabel text:self.content heightWithFontSize:14 width:kScreenWidth - 20 - 30 - 10 - 20 lineSpacing:5];
        //是否是回复别人的内容
        if (self.replay_info) {
            self.replayContent = [NSString stringWithFormat:@"%@：%@",self.replay_info.user_info.nick,self.replay_info.comment.content];
            self.replayContentHeight = [UILabel text:self.replayContent heightWithFontSize:14 width:kScreenWidth - 20 - 30 - 10 - 20 - 13 lineSpacing:5];
            self.cellHeight = 20 + self.userInfoHeight + 10 + self.replayContentHeight + 10 +  self.contentHeight + 5 ;
        }else{
            self.cellHeight = 20 + self.userInfoHeight + 10 + self.replayContentHeight + self.contentHeight + 5 ;
        }
    }
    return self;
}


@end

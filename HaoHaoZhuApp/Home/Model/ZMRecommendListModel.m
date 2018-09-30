//
//  ZMRecommendModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMRecommendListModel.h"

@implementation ZMRecommendListModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.is_over = [[ZMHelpUtil dispose:dict[@"is_over"]] boolValue];
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"list"]];
        NSMutableArray *temp = [NSMutableArray new];
        //加载list
        for (int i = 0; i < list.count; i++) {
            NSDictionary *recommendDic = [list safeObjectAtIndex:i];
            ZMRecommendModel *model = [[ZMRecommendModel alloc] initWithDictionary:recommendDic];
            if (model.type == 1) {
                //暂时只添加文章
                [temp addObject:model];
            }
        }
        self.list = temp;
    }
    return self;
}

@end


@implementation ZMRecommendModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.type = [[ZMHelpUtil dispose:dict[@"type"]] integerValue];
        NSDictionary *article = [ZMHelpUtil dicDispose:dict[@"article"]];
        self.user_info = [[ZMUser alloc] initWithDictionary:[ZMHelpUtil dicDispose:article[@"user_info"]]];
        self.article_info = [[ZMArticleModel alloc] initWithDictionary:[ZMHelpUtil dicDispose:article[@"article_info"]]];
        self.counter = [[ZMCounter alloc] initWithDictionary:[ZMHelpUtil dicDispose:article[@"counter"]]];
        self.recommend_info = [[ZMFeedbackListModel alloc] initWithDictionary:[ZMHelpUtil dicDispose:dict[@"recommend_info"]]];
        //为了不再影响model的结构，这是一种取巧的办法
        self.article_info.tag = [self.article_info.tag stringByReplacingOccurrencesOfString:@"#三室#" withString:self.recommend_info.tag];
        //用户资料高度 + 主要内容高度 + 分享视图高度
        self.cellHeight = 75 + self.article_info.mainContentHeight + self.counter.operationTotalHeight;
        
        
        
    }
    return self;
}

@end

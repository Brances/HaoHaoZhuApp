//
//  ZMArticleRelaRecommendModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/10.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleRelaRecommendModel.h"

@implementation ZMArticleRelaRecommendModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.user_info = [[ZMUser alloc] initWithDictionary:dict[@"user_info"]];
        self.counter = [[ZMCounter alloc] initWithDictionary:dict[@"counter"]];
        self.article_info = [[ZMArticleModel alloc] initRelaRecommendWidthDictionary:dict[@"article_info"]];
        self.cellHeight = 30 + 18 + 15 + self.article_info.mainContentHeight;
        self.cellWidth = self.article_info.image.width;
    }
    return self;
}

@end

@implementation ZMArticleRelaRecommendInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.link = [ZMHelpUtil dispose:dict[@"link"]];
        self.title = [ZMHelpUtil dispose:dict[@"title"]];
        self.stat_name = [ZMHelpUtil dispose:dict[@"stat_name"]];
        
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"list"]];
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *articleDic = [list safeObjectAtIndex:i];
            ZMArticleRelaRecommendModel *model = [[ZMArticleRelaRecommendModel alloc] initWithDictionary:articleDic];
            [temp addObject:model];
        }
        self.list = temp;
        if (self.list.count) {
            self.cellHeight = [self.list objectAtIndex:0].cellHeight + 30;
        }
    }
    return self;
}

@end

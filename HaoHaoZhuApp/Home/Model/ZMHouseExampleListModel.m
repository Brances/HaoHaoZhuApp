//
//  ZMHouseExampleListModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/29.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHouseExampleListModel.h"

@implementation ZMHouseExampleListModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.total = [ZMHelpUtil dispose:dict[@"total"]];
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"rows"]];
        NSMutableArray *temp = [NSMutableArray new];
        //加载list
        for (int i = 0; i < list.count; i++) {
            NSDictionary *articleDic = [list safeObjectAtIndex:i];
            ZMHouseExampleModel *model = [[ZMHouseExampleModel alloc] initWithDictionary:articleDic];
            [temp addObject:model];
        }
        self.articleArray = temp;
    }
    return self;
}
@end

@implementation ZMHouseExampleModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.cellBottom = 20;
        self.user_info = [[ZMUser alloc] initWithDictionary:[ZMHelpUtil dicDispose:dict[@"user_info"]]];
        self.article_info = [[ZMArticleModel alloc] initHouseExampleWithDictionary:[ZMHelpUtil dicDispose:dict[@"article_info"]]];
        self.counter = [[ZMCounter alloc] initWithDictionary:[ZMHelpUtil dicDispose:dict[@"counter"]]];
        //主要内容高度+ 底部空白区域
        self.cellHeight = self.article_info.mainContentHeight + self.cellBottom;
    }
    return self;
}

@end

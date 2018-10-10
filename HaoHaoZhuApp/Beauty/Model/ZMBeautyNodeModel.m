//
//  ZMBeautyNodeModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
// 

#import "ZMBeautyNodeModel.h"

@implementation ZMBeautyNodeModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        self.index = [[ZMHelpUtil dispose:dict[@"index"]] integerValue];
    
        NSDictionary *scroll = dict[@"scroll"];
        self.scroll_id = [ZMHelpUtil dispose:scroll[@"scroll_id"]];
        self.name = [ZMHelpUtil dispose:scroll[@"name"]];
        self.link = [ZMHelpUtil dispose:scroll[@"link"]];
        
        NSArray *list = [ZMHelpUtil arrDispose:scroll[@"list"]];
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *banner = [list safeObjectAtIndex:i];
            ZMAdvertBannerModel *model = [[ZMAdvertBannerModel alloc] initWithDictionary:banner];
            [temp addObject:model];
        }
        self.bannerArray = temp;
        // 原图比例 465 * 620
        self.cellWidth = (kScreenWidth - 20 * 2 - 15 * 2)/3;
        self.cellHeight = 620 * self.cellWidth / 465;
        
    }
    return self;
}

@end

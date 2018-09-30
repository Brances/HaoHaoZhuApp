//
//  ZMHomeMenuListModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHomeMenuListModel.h"

@implementation ZMHomeMenuListModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"block_list"]];
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *menuDic = [ZMHelpUtil dicDispose:[list safeObjectAtIndex:i]];
            ZMHomeMenuModel *model = [[ZMHomeMenuModel alloc] initWithDictionary:menuDic];
            [temp addObject:model];
        }
        self.list = temp;
    }
    return self;
}

@end

@implementation ZMHomeMenuModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.mid = [ZMHelpUtil dispose:dict[@"id"]];
        self.location_no = [ZMHelpUtil dispose:dict[@"location_no"]];
        self.pic_url = [ZMHelpUtil dispose:dict[@"pic_url"]];
        self.title = [ZMHelpUtil dispose:dict[@"title"]];
        self.display_type = [ZMHelpUtil dispose:dict[@"display_type"]];
        self.sub_title = [ZMHelpUtil dispose:dict[@"sub_title"]];
        self.link = [ZMHelpUtil dispose:dict[@"link"]];
        self.part_name = [ZMHelpUtil dispose:dict[@"part_name"]];
        
        if ([self.link containsString:@"hhz://shaijia_fiterparams:[]"]) {
            self.type = ZMRecommendHeadTypeExample;
        }else if ([self.link containsString:@"hhz://topic:"]){
            self.type = ZMRecommendHeadTypeTopic;
        }else if ([self.link containsString:@"hhz://mall_tab"]){
            self.type = ZMRecommendHeadTypeMall;
        }else if ([self.link containsString:@"hhz://designer:{}"]){
            self.type = ZMRecommendHeadTypeDesigner;
        }
        
    }
    return self;
}

@end

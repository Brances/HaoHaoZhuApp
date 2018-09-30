//
//  ZMCategoryTypeModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMCategoryTypeModel.h"

@implementation ZMCategoryTypeModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        NSMutableArray *temp = [NSMutableArray new];
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"option_list"]];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *keyDic = [list safeObjectAtIndex:i];
            ZMCategoryItemModel *model = [[ZMCategoryItemModel alloc] initWithDictionary:keyDic];
            [temp addObject:model];
        }
        self.option_list = temp;
    }
    return self;
}

@end

@implementation ZMCategoryItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.name = [ZMHelpUtil dispose:dict[@"name"]];
        NSMutableArray *temp = [NSMutableArray new];
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"params"]];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *keyDic = [list safeObjectAtIndex:i];
            ZMCategoryKeyModel *model = [[ZMCategoryKeyModel alloc] initWithDictionary:keyDic];
            [temp addObject:model];
        }
        self.params = temp;
    }
    return self;
}

@end


@implementation ZMCategoryKeyModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.key = [ZMHelpUtil dispose:dict[@"key"]];
        self.value = [ZMHelpUtil dispose:dict[@"value"]];
    }
    return self;
}

@end


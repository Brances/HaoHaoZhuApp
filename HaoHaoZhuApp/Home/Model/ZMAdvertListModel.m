//
//  ZMAdvertListModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMAdvertListModel.h"

@implementation ZMAdvertListModel

@end



@implementation ZMAdvertModel

@end

@implementation ZMAdvertBannerModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.bid = [ZMHelpUtil dispose:dict[@"id"]];
        self.index = [[ZMHelpUtil dispose:dict[@"index"]] integerValue];
        self.link = [ZMHelpUtil dispose:dict[@"link"]];
        self.banner = [ZMHelpUtil dispose:dict[@"banner"]];
    }
    return self;
}

@end


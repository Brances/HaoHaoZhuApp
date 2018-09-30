//
//  ZMSearchTagModel.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMSearchTagModel.h"

@implementation ZMSearchTagModel

- (BOOL)shouldClick{
    return self.link.length ? YES : NO;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.name = [ZMHelpUtil dispose:dict[@"name"]];
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        self.link = [ZMHelpUtil dispose:dict[@"link"]];
        self.width = 0;
        self.height = 0;
        //计算宽度
        if (self.name.length) {
            self.width = [ZMHelpUtil widthForString:self.name font:[ZMFont defaultAppFontWithSize:12]] + 30;
            self.height = 30;
        }
    }
    return self;
}

@end

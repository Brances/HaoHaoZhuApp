//
//  ZMAdvertItemModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMAdvertItemModel.h"

@implementation ZMAdvertItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.aid = [ZMHelpUtil dispose:dict[@"id"]];
        self.title = [ZMHelpUtil dispose:dict[@"title"]];
        self.banner = [ZMHelpUtil dispose:dict[@"banner"]];
        self.link = [ZMHelpUtil dispose:dict[@"link"]];
        
        //解析图片宽高
        self.image = [[ZMPictureMetadataModel alloc] init];
        CGSize size = [ZMHelpUtil getImageSizeWithUrl:self.banner];
        self.image.realWidth = size.width;
        self.image.realHeight = size.height;
        //广告的宽和高
        self.image.height = 75;
        self.image.width = self.image.realWidth * self.image.height / self.image.realHeight;
    }
    return self;
}

@end

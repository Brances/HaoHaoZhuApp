//
//  ZMPhotoInfoModel.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/12/19.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMPhotoInfoModel.h"

@implementation ZMPhotoInfoModel

- (ZMPictureMetadataModel *)image{
    if (!_image) {
        _image = [[ZMPictureMetadataModel alloc] init];
    }
    return _image;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.pic_url = [ZMHelpUtil dispose:dict[@"pic_url"]];//750 * 750
        self.ne_pic_url = [ZMHelpUtil dispose:dict[@"new_pic_url"]]; //750 * 930
        self.thumb_pic_url = [ZMHelpUtil dispose:dict[@"thumb_pic_url"]]; //230 * 230
        self.ori_pic_url = [ZMHelpUtil dispose:dict[@"ori_pic_url"]]; //原图
        self.o_500_url = [ZMHelpUtil dispose:dict[@"o_500_url"]];  //500 * 625
        self.remark = [ZMHelpUtil dispose:dict[@"remark"]];
        self.pid = [ZMHelpUtil dispose:dict[@"id"]];
        //解析图片宽高
        CGSize size = [ZMHelpUtil getImageSizeWithUrl:self.o_500_url];
        self.image.realWidth = size.width;
        self.image.realHeight = size.height;
        //如果取到了宽高
        if (self.image.realWidth && self.image.realHeight) {
            self.image.width = (kScreenWidth - 20 * 2 - 15) * 0.5;
            self.image.height = (self.image.realHeight * self.image.width / self.image.realWidth) * 1;
        }
        
    }
    return self;
}

@end

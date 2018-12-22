//
//  ZMPhotoInfoModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/19.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMPhotoInfoModel.h"

@implementation ZMPhotoInfoModel

- (BOOL)isTag{
    return self.tags.count;
}

- (ZMPictureMetadataModel *)image{
    if (!_image) {
        _image = [[ZMPictureMetadataModel alloc] init];
    }
    return _image;
}

- (ZMPictureMetadataModel *)listImage{
    if (!_listImage) {
        _listImage = [[ZMPictureMetadataModel alloc] init];
    }
    return _listImage;
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
        self.thumb_tag_pic = self.ori_pic_url;
        NSArray *imageList = [ZMHelpUtil arrDispose:dict[@"image_list"]];
        if (imageList.count) {
            NSDictionary *dic = [imageList firstObject];
            self.thumb_tag_pic = [ZMHelpUtil dispose:dic[@"o_500_url"]];
        }
        
        //解析图片宽高
        CGSize size = [ZMHelpUtil getImageSizeWithUrl:self.o_500_url];
        
        self.image.realWidth = size.width;
        self.image.realHeight = size.height;
        //如果取到了宽高
        if (self.image.realWidth && self.image.realHeight) {
            self.image.width = (kScreenWidth - 20 * 2 - 15) * 0.5;
            self.image.height = (self.image.realHeight * self.image.width / self.image.realWidth) * 1;
        }
        //解析列表宽高
        //解析图片宽高
//        CGSize size2 = [ZMHelpUtil getImageSizeWithUrl:self.ne_pic_url];
        CGSize size2 = [ZMHelpUtil getImageSizeWithUrl:self.thumb_tag_pic];
        self.listImage.realWidth = size2.width;
        self.listImage.realHeight = size2.height;
        //如果取到了宽高
        if (self.listImage.realWidth && self.listImage.realHeight) {
            self.listImage.width = kScreenWidth;
            self.listImage.height = (self.listImage.realHeight * self.listImage.width / self.listImage.realWidth) * 1;
        }
        //判断有无标签
        NSArray *tags = [ZMHelpUtil arrDispose:dict[@"tags"]];
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < tags.count; i++) {
            NSDictionary *dic = [tags safeObjectAtIndex:i];
            ZYTagInfo *model = [[ZYTagInfo alloc] initWithDictionary:dic];
            [temp addObject:model];
        }
        self.tags = temp;
    }
    return self;
}

@end

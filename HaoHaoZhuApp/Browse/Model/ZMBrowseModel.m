//
//  ZMBrowseModel.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/12/19.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBrowseModel.h"

@implementation ZMBrowseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.remarkHeight = 0;
        self.userInfoHeight = 20;
        //照片信息
        self.photo = [[ZMPhotoInfoModel alloc] initWithDictionary:dict[@"photo"][@"photo_info"]];
        //用户信息
        self.user_info = [[ZMUser alloc] initWithDictionary:dict[@"photo"][@"user_info"]];
        //点赞收藏
        self.counter = [[ZMCounter alloc] initWithDictionary:dict[@"photo"][@"counter"]];
        
        //计算详情文字高度
        if (self.photo.remark.length) {
            //重新计算文本的高度
            self.remarkHeight = [UILabel text:self.photo.remark heightWithFontSize:12 width:self.photo.image.width lineSpacing:3];
            UIFont *font = [ZMFont defaultAppFontWithSize:12];
            //判断文字高度是否超过2行  10是行间距
            if (self.remarkHeight > font.lineHeight * 2 + 2 * 5) {
                self.remarkHeight = font.lineHeight * 2 + 2 * 5;
            }
        }
        self.cellHeight = self.photo.image.height + 5 + self.remarkHeight + 5 + self.userInfoHeight + 15;
    }
    return self;
}

@end

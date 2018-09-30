//
//  ZMArticleModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleModel.h"

@implementation ZMArticleModel
- (ZMPictureMetadataModel *)image{
    if (!_image) {
        _image = [[ZMPictureMetadataModel alloc] init];
    }
    return _image;
}
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.titleFont = 15;
        self.remarkFont = 15;
        self.titleMarginTop = 15;
        self.titleMarginBottom = 10;
        self.tagHeight = 20;
        self.remarkMarginTop = 10;
        self.remarkMarginBottom = 10;
        self.moreBottom = 10;
        
        self.aid = [ZMHelpUtil dispose:dict[@"aid"]];
        self.title = [ZMHelpUtil dispose:dict[@"title"]];
        self.remark = [ZMHelpUtil dispose:dict[@"remark"]];
        self.area = [ZMHelpUtil dispose:dict[@"area"]];
        self.cover_pic_id = [ZMHelpUtil dispose:dict[@"cover_pic_id"]];
        self.cover_pic_url = [ZMHelpUtil dispose:dict[@"cover_pic_url"]];
        self.status = [[ZMHelpUtil dispose:dict[@"status"]] boolValue];
        self.is_example = [[ZMHelpUtil dispose:dict[@"is_example"]] boolValue];
        self.addtime = [ZMHelpUtil getCurrenFormatTime: [[ZMHelpUtil dispose:dict[@"addtime"]] longLongValue]];
        self.publish_time = [ZMHelpUtil getCurrenFormatTime: [[ZMHelpUtil dispose:dict[@"publish_time"]] longLongValue]];
        self.is_favorited = [[ZMHelpUtil dispose:dict[@"is_favorited"]] boolValue];
        self.is_liked = [[ZMHelpUtil dispose:dict[@"is_liked"]] boolValue];
        self.house_size = [ZMHelpUtil dispose:dict[@"house_size"]];
        
        //解析图片宽高
        CGSize size = [ZMHelpUtil getImageSizeWithUrl:self.cover_pic_url];
        self.image.realWidth = size.width;
        self.image.realHeight = size.height;
        //如果取到了宽高
        if (self.image.realWidth && self.image.realHeight) {
            self.image.width = kScreenWidth;
            self.image.height = self.image.realHeight * kScreenWidth / self.image.realWidth;
        }
        
        //计算标题和内容高度
        if (self.title.length) {
            self.titleHeight = [ZMHelpUtil heightWithLabelFont:[ZMFont boldGothamWithSize:self.titleFont] withLabelWidth:kScreenWidth - 20 * 2 text:self.title];
        }
        if (self.remark.length) {
            //重新计算文本的高度
            self.remarkHeight = [UILabel text:self.remark heightWithFontSize:self.remarkFont width:kScreenWidth - 20 * 2 lineSpacing:10];
            UIFont *font = [ZMFont defaultAppFontWithSize:self.remarkFont];
            //判断文字高度是否超过3行  10是行间距
            if (self.remarkHeight > font.lineHeight * 4 + 3 * 10) {
                self.remarkHeight = font.lineHeight * 4 + 3 * 10;
            }
        }
        //分隔数组
        NSArray *groupArr = [self.area componentsSeparatedByString:@","];
        NSString *provinceCode,*cityCode;
        if (groupArr.count >= 2) {
            provinceCode = [ZMHelpUtil dispose:[groupArr safeObjectAtIndex:0]];
            cityCode = [ZMHelpUtil dispose:[groupArr safeObjectAtIndex:1]];
        }
        if (![ZMSettingManager shareInstance].provinceList.count) {
            //读取json文件
            NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"]];
            NSArray *list = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
            [ZMSettingManager shareInstance].provinceList = list;
        }
        [[ZMSettingManager shareInstance].provinceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = obj;
            NSString *lid = dic[@"lid"];
            if ([provinceCode isEqualToString:lid]) {
                self.province = dic[@"name"];
                *stop = YES;
            }
        }];
        self.tag = [NSString stringWithFormat:@"%@ | #三室# | %@²",self.province,self.house_size];
        self.tagHeight = [ZMHelpUtil heightWithLabelFont:[ZMFont defaultAppFontWithSize:12] withLabelWidth:kScreenWidth - 20 * 2 text:self.tag];
        self.moreWidth = [ZMHelpUtil widthForString:@"查看全文" font:[UIFont systemFontOfSize:15]];
        //查看更多高度
        self.moreHeight = [ZMHelpUtil HeightForText:@"查看全文" withSizeOfLabelFont:15 withWidthOfContent:kScreenWidth];
        //图片 + 标题 + 标签 + 描述 + 查看全文
        self.mainContentHeight = self.image.height + self.titleMarginTop + self.titleHeight + self.titleMarginBottom + self.tagHeight + self.remarkMarginTop + self.remarkHeight + self.remarkMarginBottom + self.moreHeight + self.moreBottom;
        
    }
    return self;
}

- (instancetype)initHouseExampleWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        //计算图片大小
        self.titleFont = 15;
        self.titleMarginTop = 15;
        self.titleMarginBottom = 5;
        self.tagHeight = 20;
        self.tagBottom = 20;
        
        self.aid = [ZMHelpUtil dispose:dict[@"aid"]];
        self.title = [ZMHelpUtil dispose:dict[@"title"]];
        self.house_size = [ZMHelpUtil dispose:dict[@"house_size"]];
        self.area = [ZMHelpUtil dispose:dict[@"area"]];
        self.cover_pic_url = [ZMHelpUtil dispose:dict[@"cover_pic_url"]];
        self.status = [[ZMHelpUtil dispose:dict[@"status"]] boolValue];
        self.is_example = [[ZMHelpUtil dispose:dict[@"is_example"]] boolValue];
        self.remark = [ZMHelpUtil dispose:dict[@"description"]];
        
        //解析图片宽高
        CGSize size = [ZMHelpUtil getImageSizeWithUrl:self.cover_pic_url];
        self.image.realWidth = size.width;
        self.image.realHeight = size.height;
        //如果取到了宽高
        if (self.image.realWidth && self.image.realHeight) {
            self.image.width = kScreenWidth - 20 * 2;
            self.image.height = self.image.realHeight * self.image.width / self.image.realWidth;
        }
        
        if (self.title.length) {
            self.titleHeight = [ZMHelpUtil heightWithLabelFont:[ZMFont boldGothamWithSize:self.titleFont] withLabelWidth:kScreenWidth - 20 * 2 - 20 * 2 text:self.title];
        }
        //分隔数组
        NSArray *groupArr = [self.area componentsSeparatedByString:@","];
        NSString *provinceCode,*cityCode;
        if (groupArr.count >= 2) {
            provinceCode = [ZMHelpUtil dispose:[groupArr safeObjectAtIndex:0]];
            cityCode = [ZMHelpUtil dispose:[groupArr safeObjectAtIndex:1]];
        }
        if (![ZMSettingManager shareInstance].provinceList.count) {
            //读取json文件
            NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"]];
            NSArray *list = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
            [ZMSettingManager shareInstance].provinceList = list;
        }
        [[ZMSettingManager shareInstance].provinceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = obj;
            NSString *lid = dic[@"lid"];
            if ([provinceCode isEqualToString:lid]) {
                self.province = dic[@"name"];
                *stop = YES;
            }
        }];
        self.tag = [NSString stringWithFormat:@"%@ | %@²",self.province,self.house_size];
        self.tagHeight = [ZMHelpUtil heightWithLabelFont:[ZMFont defaultAppFontWithSize:12] withLabelWidth:kScreenWidth - 20 * 2 text:self.tag];
        self.mainContentHeight = self.image.height + self.titleMarginTop + self.titleHeight + self.titleMarginBottom + self.tagHeight + self.tagBottom;
    }
    return self;
}

@end

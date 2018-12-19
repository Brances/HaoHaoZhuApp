//
//  ZMArticleDetailModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/7.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleDetailModel.h"

@implementation ZMArticleDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.article_id = [ZMHelpUtil dispose:dict[@"article_id"]];
        self.article_info = [[ZMArticleInfoModel alloc] initWithDictionary:dict[@"article_info"]];
        self.user_info = [[ZMUser alloc] initWithDictionary:dict[@"user_info"]];
        self.counter = [[ZMCounter alloc] initWithDictionary:dict[@"counter"]];
        
    }
    return self;
}
@end

@implementation ZMArticleInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        NSDictionary *articleDic = dict;
        self.head_info = [[ZMArticleHeadInfoModel alloc] initWithDictionary:articleDic[@"head_info"]];
        self.house_info = [[ZMArticleHouseInfoModel alloc] initWithDictionary:articleDic[@"house_info"]];
        NSArray *list = [ZMHelpUtil arrDispose:articleDic[@"show_photo_info"]];
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *photoDic = [list safeObjectAtIndex:i];
            ZMArticlePhotoInfoModel *model = [[ZMArticlePhotoInfoModel alloc] initWithDictionary:photoDic];
            [temp addObject:model];
        }
        self.show_photo_info = temp;
        //问答
        NSArray *askList = [ZMHelpUtil arrDispose:articleDic[@"question_info"][@"content"]];
        NSMutableArray *askTemp = [NSMutableArray new];
        for (int i = 0; i < askList.count; i++) {
            NSDictionary *askDic = [askList safeObjectAtIndex:i];
            ZMArticleQuestionAskModel *model = [[ZMArticleQuestionAskModel alloc] initWithDictionary:askDic];
            [askTemp addObject:model];
        }
        self.question_info = askTemp;
        
    }
    return self;
}

@end

@implementation ZMArticleHeadInfoModel

- (ZMPictureMetadataModel *)image{
    if (!_image) {
        _image = [[ZMPictureMetadataModel alloc] init];
    }
    return _image;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.title = [ZMHelpUtil dispose:dict[@"title"]];
        self.cover_pic_id = [ZMHelpUtil dispose:dict[@"cover_pic_id"]];
        self.ori_cover_pic_id = [ZMHelpUtil dispose:dict[@"ori_cover_pic_id"]];
        self.ori_cover_pic_url = [ZMHelpUtil dispose:dict[@"ori_cover_pic_url"]];
        self.cover_pic_url = [ZMHelpUtil dispose:dict[@"cover_pic_url"]];
        self.space_sort_test = [ZMHelpUtil dispose:dict[@"space_sort_test"]];
        self.desc = [ZMHelpUtil dispose:dict[@"description"]];
        self.status = [ZMHelpUtil dispose:dict[@"status"]];
        self.addtime = [[ZMHelpUtil dispose:dict[@"addtime"]] longLongValue];
        self.is_example = [[ZMHelpUtil dispose:dict[@"is_example"]] boolValue];
        self.operation_title = [ZMHelpUtil dispose:dict[@"operation_title"]];
        
        self.titleHeight = [ZMHelpUtil heightWithLabelFont:[ZMFont boldGothamWithSize:20] withLabelWidth:kScreenWidth - 20 * 2 text:self.title];
        self.recommendHeight = [ZMHelpUtil heightWithLabelFont:[ZMFont defaultAppFontWithSize:14] withLabelWidth:kScreenWidth - 20 - 40 - 20 - 20 text:self.title];
        self.descHeight = [UILabel text:self.desc heightWithFontSize:15 width:kScreenWidth - 20 * 2 lineSpacing:10];
        
        //解析图片宽高
        CGSize size = [ZMHelpUtil getImageSizeWithUrl:self.cover_pic_url];
        self.image.realWidth = size.width;
        self.image.realHeight = size.height;
        //如果取到了宽高
        if (self.image.realWidth && self.image.realHeight) {
            self.image.width = kScreenWidth;
            self.image.height = self.image.realHeight * kScreenWidth / self.image.realWidth;
        }
        //版权
        NSString *createTime = [ZMHelpUtil getCurrenFormatTime:self.addtime];
        NSString *copyright = @"©声明：本页所有文字与图片禁止以非好好住旗下之产品形态装载或发布";
        NSString *content = [NSString stringWithFormat:@"创建于 %@\n%@",createTime,copyright];
        self.declareContent = content;
        self.declareHeight = [UILabel text:content heightWithFontSize:12 width:kScreenWidth - 20 * 2 lineSpacing:5];
        self.declareCellHeight = 40 + self.declareHeight + 40;
    }
    return self;
}

@end

@implementation ZMArticleHouseInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.aid = [ZMHelpUtil dispose:dict[@"aid"]];
        self.area = [ZMHelpUtil dispose:dict[@"area"]];
        self.house_construction = [ZMHelpUtil dispose:dict[@"house_construction"]];
        self.house_size = [ZMHelpUtil dispose:dict[@"house_size"]];
        self.house_stuff = [ZMHelpUtil dispose:dict[@"house_stuff"]];
        self.designer = [ZMHelpUtil dispose:dict[@"designer"]];
        self.designer_uid = [ZMHelpUtil dispose:dict[@"designer_uid"]];
        self.last_designer_uid = [ZMHelpUtil dispose:dict[@"last_designer_uid"]];
        self.area_ch = [ZMHelpUtil dispose:dict[@"area_ch"]];
    }
    return self;
}

@end

@implementation ZMArticlePhotoInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.a_p_id = [ZMHelpUtil dispose:dict[@"a_p_id"]];
        self.name = [ZMHelpUtil dispose:dict[@"name"]];
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"show_pics"]];
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *picDic = [list safeObjectAtIndex:i];
            ZMArticlePhotoContentInfoModel *model = [[ZMArticlePhotoContentInfoModel alloc] initWithDictionary:picDic];
            [temp addObject:model];
        }
        self.show_pics = temp;
    }
    return self;
}
@end

@implementation ZMArticlePhotoContentInfoModel

- (ZMPictureMetadataModel *)image{
    if (!_image) {
        _image = [[ZMPictureMetadataModel alloc] init];
    }
    return _image;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.photo_id = [ZMHelpUtil dispose:dict[@"photo_id"]];
        self.pic_url = [ZMHelpUtil dispose:dict[@"pic_url"]];
//        self.ne_pic_url = [ZMHelpUtil dispose:dict[@"new_pic_url"]];  //字段已废弃
//        self.ori_pic_url = [ZMHelpUtil dispose:dict[@"ori_pic_url"]];
        self.ori_pic_url = [ZMHelpUtil dispose:dict[@"pic_url"]];
        self.pic_id = [ZMHelpUtil dispose:dict[@"pic_id"]];
        self.pic_org_id = [ZMHelpUtil dispose:dict[@"pic_org_id"]];
        self.has_goods = [[ZMHelpUtil dispose:dict[@"has_goods"]] boolValue];
        self.remark = [ZMHelpUtil dispose:dict[@"remark"]];
        self.has_goods_tag = [[ZMHelpUtil dispose:dict[@"has_goods_tag"]] boolValue];
        self.has_recommend_goods = [[ZMHelpUtil dispose:dict[@"has_recommend_goods"]] boolValue];
        self.is_del = [[ZMHelpUtil dispose:dict[@"is_del"]] boolValue];
        self.is_private = [[ZMHelpUtil dispose:dict[@"is_private"]] boolValue];
        self.counter = [[ZMCounter alloc] initWithDictionary:dict[@"counter"]];
        //解析图片宽高
        CGSize size = [ZMHelpUtil getImageSizeWithUrl:self.ori_pic_url];
        self.image.realWidth = size.width;
        self.image.realHeight = size.height;
        //如果取到了宽高
        if (self.image.realWidth && self.image.realHeight) {
            self.image.width = kScreenWidth - 20 * 2;
            self.image.height = self.image.realHeight * kScreenWidth / self.image.realWidth;
        }
        //描述文本高度
        self.remarkHeight = [UILabel text:self.remark heightWithFontSize:15 width:kScreenWidth - 20 * 2 lineSpacing:10];
        self.cellHeight = self.image.height + 10 + self.remarkHeight + 20;
        
    }
    return self;
}

@end

@implementation ZMArticleQuestionAskModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        self.title = [ZMHelpUtil dispose:dict[@"title"]];
        self.text = [ZMHelpUtil dispose:dict[@"text"]];
        
        self.titleHeight = [UILabel text:self.title boldHeightWithFontSize:18 width:kScreenWidth - 20 * 2 - 20 * 2 - 10 lineSpacing:5];
        self.contentHeight = [UILabel text:self.text heightWithFontSize:15 width:kScreenWidth - 20 * 2 - 20 * 2 - 10 lineSpacing:10];
        self.cellHeight = 20 + self.titleHeight + 5 + self.contentHeight + 10 + 20;
        
    }
    return self;
}

@end


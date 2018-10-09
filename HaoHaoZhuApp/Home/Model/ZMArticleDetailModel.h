//
//  ZMArticleDetailModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/7.
//  Copyright © 2018年 Brances. All rights reserved.
//  文章详情

#import "ZMBaseModel.h"
#import "ZMCounter.h"
@class ZMArticleInfoModel,ZMArticleHeadInfoModel,ZMArticleHouseInfoModel;
@class ZMArticlePhotoInfoModel,ZMArticlePhotoContentInfoModel,ZMArticleQuestionAskModel;

@interface ZMArticleDetailModel : ZMBaseModel

@property (nonatomic, copy) NSString *article_id;
@property (nonatomic, strong) ZMArticleInfoModel *article_info;
@property (nonatomic, strong) ZMUser *user_info;
@property (nonatomic, strong) ZMCounter *counter;

@end

/** 文章布局信息相关详情 */
@interface ZMArticleInfoModel : ZMBaseModel

@property (nonatomic, strong) ZMArticleHeadInfoModel *head_info;
@property (nonatomic, strong) ZMArticleHouseInfoModel *house_info;
@property (nonatomic, strong) NSArray<ZMArticlePhotoInfoModel *> *show_photo_info;
@property (nonatomic, strong) NSArray<ZMArticleQuestionAskModel *> *question_info;

@end

/** 头部信息 */
@interface ZMArticleHeadInfoModel : ZMBaseModel

/** 110平方的破旧小改造后居然拥有50立方的储物收纳空间 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat  recommendHeight;
/** baee021580km00000pfq1ib */
@property (nonatomic, copy) NSString *cover_pic_id;
/** 87cce215a0rs00000pfq1ia */
@property (nonatomic, copy) NSString *ori_cover_pic_id;
/** http://img.hhz1.cn/App-imageShow/sq_phone/8bc/87cce215a0rs00000pfq1ia?iv=1&w=750&h=750 */
@property (nonatomic, copy) NSString *ori_cover_pic_url;
/** http://img.hhz1.cn/App-imageShow/o_nphone/1a7/27f9520rs0cx00000pfv7fw?iv=1&w=750&h=348.75 */
@property (nonatomic, copy) NSString *cover_pic_url;
/** 户型图,玄关,客厅,厨房,餐厅,卫生间,卧室,书房,儿童房,衣帽间,阳台,走廊 */
@property (nonatomic, copy) NSString *space_sort_test;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) CGFloat descHeight;
/** 1 */
@property (nonatomic, copy) NSString *status;
/** 1538068511 */
@property (nonatomic, assign) long long addtime;
/** 1 */
@property (nonatomic, assign) BOOL  is_example;
/** 110㎡老房改造出50m³收纳空间！不敢相信自己的眼睛！ */
@property (nonatomic, copy) NSString *operation_title;
@property (nonatomic, strong) ZMPictureMetadataModel *image;
/** 版权声明内容 */
@property (nonatomic, copy) NSString    *declareContent;
@property (nonatomic, assign) CGFloat     declareCellHeight;
@property (nonatomic, assign) CGFloat     declareHeight;

@end

/** 户型信息 */
@interface ZMArticleHouseInfoModel : ZMBaseModel

/** 0001bzl01000oxn7 */
@property (nonatomic, copy) NSString *aid;
/** 19,233 */
@property (nonatomic, copy) NSString *area;
/** 3 */
@property (nonatomic, copy) NSString *house_construction;
/** 85 */
@property (nonatomic, copy) NSString *house_size;
/** 500000 */
@property (nonatomic, copy) NSString *house_stuff;
/** 2 */
@property (nonatomic, copy) NSString *designer;
/** 0 */
@property (nonatomic, copy) NSString *designer_uid;
/** 0 */
@property (nonatomic, copy) NSString *last_designer_uid;
/** 广东,深圳 */
@property (nonatomic, copy) NSString *area_ch;

@end


/** 照片集合信息 */
@interface ZMArticlePhotoInfoModel : ZMBaseModel

@property (nonatomic, copy) NSString *a_p_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<ZMArticlePhotoContentInfoModel *> *show_pics;

@end

/** 图片文字内容信息 */
@interface ZMArticlePhotoContentInfoModel : ZMBaseModel

@property (nonatomic, copy) NSString *photo_id;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *ne_pic_url;
@property (nonatomic, copy) NSString *ori_pic_url;
@property (nonatomic, copy) NSString *pic_id;
@property (nonatomic, copy) NSString *pic_org_id;
@property (nonatomic, assign) BOOL has_goods;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) CGFloat remarkHeight;
@property (nonatomic, assign) BOOL has_goods_tag;
@property (nonatomic, assign) BOOL has_recommend_goods;
@property (nonatomic, assign) BOOL is_del;
@property (nonatomic, assign) BOOL is_private;
@property (nonatomic, strong) ZMCounter *counter;
@property (nonatomic, strong) ZMPictureMetadataModel *image;
@property (nonatomic, assign) CGFloat   cellHeight;

@end

@interface ZMArticleQuestionAskModel : ZMBaseModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@end


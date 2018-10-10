//
//  ZMArticleModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMPictureMetadataModel.h"

@interface ZMArticleModel : ZMBaseModel

/** 文章id */
@property (nonatomic, copy) NSString *aid;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 标题字体大小 */
@property (nonatomic, assign) CGFloat titleFont;
/** 标题高度 */
@property (nonatomic, assign) CGFloat titleHeight;
/** 备注 */
@property (nonatomic, copy) NSString *remark;
/** 标签 */
@property (nonatomic, strong) NSString *tag;
/** 标签的高度 */
@property (nonatomic, assign) CGFloat       tagHeight;
/** 标签底部距离 用于整屋 */
@property (nonatomic, assign) CGFloat       tagBottom;
/** 备注字体大小 */
@property (nonatomic, assign) CGFloat remarkFont;
/** 内容高度*/
@property (nonatomic, assign) CGFloat remarkHeight;
/** 封面id */
@property (nonatomic, copy) NSString *cover_pic_id;
/** 封面url */
@property (nonatomic, copy) NSString *cover_pic_url;
/** 封面图信息 */
@property (nonatomic, strong) ZMPictureMetadataModel *image;
@property (nonatomic, assign) BOOL status;
/** 是否编辑精选 */
@property (nonatomic, assign) BOOL is_example;
/** 添加时间 */
@property (nonatomic, copy) NSString     *addtime;
/** 发布时间 */
@property (nonatomic, copy) NSString     *publish_time;
/** 区域集合 */
@property (nonatomic, copy) NSString        *area;
/** 省份 */
@property (nonatomic, copy) NSString        *province;
/** 城市 */
@property (nonatomic, copy) NSString        *city;
/** 是否收藏 */
@property (nonatomic, assign) BOOL          is_favorited;
/** 是否点赞 */
@property (nonatomic, assign) BOOL          is_liked;
/** 房屋大小 */
@property (nonatomic, copy) NSString        *house_size;
/** 几室 */
@property (nonatomic, copy) NSString        *construction;
/** 主要内容的高度 */
@property (nonatomic, assign) CGFloat       mainContentHeight;
///** 整个文章的view高度 */
//@property (nonatomic, assign) CGFloat       viewHeight;
/** 标题距离图片的间距 */
@property (nonatomic, assign) CGFloat       titleMarginTop;
/** 标题距离底部标签的间距 */
@property (nonatomic, assign) CGFloat       titleMarginBottom;

/** 描述距离上面标签的间距 */
@property (nonatomic, assign) CGFloat       remarkMarginTop;
@property (nonatomic, assign) CGFloat       remarkMarginBottom;

/** 查看更多按钮高度 */
@property (nonatomic, assign) CGFloat           moreWidth;
@property (nonatomic, assign) CGFloat           moreHeight;
@property (nonatomic, assign) CGFloat           moreBottom;

/** 整屋案例列表 */
- (instancetype)initHouseExampleWithDictionary:(NSDictionary *)dict;
/** 整屋详情相关案例 */
- (instancetype)initRelaRecommendWidthDictionary:(NSDictionary *)dict;

@end





//
//  ZMArticleRelaRecommendModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/10.
//  Copyright © 2018年 Brances. All rights reserved.
//  文章相关推荐案例

#import "ZMBaseModel.h"
#import "ZMArticleDetailModel.h"
#import "ZMArticleModel.h"

@interface ZMArticleRelaRecommendModel : ZMBaseModel

@property (nonatomic, strong) ZMArticleModel    *article_info;
@property (nonatomic, strong) ZMUser                *user_info;
@property (nonatomic, strong) ZMCounter           *counter;
@property (nonatomic, assign) CGFloat                 cellHeight;
@property (nonatomic, assign) CGFloat                 cellWidth;
@end

@interface ZMArticleRelaRecommendInfoModel : ZMBaseModel

@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) NSArray<ZMArticleRelaRecommendModel *> *list;
/** 熹维设计的更多案例 */
@property (nonatomic, copy) NSString    *title;
/** designer_article_more */
@property (nonatomic, copy) NSString     *stat_name;
@property (nonatomic, assign) CGFloat                 cellHeight;

@end

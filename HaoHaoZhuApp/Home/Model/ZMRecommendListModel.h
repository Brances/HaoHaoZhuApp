//
//  ZMRecommendModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMArticleModel.h"
#import "ZMCounter.h"
#import "ZMFeedbackListModel.h"

@class ZMRecommendModel;
@interface ZMRecommendListModel : ZMBaseModel

/** 数据是否加载完毕 */
@property (nonatomic, assign) BOOL      is_over;
@property (nonatomic, strong) NSMutableArray<ZMRecommendModel *> *list;

@end



@interface ZMRecommendModel : ZMBaseModel

@property (nonatomic, assign) NSInteger       type;
@property (nonatomic, strong) ZMUser    *user_info;
@property (nonatomic, strong) ZMArticleModel *article_info;
@property (nonatomic, strong) ZMCounter *counter;
@property (nonatomic, strong) ZMFeedbackListModel *recommend_info;

@property (nonatomic, assign) CGFloat   cellHeight;

@end

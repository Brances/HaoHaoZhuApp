//
//  ZMBeautyNodeModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
//  装修前中后

#import "ZMBaseModel.h"
#import "ZMAdvertListModel.h"

@interface ZMBeautyNodeModel : ZMBaseModel

//没有按照后台的数据格式来
@property (nonatomic, copy) NSString        *type;
@property (nonatomic, assign) NSInteger     index;
@property (nonatomic, copy) NSString        *scroll_id;
@property (nonatomic, copy) NSString        *name;
@property (nonatomic, copy) NSString        *link;
@property (nonatomic, strong) NSArray<ZMAdvertBannerModel *> *bannerArray;
@property (nonatomic, assign) CGFloat       cellWidth;
@property (nonatomic, assign) CGFloat       cellHeight;

@end

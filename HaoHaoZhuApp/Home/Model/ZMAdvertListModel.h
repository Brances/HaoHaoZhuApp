//
//  ZMAdvertListModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//  推荐页面插入的广告

#import "ZMBaseModel.h"

@interface ZMAdvertListModel : ZMBaseModel


@end


@interface ZMAdvertModel : ZMBaseModel

@property (nonatomic, copy) NSString *type;

@end


@interface ZMAdvertBannerModel : ZMBaseModel

@property (nonatomic, copy) NSString     *bid;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString    *link;
@property (nonatomic, copy) NSString    *banner;

@end


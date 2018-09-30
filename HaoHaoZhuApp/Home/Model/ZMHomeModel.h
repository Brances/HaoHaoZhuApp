//
//  ZMHomeModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMHomeMenuListModel.h"
#import "ZMRecommendListModel.h"

@interface ZMHomeModel : ZMBaseModel

@property (nonatomic, strong) ZMHomeMenuListModel       *menuList;
@property (nonatomic, strong) ZMRecommendListModel      *recommendList;

@end

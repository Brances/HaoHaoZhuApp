//
//  ZMHouseExampleListModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/29.
//  Copyright © 2018年 Brances. All rights reserved.
//  整屋案例大卡片

#import "ZMBaseModel.h"
#import "ZMArticleModel.h"
#import "ZMCounter.h"

@class ZMHouseExampleModel;
@interface ZMHouseExampleListModel : ZMBaseModel

@property (nonatomic, copy) NSString        *total;
@property (nonatomic, strong) NSMutableArray<ZMHouseExampleModel *> *articleArray;
@property (nonatomic, assign) BOOL          is_over;

@end

@interface ZMHouseExampleModel : ZMBaseModel

@property (nonatomic, strong) ZMArticleModel    *article_info;
@property (nonatomic, strong) ZMUser                *user_info;
@property (nonatomic, strong) ZMCounter           *counter;
@property (nonatomic, assign) CGFloat                 cellHeight;
@property (nonatomic, assign) CGFloat                 cellBottom;

@end

//
//  ZMCategoryTypeModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//  整屋案例分类集合

#import "ZMBaseModel.h"
@class ZMCategoryItemModel,ZMCategoryKeyModel;

@interface ZMCategoryTypeModel : ZMBaseModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray <ZMCategoryItemModel *> *option_list;

@end


@interface ZMCategoryItemModel : ZMBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<ZMCategoryKeyModel *> *params;

@end

@interface ZMCategoryKeyModel : ZMBaseModel

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

@end


//
//  ZMBrowseModel.h
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/12/19.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMPhotoInfoModel.h"
#import "ZMUser.h"
#import "ZMCounter.h"

@interface ZMBrowseModel : ZMBaseModel

@property (nonatomic, strong) ZMPhotoInfoModel *photo;
@property (nonatomic, strong) ZMUser                  *user_info;
@property (nonatomic, strong) ZMCounter             *counter;

@property (nonatomic, assign) CGFloat       cellHeight;
@property (nonatomic, assign) CGFloat       remarkHeight;
@property (nonatomic, assign) CGFloat       userInfoHeight;

@end

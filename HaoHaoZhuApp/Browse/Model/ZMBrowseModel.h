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

/** 以下是看图列表的大小 */
@property (nonatomic, assign) CGFloat       listCellHeight; //总高度
@property (nonatomic, assign) CGFloat       listUserInfoHeight;//用户信息高度
@property (nonatomic, assign) CGFloat       listImageHeight;//图片高度
@property (nonatomic, assign) CGFloat       listRemarkHeight;//描述高度
@property (nonatomic, assign) CGFloat       listOperationHeight;//底部点赞视图等高度

@end

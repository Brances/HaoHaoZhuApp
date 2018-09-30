//
//  ZMAdvertItemModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//  整屋案例广告

#import "ZMBaseModel.h"
#import "ZMPictureMetadataModel.h"

@interface ZMAdvertItemModel : ZMBaseModel

@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *banner;
@property (nonatomic, strong) ZMPictureMetadataModel *image;
@property (nonatomic, copy) NSString *link;

@end

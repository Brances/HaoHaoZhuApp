//
//  ZMPhotoInfoModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/19.
//  Copyright © 2018年 Brances. All rights reserved.
//  照片信息

#import "ZMBaseModel.h"
#import "ZYTagImageView.h"

@interface ZMPhotoInfoModel : ZMBaseModel

@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *ne_pic_url;
@property (nonatomic, copy) NSString *thumb_pic_url;
@property (nonatomic, copy) NSString *ori_pic_url;
@property (nonatomic, copy) NSString *o_500_url;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *pin_pic_id;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *thumb_tag_pic;
@property (nonatomic, strong) ZMPictureMetadataModel *image;
@property (nonatomic, strong) ZMPictureMetadataModel *listImage;

@property (nonatomic, strong) NSArray<ZYTagInfo *>       *tags;
@property (nonatomic, assign,readonly) BOOL      isTag;
@property (nonatomic, assign) BOOL                    showTag;

@end

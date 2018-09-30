//
//  ZMUser.h
//  
//
//  Created by Brances on 2018/3/31.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMBaseModel.h"

@interface ZMUser : ZMBaseModel

/** 用户ID */
@property (nonatomic, copy) NSString    *uid;
@property (nonatomic, copy) NSString    *nick;
@property (nonatomic, copy) NSString    *gender;
/** 省市集合 */
@property (nonatomic, copy) NSString    *area;
@property (nonatomic, copy) NSString    *province;
@property (nonatomic, copy) NSString    *city;
/** 类型 */
@property (nonatomic, copy) NSString    *type;
@property (nonatomic, copy) NSString    *status;
/** airbnb民宿微信：ju3648998 */
@property (nonatomic, copy) NSString    *profile;
/** 小图 */
@property (nonatomic, copy) NSString    *avatar_small;
/** 中图 */
@property (nonatomic, copy) NSString    *avatar;
/** 大图 */
@property (nonatomic, copy) NSString    *big_avatar;
/** 是否需要水印 */
@property (nonatomic, copy) NSString     *is_watermarking;
/** 是否关注 */
@property (nonatomic, copy) NSString     *is_follow;


@end

//
//  ZMHomeMenuListModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
@class ZMHomeMenuModel;
@interface ZMHomeMenuListModel : ZMBaseModel

/** 1006 */
@property (nonatomic, copy) NSString            *type;
@property (nonatomic, strong) NSMutableArray<ZMHomeMenuModel *> *list;

@end

@interface ZMHomeMenuModel : ZMBaseModel

/** 171 */
@property (nonatomic, copy) NSString *mid;
/** 11 */
@property (nonatomic, copy) NSString *location_no;
/** http://img.hhz1.cn/Op-imageShow/54e94304c04600000pe86l8?iv=1 */
@property (nonatomic, copy) NSString *pic_url;
/** 整屋案例 */
@property (nonatomic, copy) NSString *title;
/** 2 */
@property (nonatomic, copy) NSString *display_type;
/**   */
@property (nonatomic, copy) NSString *sub_title;
/** hhz://shaijia_fiterparams:[] */
@property (nonatomic, copy) NSString *link;
/** 整屋案例 */
@property (nonatomic, copy) NSString *part_name;
/** type */
@property (nonatomic, assign) ZMRecommendHeadType type;

@end

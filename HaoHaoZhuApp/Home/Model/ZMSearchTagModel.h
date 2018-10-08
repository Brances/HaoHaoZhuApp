//
//  ZMSearchTagModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
//  搜索标签

#import "ZMBaseModel.h"

@interface ZMSearchTagModel : ZMBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *link;
/** link有值表示可点击 */
@property (nonatomic, assign, readonly) BOOL  shouldClick;
@property (nonatomic, assign) CGFloat   width;
@property (nonatomic, assign) CGFloat   height;

@end

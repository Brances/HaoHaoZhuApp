//
//  ZMTagInfoModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMTagInfoModel : ZMBaseModel

@property (nonatomic, assign) CGFloat     x;
@property (nonatomic, assign) CGFloat     y;
@property (nonatomic, assign) NSInteger    arrow ;
@property (nonatomic, assign) NSInteger  type;
@property (nonatomic, copy) NSString *brand;

@end

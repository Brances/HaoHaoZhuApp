//
//  ZMSearchTagCell.h
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/9/30.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMSearchTagModel.h"

@interface ZMSearchTagCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *tagButton;
@property (nonatomic, strong) ZMSearchTagModel *model;
@property (nonatomic, strong) void(^didClickBtnBlock)(ZMSearchTagModel *model);

@end

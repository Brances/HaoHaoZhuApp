//
//  ZMBrowseListCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/21.
//  Copyright © 2018年 Brances. All rights reserved.
//  看图列表

#import "YYTableViewCell.h"
#import "ZMUserProfileView.h"
#import "ZMOperationView.h"
#import "ZMBrowseModel.h"
#import "ZYTagImageView.h"

@interface ZMBrowseListCell : YYTableViewCell

@property (nonatomic, strong) UIView                                    *mainView;
@property (nonatomic, strong) ZMUserProfileView                  *profileView;
@property (nonatomic, strong) ZYTagImageView                          *coverView;
@property (nonatomic, strong) UILabel                                    *descLabel;
@property (nonatomic, strong) ZMOperationView                   *operationView;
@property (nonatomic, strong) ZMBrowseModel                     *model;

@end

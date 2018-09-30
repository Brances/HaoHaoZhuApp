//
//  ZMHouseExampleCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/29.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMHouseExampleListModel.h"

@interface ZMHouseExampleCell : YYTableViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) ZMImageView *coverView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) ZMHouseExampleModel *model;

@end

//
//  ZMUserProfileView.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMUser.h"

@interface ZMUserProfileView : UIView

@property (nonatomic, strong) ZMImageView *iconView;
@property (nonatomic, strong) UILabel          *nameLabel;
@property (nonatomic, strong) UIButton       *followBtn;
@property (nonatomic, strong) UIButton       *dropDownBtn;
@property (nonatomic, strong) ZMUser         *user;

@end

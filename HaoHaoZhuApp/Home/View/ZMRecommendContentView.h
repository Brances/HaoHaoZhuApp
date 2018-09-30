//
//  ZMRecommendContentView.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMArticleModel.h"
@interface ZMRecommendContentView : UIView

@property (nonatomic, strong) ZMImageView   *coverView;
@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UILabel           *tagLabel;
@property (nonatomic, strong) UILabel           *remarkLabel;
@property (nonatomic, strong) UIButton         *moreBtn;
@property (nonatomic, strong) ZMArticleModel *model;

@end

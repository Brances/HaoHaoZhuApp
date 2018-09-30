//
//  ZMHomeRecommendCell.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMUserProfileView.h"
#import "ZMRecommendListModel.h"
#import "ZMRecommendContentView.h"
#import "ZMOperationView.h"
@interface ZMHomeRecommendCell : UICollectionViewCell

@property (nonatomic, strong) UIView                                    *mainView;
@property (nonatomic, strong) ZMUserProfileView                 *profileView;
@property (nonatomic, strong) ZMRecommendContentView    *mainContentView;
@property (nonatomic, strong) ZMOperationView                   *operationView;
@property (nonatomic, strong) ZMRecommendModel  *model;

@end

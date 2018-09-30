//
//  ZMBeautyTopBannerCell.h
//  HaoHaoZhuApp
//
//  Created by 卢洋 on 2018/9/29.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMAdvertListModel.h"
#import "TYCyclePagerView.h"

@interface ZMBeautyTopBannerCell : UICollectionViewCell

@property (nonatomic, strong) ZMImageView *banner;
@property (nonatomic, strong) ZMAdvertBannerModel *model;

@end

@interface ZMBeautyTopBannerCollectionCell : UICollectionViewCell<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView      *pagerView;
@property (nonatomic, strong) NSArray<ZMAdvertBannerModel *> *advertArray;

@end

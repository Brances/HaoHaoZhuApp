//
//  ZMBeautyTopBannerCell.m
//  HaoHaoZhuApp
//
//  Created by 卢洋 on 2018/9/29.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBeautyTopBannerCell.h"

@implementation ZMBeautyTopBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.banner = [ZMImageView new];
    [self.contentView addSubview:self.banner];
}

- (void)setModel:(ZMAdvertBannerModel *)model{
    _model = model;
    [self.banner setAnimationLoadingImage:[NSURL URLWithString:model.banner] placeholder:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.banner.frame = self.bounds;
}

@end

@implementation ZMBeautyTopBannerCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [pagerView registerClass:[ZMBeautyTopBannerCell class] forCellWithReuseIdentifier:@"ZMBeautyTopBannerCell"];
    [self.contentView addSubview:pagerView];
    _pagerView = pagerView;
}

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.advertArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    ZMBeautyTopBannerCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"ZMBeautyTopBannerCell" forIndex:index];
    cell.model = [self.advertArray objectAtIndex:index];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*1.0, CGRectGetHeight(pageView.frame)*1.0);
    layout.itemSpacing = 0;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _pagerView.frame = CGRectMake(0, 0, kScreenWidth, self.height);
}

@end


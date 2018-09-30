//
//  ZMCustomGifHeader.m
//  ZMBCY
//
//  Created by Brance on 2017/12/11.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMCustomGifHeader.h"

@implementation ZMCustomGifHeader

#pragma mark - 重写方法
- (void)prepare{
    [super prepare];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）new_pull-down02
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_pull-down0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateIdle];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //隐藏状态时间和状态文字
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
}

#pragma mark - 重新设置子控件
- (void)placeSubviews{
    [super placeSubviews];
}

@end

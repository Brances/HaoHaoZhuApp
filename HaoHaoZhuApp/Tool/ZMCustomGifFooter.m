//
//  ZMCustomGifFooter.m
//  ZMBCY
//
//  Created by Brance on 2017/12/15.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMCustomGifFooter.h"

@implementation ZMCustomGifFooter

#pragma mark - 重写方法
- (void)prepare{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i < 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_pull-down0%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"- END -" forState:MJRefreshStateNoMoreData];
    self.stateLabel.textColor = [ZMColor appSubColor];
    self.refreshingTitleHidden = YES;
}

#pragma mark - 重新设置子控件
- (void)placeSubviews{
    [super placeSubviews];
    self.gifView.mj_x = (self.mj_w -  self.gifView.mj_w)/2;
}

@end

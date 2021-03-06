//
//  ZMHomeRecommendCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHomeRecommendCell.h"
#import "ZMPopCommentView.h"

@implementation ZMHomeRecommendCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [ZMColor appBgGrayColor];
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    
    self.mainView = [UIView new];
    self.mainView.frame = CGRectMake(0, 0, kScreenWidth, self.height - 10);
    self.mainView.backgroundColor = [ZMColor whiteColor];
    [self.contentView addSubview:self.mainView];
    
    self.profileView = [[ZMUserProfileView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
    [self.mainView addSubview:self.profileView];
    
    self.mainContentView = [[ZMRecommendContentView alloc] initWithFrame:CGRectZero];
    [self.mainView addSubview:self.mainContentView];
    
    self.operationView = [[ZMOperationView alloc] initWithFrame:CGRectZero];
    self.operationView.backgroundColor = [ZMColor whiteColor];
    @weakify(self);
    self.operationView.didTapBtn = ^(NSInteger index) {
        //弹出评论视图
        [weak_self openCommentView:index];
    };
    [self.mainView addSubview:self.operationView];
    
}

#pragma mark - 弹出评论视图
- (void)openCommentView:(NSInteger)index{
    if (index == 1) {
        ZMPopCommentView *view = [ZMPopCommentView initFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight - 150) count:[self.model.counter.comment integerValue] aid:self.model.article_info.aid uid:self.model.user_info.uid];
        view.showCornerRadius = YES;
        [view show:YES];
    }
    
}

- (void)setModel:(ZMRecommendModel *)model{
    _model = model;
    self.profileView.user = model.user_info;
    self.mainContentView.model = model.article_info;
    self.operationView.count = model.counter;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.mainView.frame = CGRectMake(0, 0, kScreenWidth, self.height - 10);
    self.profileView.frame = CGRectMake(0, 0, kScreenWidth, 75);
    self.mainContentView.width = self.width;
    self.mainContentView.height = self.model.article_info.mainContentHeight;
    self.mainContentView.left = 0;
    self.mainContentView.top = self.profileView.bottom;
    
    self.operationView.width = self.width;
    self.operationView.height = self.model.counter.operationHeight;
    self.operationView.left = 0;
    self.operationView.top = self.mainContentView.bottom;
    
}

@end

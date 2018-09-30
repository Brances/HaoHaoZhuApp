//
//  ZMOperationView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMOperationView.h"

@implementation ZMOperationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.tag = 0;
    [self.shareBtn setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [self addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(clickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.likeBtn = [[ZMOperationButton alloc] initWithFrame:CGRectZero icon:@"ich_nice_n" type:3] ;
    self.likeBtn.tag = 3;
    [self addSubview:self.likeBtn];
    [self.likeBtn addTarget:self action:@selector(clickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectBtn = [[ZMOperationButton alloc] initWithFrame:CGRectZero icon:@"collect_water" type:2];
    self.collectBtn.tag = 2;
    [self addSubview:self.collectBtn];
    [self.collectBtn addTarget:self action:@selector(clickOperationButton:) forControlEvents:UIControlEventTouchUpInside];

    self.commentBtn = [[ZMOperationButton alloc] initWithFrame:CGRectZero icon:@"node_Talk" type:1];
    self.commentBtn.tag = 1;
    [self addSubview:self.commentBtn];
    [self.commentBtn addTarget:self action:@selector(clickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setCount:(ZMCounter *)count{
    _count = count;
    self.likeBtn.counter = count;
    self.collectBtn.counter = count;
    self.commentBtn.counter = count;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.shareBtn.size = CGSizeMake(50, 40);
    self.shareBtn.left = 5;
    self.shareBtn.top = (self.height - self.shareBtn.height) * 0.5;
    
    //计算大小
    self.likeBtn.width = self.count.likeW;
    self.likeBtn.height = self.height;
    self.likeBtn.left = self.width - self.likeBtn.width - 20;
    self.likeBtn.top = (self.height - self.likeBtn.height) * 0.5;
    
    self.collectBtn.width = self.count.favoriteW;
    self.collectBtn.height = self.height;
    self.collectBtn.left = self.likeBtn.left - self.collectBtn.width - 10;
    self.collectBtn.top = (self.height - self.collectBtn.height) * 0.5;
    
    self.commentBtn.width = self.count.commentW;
    self.commentBtn.height = self.height;
    self.commentBtn.left = self.collectBtn.left - self.commentBtn.width - 10;
    self.commentBtn.top = (self.height - self.commentBtn.height) * 0.5;
    
}

#pragma mark - 点击了按钮
- (void)clickOperationButton:(UIButton *)btn{
    NSInteger tag = btn.tag;
    if (tag == 0) {
        HBLog(@"分享");
    }else if (tag == 1){
        HBLog(@"评论");
    }else if (tag == 2){
        HBLog(@"收藏");
    }else if (tag == 3){
        HBLog(@"喜欢");
    }
    
}

@end

@implementation ZMOperationButton

- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon type:(NSInteger)type{
    if (self = [super initWithFrame:frame]) {
        NSAssert(icon.length, @"图标不能为空");
        _iconName = icon;
        _type = type;
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.iconName]];
    [self addSubview:self.iconView];
    
    self.bageLabel = [UILabel new];
    self.bageLabel.font = [UIFont systemFontOfSize:11];
    self.bageLabel.textColor = [ZMColor appSubColor];
    [self addSubview:self.bageLabel];
    
}

- (void)setCounter:(ZMCounter *)counter{
    _counter = counter;
    if (_type == 1) {
        self.bageLabel.text = counter.comment;
    }else if (_type == 2){
        self.bageLabel.text = counter.favorite;
    }else{
        self.bageLabel.text = counter.like;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_counter) return;
    if (self.type == 1) {
        self.iconView.left = self.counter.commentX;
    }else if (self.type == 2) {
        self.iconView.left = self.counter.favoriteX;
    }else if (self.type == 3) {
        self.iconView.left = self.counter.likeX;
    }
    self.iconView.top = (self.height - self.iconView.height) * 0.5;
    [self.bageLabel sizeToFit];
    self.bageLabel.left = self.iconView.right + self.counter.marginSpace;
    self.bageLabel.top = self.iconView.top - self.bageLabel.height * 0.5;
    
}

@end

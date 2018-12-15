//
//  ZMPopCommentView.m
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/10/11.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMPopCommentView.h"

@interface ZMPopCommentView()

@property (nonatomic, strong) UIView       *contentView;
@property (nonatomic, strong) UIButton    *backgroundButton;
@property (nonatomic, assign) CGFloat      contentHeight;
@property (nonatomic, strong) UIView        *tableView;

@end

@implementation ZMPopCommentView
{
    CGFloat kAnimationDuration;
    BOOL    kActionSheetShowing;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        kAnimationDuration = 0.1;
        kActionSheetShowing = NO;
        self.contentHeight = frame.size.height;
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    self.backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundButton.backgroundColor = [UIColor colorWithWhite:0.000 alpha:1];
    self.backgroundButton.alpha = 0.0;
    self.backgroundButton.frame = [UIScreen mainScreen].bounds;
    [self.backgroundButton addTarget:self action:@selector(backgroundButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backgroundButton];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.contentView = [[UIView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, 0}];
    self.contentView.backgroundColor = [ZMColor appBgGrayColor];
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    self.contentView.height = self.contentHeight;
    self.contentView.top = kScreenHeight;
    
}

#pragma mark - Private Action

- (void)backgroundButtonPressed {
    [self hide:YES];
}

- (void)show:(BOOL)animated{
    kActionSheetShowing = YES;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    void (^showBlock)() = ^{
        self.hidden = NO;
        self.backgroundButton.alpha = 0.0f;
        [window bringSubviewToFront:self];
        if (animated) {
            [UIView animateWithDuration:kAnimationDuration + (self.contentHeight / 100) * 0.1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.2 options:UIViewAnimationOptionCurveLinear animations:^{
                self.backgroundButton.alpha = 0.5f;
                self.contentView.top = kScreenHeight - self.contentHeight;
            } completion:nil];
        } else {
            self.backgroundButton.alpha = 0.5f;
            self.contentView.top = kScreenHeight - self.contentHeight;
        }
        
//    };
}

- (void)hide:(BOOL)animated{
    kActionSheetShowing = NO;
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration + (self.contentHeight / 120) * 0.1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundButton.alpha = 0.0f;
            self.contentView.top = kScreenHeight;
        } completion:^(BOOL finished) {
            self.hidden = YES;
            [self removeFromSuperview];
        }];
    } else {
        self.backgroundButton.alpha = 0.0f;
        self.contentView.top = kScreenHeight;
        self.hidden = YES;
        [self removeFromSuperview];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)dealloc{
    HBLog(@"%@安全释放",NSStringFromClass([self class]));
    
}

@end

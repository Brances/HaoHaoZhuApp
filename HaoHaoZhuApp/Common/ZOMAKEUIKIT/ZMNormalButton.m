//
//  ZMNormalButton.m
//  delivelyuser
//
//  Created by Brances on 2018/6/29.
//  Copyright © 2018年 HBL. All rights reserved.
//

#import "ZMNormalButton.h"

@implementation ZMNormalButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title{
    ZMNormalButton *btn = [ZMNormalButton buttonWithType:buttonType];
    btn.frame = frame;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btn setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage imageNamed:@"button-normal-bg"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"button-disable-bg"] forState:UIControlStateDisabled];
    [btn addTarget:btn action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    if (title.length) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateDisabled];
    }else{
        [btn setTitle:@"按钮" forState:UIControlStateNormal];
    }
    return btn;
}


//- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
//    if (self = [super initWithFrame:frame]) {
//        self = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//
//        [self setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
//        self.adjustsImageWhenHighlighted = NO;
//        [self setImage:[UIImage imageNamed:@"button-normal-bg"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"button-disable-bg"] forState:UIControlStateDisabled];
//        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
//        if (title.length) {
//            [self setTitle:title forState:UIControlStateNormal];
//            [self setTitle:title forState:UIControlStateDisabled];
//        }else{
//            [self setTitle:@"按钮" forState:UIControlStateNormal];
//        }
//        self.titleLabel.text = @"保存";
//    }
//    return self;
//}

#pragma mark - 点击按钮
- (void)clickButton:(UIButton *)btn{
    if (self.didTapButton) {
        self.didTapButton(self);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end

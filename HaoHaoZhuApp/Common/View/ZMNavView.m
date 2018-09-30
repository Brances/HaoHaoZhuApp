//
//  ZMNavView.m

//
//  Created by Brances on 2018/5/21.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMNavView.h"

@implementation ZMNavView

#pragma mark - 主视图
- (UIView *)mainView{
    if (!_mainView) {
        UIView *mainView = [[UIView alloc] init];
        //mainView.backgroundColor = [ZMColor whiteColor];
        self.mainView = mainView;
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)cover{
    if (!_cover) {
        _cover = [[UIImageView alloc] init];
        //[self addSubview:_cover];
        [self insertSubview:_cover atIndex:0];
        _cover.frame = self.frame;
    }
    return _cover;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [leftButton setImage:[UIImage imageNamed:@"navgation-back-black"] forState:UIControlStateNormal];
        leftButton.adjustsImageWhenHighlighted = NO;
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [leftButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        //[leftButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:leftButton];
        self.leftButton = leftButton;
    }
    return _leftButton;
}
//左边第二个按钮
- (UIButton *)leftTwoButton{
    if (!_leftTwoButton) {
        UIButton *leftTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftTwoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        leftTwoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [leftTwoButton setTitleColor:[ZMColor colorWithHexString:@"#92908E"] forState:UIControlStateNormal];
        leftTwoButton.titleEdgeInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
        [self.mainView addSubview:leftTwoButton];
        self.leftTwoButton = leftTwoButton;
        
        [leftTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftButton.mas_right).with.offset(2);
            make.size.mas_equalTo(CGSizeMake(40, self.height));
            make.top.mas_equalTo(self.mainView.top).with.offset(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _leftTwoButton;
}

- (UIButton *)rightButton{
    
    if (!_rightButton) {
        //右边按钮
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        rightButton.adjustsImageWhenHighlighted = NO;
        [rightButton setTitleColor:[ZMColor appMainTextColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:rightButton];
        self.rightButton = rightButton;
    }
    return _rightButton;
}

- (UIButton *)centerButton{
    if (!_centerButton) {
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        centerButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [centerButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        self.centerButton = centerButton;
        [self.mainView addSubview:centerButton];
    }
    return _centerButton;
}

-  (UILabel *)bottomLineLabel{
    if (!_bottomLineLabel) {
        _bottomLineLabel = [UILabel new];
        _bottomLineLabel.hidden = YES;
        _bottomLineLabel.backgroundColor = [ZMColor appBorderColor];
        [self.mainView addSubview:_bottomLineLabel];
    }
    return _bottomLineLabel;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置UI
- (void)setupUI{
    [self mainView];
    [self leftButton];
    //[self bottomLineLabel];
}
- (void)setCenterButtonTitle:(NSString *)centerButtonTitle{
    if (centerButtonTitle.length) {
        [self.centerButton setTitle:centerButtonTitle forState:UIControlStateNormal];
    }
}
- (void)setRightButtonTitle:(NSString *)rightButtonTitle{
    if (rightButtonTitle.length) {
        [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    }
}

- (void)setIsHaveLine:(BOOL)isHaveLine{
    _isHaveLine = isHaveLine;
    self.bottomLineLabel.hidden = !isHaveLine;
}

#pragma mark - public
//- (void)clickLeftButton:(UIButton *)btn{
//    if (self.leftButtonBlock) {
//        self.leftButtonBlock();
//    }
//}

- (void)clickRightButton:(UIButton *)btn{
    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.leftButton.width = 50;
    self.leftButton.height = self.mainView.height - UIView.sc_statusBarHeight;
    self.leftButton.left = 0;
    self.leftButton.top = UIView.sc_statusBarHeight;
    
    self.centerButton.width = self.width - (self.leftButton.width + 38) * 2;
    self.centerButton.height = self.mainView.height - UIView.sc_statusBarHeight;
    self.centerButton.centerX = self.mainView.centerX;
    self.centerButton.top = UIView.sc_statusBarHeight;
    
    self.rightButton.width = 50;
    self.rightButton.height = self.mainView.height - UIView.sc_statusBarHeight;
    self.rightButton.left = self.mainView.width - self.rightButton.width - 10;
    self.rightButton.top = UIView.sc_statusBarHeight;
    
    self.bottomLineLabel.width = self.mainView.width;
    self.bottomLineLabel.height =1.0/ [UIScreen mainScreen].scale;
    self.bottomLineLabel.left = 0;
    self.bottomLineLabel.top = self.mainView.height - self.bottomLineLabel.height;
    
}

@end

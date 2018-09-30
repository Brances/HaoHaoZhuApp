//
//  ZMSearchView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMSearchView.h"

@implementation ZMSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.mainView = [UIView new];
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 3;
    self.mainView.backgroundColor = [ZMColor appBgGrayColor];
    [self addSubview:self.mainView];
    
    self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    [self.mainView addSubview:self.iconView];
    
    self.textField = [UITextField new];
    self.textField.delegate = self;
    self.textField.font = [ZMFont defaultAppFontWithSize:14];
    self.textField.textColor = [ZMColor blackColor];
    self.textField.tintColor = [ZMColor appMainThemeColor];
    [self.mainView addSubview:self.textField];
    [self.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cleanBtn setImage:[UIImage imageNamed:@"icon_search_delete"] forState:UIControlStateNormal];
    [self.mainView addSubview:self.cleanBtn];
    self.cleanBtn.hidden = YES;
    [self.cleanBtn addTarget:self action:@selector(cleanAll) forControlEvents:UIControlEventTouchUpInside];
    
    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverBtn.backgroundColor = [ZMColor clearColor];
    [self.mainView addSubview:self.coverBtn];
    [self.coverBtn addTarget:self action:@selector(clickPushButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainView.frame = CGRectMake(0, 0, self.width, self.height);
    self.iconView.left = 15;
    self.iconView.top = (self.mainView.height - self.iconView.height) * 0.5;
    
    self.cleanBtn.height = self.height;
    self.cleanBtn.width = self.cleanBtn.height;
    self.cleanBtn.left = self.mainView.width - self.cleanBtn.width;
    self.cleanBtn.top = 0;
    
    self.textField.width = self.mainView.width - self.iconView.right - 10 - self.cleanBtn.width;
    self.textField.height = self.mainView.height;
    self.textField.left = self.iconView.right + 10;
    self.textField.top = 0;

    self.coverBtn.frame = self.textField.frame;
    
}

- (void)setText:(NSString *)text{
    if (!text.length) return;
    _text = text;
    self.textField.text = text;
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    if (!placeHolder.length) return;
    _placeHolder = placeHolder;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:[ZMColor appSubColor],NSFontAttributeName:self.textField.font}];
    self.textField.attributedPlaceholder = attr;
}

- (void)textDidChange:(UITextField *)field{
    self.cleanBtn.hidden = field.text.length ? NO : YES;
}

- (void)cleanAll{
    self.textField.text = @"";
    self.cleanBtn.hidden = YES;
}

- (void)setEnable:(BOOL)enable{
    self.textField.userInteractionEnabled = enable;
    self.coverBtn.hidden = enable;
}

#pragma mark - 跳转页面
- (void)clickPushButton:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedPushButton)]) {
        [self.delegate didSelectedPushButton];
    }else if (self.didClickButtonBlock){
        self.didClickButtonBlock(btn);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end

@implementation ZMSearchViewContainer

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.backgroundColor = [ZMColor whiteColor];
    self.view = [[ZMSearchView alloc] initWithFrame:CGRectMake(20, (self.height - 34) * 0.5, kScreenWidth - 20 * 2, 34)];
    [self addSubview:self.view];
}

@end


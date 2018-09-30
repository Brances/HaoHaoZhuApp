//
//  ZMCategoryScrollView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMCategoryScrollView.h"

@implementation ZMCategoryScrollView

//- (NSMutableArray *)buttonArray{
//    if (!_buttonArray) {
//        _buttonArray = [NSMutableArray new];
//    }
//    return _buttonArray;
//}

- (instancetype)initWithFrame:(CGRect)frame cate:(ZMCategoryTypeModel *)cate{
    if (self = [super initWithFrame:frame]) {
        _cateModel = cate;
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
//    self.backgroundColor = [ZMColor randomColor];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    CGFloat buttonWidth = 30,buttomMarginLeft = 20;
    self.selectedColor = [ZMColor colorWithHexString:@"#EFEFEF"];
    self.unSelectedColor = [ZMColor clearColor];
    //初始化按钮
    NSInteger count = self.cateModel.option_list.count;
    
    UIButton *lastButton;
    for (int i = 0; i < count; i++) {
        ZMCategoryItemModel *model = [self.cateModel.option_list safeObjectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.layer.cornerRadius = 13;
        btn.titleLabel.font = [ZMFont defaultAppFontWithSize:12];
        [btn setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.width = [ZMHelpUtil widthForString:model.name font:[ZMFont defaultAppFontWithSize:12]] + buttonWidth;
        btn.height = self.height - 8;
        btn.top = (self.height - btn.height) * 0.5;
        if (lastButton) {
            btn.left = lastButton.right;
        }else{
            btn.backgroundColor = self.selectedColor;
            btn.left = buttomMarginLeft;
            self.selectedButton = btn;
        }
        if (i == count - 1) {
            self.contentSize = CGSizeMake(btn.right + buttomMarginLeft, 0);
        }
        [self addSubview:btn];
//        [self.buttonArray addObject:btn];
        lastButton = btn;
    }
    
}

- (void)clickButton:(UIButton *)btn{
    if ([self.selectedButton isEqual:btn]) return;
    self.selectedButton.backgroundColor = self.unSelectedColor;
    btn.backgroundColor = self.selectedColor;
    self.selectedButton = btn;
    ZMCategoryItemModel *model = [self.cateModel.option_list objectAtIndex:btn.tag];
    self.selectedItemModel = model;
    if (self.delegates && [self.delegates respondsToSelector:@selector(didSelected:item:)]) {
        [self.delegates didSelected:self item:model];
    }
}

@end

@implementation ZMAdvertScrollView

- (instancetype)initWithFrame:(CGRect)frame advertArray:(NSArray<ZMAdvertItemModel *> *)advertArray{
    if (self = [super initWithFrame:frame]) {
        _advertArray = advertArray;
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    
    NSInteger count = self.advertArray.count;
    CGFloat marginSpace = 12,marginLeft = 20;
    UIImageView *lastView;
    for (int i = 0; i < count; i++) {
        ZMAdvertItemModel *model = [self.advertArray safeObjectAtIndex:i];
        ZMImageView *image = [ZMImageView new];
        
        image.width = model.image.width;
        image.height = model.image.height;
        if (lastView) {
            image.left = lastView.right + marginSpace;
        }else{
            image.left = marginLeft;
        }
        [self addSubview:image];
        image.top = (self.height - image.height) * 0.5;
        if (i == count - 1) {
            self.contentSize = CGSizeMake(image.right + marginLeft, 0);
        }
        lastView = image;
//        [image setImageWithURL:[NSURL URLWithString:model.banner] placeholder:placeholderAvatarImage];
        [image setAnimationLoadingImage:[NSURL URLWithString:model.banner] placeholder:placeholderAvatarImage];
    }
    
}

@end



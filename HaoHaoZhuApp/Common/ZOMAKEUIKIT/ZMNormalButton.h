//
//  ZMNormalButton.h
//  delivelyuser
//
//  Created by Brances on 2018/6/29.
//  Copyright © 2018年 HBL. All rights reserved.
//  渐变按钮

#import <UIKit/UIKit.h>

@interface ZMNormalButton : UIButton

@property (nonatomic, copy) void(^didTapButton)(UIButton *btn);

//- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title;

@end

//
//  ZMOperationView.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/26.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMCounter.h"
@class ZMOperationButton;
@interface ZMOperationView : UIView

@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) ZMOperationButton *commentBtn;
@property (nonatomic, strong) ZMOperationButton *collectBtn;
@property (nonatomic, strong) ZMOperationButton *likeBtn;
@property (nonatomic, strong) ZMCounter     *count;
@property (nonatomic, copy) void(^didTapBtn)(NSInteger index);

@end

@interface ZMOperationButton : UIButton

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, copy) NSString          *iconName;

@property (nonatomic, strong) UILabel          *bageLabel;
@property (nonatomic, copy) NSString           *bage;
@property (nonatomic, strong) ZMCounter *counter;
@property (nonatomic, assign) NSInteger     type;
- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon type:(NSInteger)type;

@end

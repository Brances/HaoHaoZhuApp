//
//  ZMHomeFollowView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHomeFollowView.h"

@interface ZMHomeFollowView()



@end

@implementation ZMHomeFollowView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.backgroundColor = [ZMColor colorWithHexString:@"#FF69B4"];
}

@end

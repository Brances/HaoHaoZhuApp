//
//  ZMMeViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMMeViewController.h"

@interface ZMMeViewController ()

@end

@implementation ZMMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.centerButton setTitle:@"我的" forState:UIControlStateNormal];
    //    [self.navView.leftButton setImage:[UIImage imageNamed:@"icon_uniform_back_b"] forState:UIControlStateNormal];
//    [self.navView.rightButton setImage:[UIImage imageNamed:@"ich_search"] forState:UIControlStateNormal];
    self.navView.isHaveLine = YES;
}


@end

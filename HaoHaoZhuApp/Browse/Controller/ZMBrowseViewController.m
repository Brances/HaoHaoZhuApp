//
//  ZMBrowseViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBrowseViewController.h"

@interface ZMBrowseViewController ()

@end

@implementation ZMBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.centerButton setTitle:@"看图" forState:UIControlStateNormal];
    //    [self.navView.leftButton setImage:[UIImage imageNamed:@"icon_uniform_back_b"] forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"ich_search"] forState:UIControlStateNormal];
    self.navView.isHaveLine = YES;
}

@end

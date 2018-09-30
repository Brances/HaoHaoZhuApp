//
//  ZMShopViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMShopViewController.h"
#import "ZMSearchView.h"
#import "ZMSearchKeywordViewController.h"

@interface ZMShopViewController ()

@property (nonatomic, strong) ZMSearchView          *searchView;

@end

@implementation ZMShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];;
}

- (void)setupNavView{
    [super setupNavView];
    self.navView.isHaveLine = YES;
    self.searchView = [[ZMSearchView alloc] initWithFrame:CGRectMake(20, self.navView.height - 34 - 5, self.navView.width - 20 - 80, 34)];
    self.searchView.enable = NO;
    self.searchView.placeHolder = @"大家都在搜：黄铜";
    [self.navView addSubview:self.searchView];
    @weakify(self);
    self.searchView.didClickButtonBlock = ^(UIButton *btn) {
        HBLog(@"已经点击了按钮啊");
        ZMSearchKeywordViewController *vc = [[ZMSearchKeywordViewController alloc] init];
        vc.keyword = @"网红绿植";
        [weak_self.navigationController pushViewController:vc animated:NO];
    };
}

@end

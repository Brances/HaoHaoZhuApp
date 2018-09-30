//
//  ZMTabBarViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMTabBarViewController.h"
#import "ZMCustomNavViewController.h"
#import "ZMHomeViewController.h"
#import "ZMShopViewController.h"
#import "ZMBeautyViewController.h"
#import "ZMBrowseViewController.h"
#import "ZMMeViewController.h"

@interface ZMTabBarViewController ()

@end

@implementation ZMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页
    [self addChildVc:[ZMHomeViewController new] title:@"" image:@"tab_home_n" selectedImage:@"tab_home_s"];
    //装修
    [self addChildVc:[ZMBeautyViewController new] title:@"" image:@"tab_decorate_n" selectedImage:@"tab_decorate_s"];
    //商店
    [self addChildVc:[ZMShopViewController new] title:@"" image:@"tab_mall_n" selectedImage:@"tab_mall_s"];
    //看图
    [self addChildVc:[ZMBrowseViewController new] title:@"" image:@"tab_browsing_n" selectedImage:@"tab_browsing_s"];
    //我的
    [self addChildVc:[ZMMeViewController new] title:@"" image:@"tab_me_n" selectedImage:@"tab_me_s"];
    //关闭黑色边框设置阴影，并设置tabbar背景颜色和透明度
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
    self.tabBar.layer.shadowOpacity = 0.3;
    [[UITabBar appearance] setBackgroundImage:[YYImage imageWithColor:[ZMColor colorWithHexString:@"#FFFFFF" alpha:0.9]]];
    
#if DEBUG
    //显示当前帧率
    [self setupFPSLabel];
#endif
    
}

#pragma mark -    FPS Label 显示当前帧率
- (void)setupFPSLabel{
    YYFPSLabel *label = [[YYFPSLabel alloc] init];
    label.frame = CGRectMake(10, kScreenHeight - 49 - 30 - 10, 60, 30);
    [self.view addSubview:label];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
#pragma mark - 添加子控制器
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ZMCustomNavViewController *nav = [[ZMCustomNavViewController alloc]initWithRootViewController:childVc];
    
    //设置item按钮
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 5)];
    [nav.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    // 添加子控制器
    [self addChildViewController:nav];
}

@end

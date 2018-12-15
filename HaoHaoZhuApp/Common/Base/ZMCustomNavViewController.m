//
//  CustomNavViewController.m
//  HappyVote
//
//  Created by  on 16/1/13.
//  Copyright © 2016年 . All rights reserved.
//

#import "ZMCustomNavViewController.h"

@interface ZMCustomNavViewController ()

@end

@implementation ZMCustomNavViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //状态栏的颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - delegate
/** UINavigationControllerDelegate */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.topViewController isKindOfClass:[viewController class]]) {
        return;
    }
    if (self.viewControllers.count > 0) { //非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    // 修正push控制器tabbar上移问题
    
    if (@available(iOS 11.0, *)){
        
        // 修改tabBra的frame
        
        CGRect frame = self.tabBarController.tabBar.frame;
        
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        
        self.tabBarController.tabBar.frame = frame;
        
    }
}

@end

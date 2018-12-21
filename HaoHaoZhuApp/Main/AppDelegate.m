//
//  AppDelegate.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

//@property (nonatomic, strong) ZMTabBarViewController *mainViewController;

@property (strong, nonatomic)UIVisualEffectView *visualEffectView;

@end

@implementation AppDelegate

- (UIVisualEffectView *)visualEffectView{
    
    if (!_visualEffectView) {
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
        _visualEffectView.frame = [UIScreen mainScreen].bounds;
        
    }
    
    return _visualEffectView;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[ZMSettingManager shareInstance] configure];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ZMTabBarViewController *vc = [[ZMTabBarViewController alloc] init];
    self.mainViewController.selectedIndex = 0;
    self.window.rootViewController = vc;
    self.mainViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication].keyWindow addSubview:self.visualEffectView];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    if (_visualEffectView) {
        [self.visualEffectView removeFromSuperview];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (_visualEffectView) {
        [self.visualEffectView removeFromSuperview];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {}


@end

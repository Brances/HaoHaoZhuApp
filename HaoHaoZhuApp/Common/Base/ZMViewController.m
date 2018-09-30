//
//  ZMViewController.m

//
//  Created by Brances on 2018/3/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMViewController.h"
#if DEBUG
#import "FLEXManager.h"
#endif

@interface ZMViewController ()<ZMNetWorkManagerDelegate>


@end

@implementation ZMViewController

-(ZMNavView *)navView{
    if (!_navView) {
        ZMNavView *navView = [[ZMNavView alloc] init];
        [self.view addSubview:navView];
        navView.backgroundColor = [UIColor whiteColor];
        self.navView = navView;
        self.navView.frame = CGRectMake(0, 0, kScreenWidth, 44 + UIView.sc_statusBarHeight);
        [navView.leftButton addTarget:self action:@selector(clickPopViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.navView.superview layoutIfNeeded];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ZMColor whiteColor];
    //禁止自动布局
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    //隐藏自带的导航栏
    self.navigationController.navigationBar.hidden = YES;
    [[ZMNetWorkManager shareManager] addDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}
#pragma mark - public
- (void)setupNavView{
    [self navView];
}

- (void)clickPopViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#if DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [super motionBegan:motion withEvent:event];
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] toggleExplorer];
    }
}

- (void)dealloc{
    HBLog(@"当前控制器%@已经释放了",NSStringFromClass([self class]));
    [[ZMNetWorkManager shareManager] removeDelegate:self];
}

#endif

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

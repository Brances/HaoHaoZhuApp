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
    //去掉tabbar的透明度
//    [[UITabBar appearance] setTranslucent:NO];
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



@implementation ZMTabBar

//以下两个方法解决ios12.1tabbar图标位移问题，如以后IOS12.1解决则可移除
/**
 *  用 block 重写某个 class 的指定方法
 *  @param targetClass 要重写的 class
 *  @param targetSelector 要重写的 class 里的实例方法，注意如果该方法不存在于 targetClass 里，则什么都不做
 *  @param implementationBlock 该 block 必须返回一个 block，返回的 block 将被当成 targetSelector 的新实现，所以要在内部自己处理对 super 的调用，以及对当前调用方法的 self 的 class 的保护判断（因为如果 targetClass 的 targetSelector 是继承自父类的，targetClass 内部并没有重写这个方法，则我们这个函数最终重写的其实是父类的 targetSelector，所以会产生预期之外的 class 的影响，例如 targetClass 传进来  UIButton.class，则最终可能会影响到 UIView.class），implementationBlock 的参数里第一个为你要修改的 class，也即等同于 targetClass，第二个参数为你要修改的 selector，也即等同于 targetSelector，第三个参数是 targetSelector 原本的实现，由于 IMP 可以直接当成 C 函数调用，所以可利用它来实现“调用 super”的效果，但由于 targetSelector 的参数个数、参数类型、返回值类型，都会影响 IMP 的调用写法，所以这个调用只能由业务自己写。
 */
CG_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 12.1, *)) {
            OverrideImplementation(NSClassFromString(@"UITabBarButton"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP originIMP) {
                return ^(UIView *selfObject, CGRect firstArgv) {
                    
                    if ([selfObject isKindOfClass:originClass]) {
                        // 如果发现即将要设置一个 size 为空的 frame，则屏蔽掉本次设置
                        if (!CGRectIsEmpty(selfObject.frame) && CGRectIsEmpty(firstArgv)) {
                            return;
                        }
                    }
                    
                    // call super
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                };
            });
        }
    });
}

@end

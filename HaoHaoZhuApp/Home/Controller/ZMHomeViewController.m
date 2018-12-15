//
//  ZMHomeViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHomeViewController.h"
#import "ZMHomeTopNavView.h"
#import "ZMHomeTabView.h"
#import "ZMHomeFollowView.h"
#import "ZMHomeRecommendView.h"
#import "ZMHomeModel.h"
#import "ZMSearchKeywordViewController.h"

@interface ZMHomeViewController ()<UIScrollViewDelegate,ZMHomeTabViewDelegate>

@property (nonatomic, strong) ZMHomeTopNavView             *nav;
@property (nonatomic, weak) ZMHomeTabView                    *tabView;
@property (nonatomic, strong) ZMSearchViewContainer         *search;
@property (nonatomic, strong) UIScrollView                          *scrollView;
@property (nonatomic, strong) ZMHomeFollowView              *followView;
@property (nonatomic, strong) ZMHomeRecommendView    *recommendView;

@end

@implementation ZMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI{
    self.nav = [[ZMHomeTopNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, UIView.sc_statusBarHeight + 44)];
    [self.view addSubview:self.nav];
    
    self.search = [[ZMSearchViewContainer alloc] initWithFrame:CGRectMake(0, self.nav.bottom, kScreenWidth, 64)];
    self.search.view.enable = NO;
    self.search.view.placeHolder = @"大家都在搜：网红绿植";
    [self.view addSubview:self.search];
    @weakify(self);
    self.search.view.didClickButtonBlock = ^(UIButton *btn) {
        HBLog(@"已经点击了按钮");
        ZMSearchKeywordViewController *vc = [[ZMSearchKeywordViewController alloc] init];
        vc.keyword = @"网红绿植";
        [weak_self.navigationController pushViewController:vc animated:NO];
    };
    
    self.scrollView = [UIScrollView new];
    self.scrollView.frame = CGRectMake(0, self.search.bottom, kScreenWidth, kScreenHeight - self.nav.height - self.search.height);
        self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    [self.view addSubview:self.scrollView];
    
    
    ZMHomeTabView *tabView = [[ZMHomeTabView alloc] initWithFrame:CGRectMake((self.nav.width - 105) * 0.5, self.nav.leftBtn.top, 105, self.nav.leftBtn.height)];
    [tabView setItems:@[@"关注",@"推荐"] selectedItemIndex:1];
    tabView.delegate = self;
    tabView.bridgeScrollView = self.scrollView;
    [self.nav addSubview:tabView];
    _tabView = tabView;
    
    self.followView = [[ZMHomeFollowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scrollView.height)];
    [self.scrollView addSubview:self.followView];
    
    self.recommendView = [[ZMHomeRecommendView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.height)];
    [self.scrollView addSubview:self.recommendView];
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > kScreenWidth) {
        [scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
        return;
    }
    if (scrollView.contentOffset.x < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        return;
    }

}

#pragma mark - ZMHomeTabViewDelegate
- (void)itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    HBLog(@"已经点击了页面fromIndex = %ld,toIndex = %ld",fromIndex,toIndex);
    self.scrollView.contentOffset = CGPointMake(toIndex * kScreenWidth, 0);
}

- (void)dealloc{
    HBLog(@"释放了");
}

@end

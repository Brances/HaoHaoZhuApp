//
//  ZMHouseExampleViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHouseExampleViewController.h"
#import "ZMCategoryTypeModel.h"
#import "ZMCategoryScrollView.h"
#import "ZMAdvertItemModel.h"
#import "ZMHouseExampleCell.h"

@interface ZMHouseExampleViewController ()<UITableViewDataSource,UITableViewDelegate,ZMCategoryScrollViewDelegate>

@property (nonatomic, strong) YYTableView                                               *tableView;
@property (nonatomic, strong) UIView                                                        *headView;
@property (nonatomic, strong) ZMAdvertScrollView                                    *bannerView;
@property (nonatomic, strong) NSMutableArray<ZMCategoryTypeModel *> *cateArray;
@property (nonatomic, strong) NSMutableArray<ZMCategoryScrollView *>                 *scrollViewArray;
@property (nonatomic, strong) NSMutableArray<ZMAdvertItemModel *>       *advertArray;
@property (nonatomic, strong) ZMHouseExampleListModel                           *exampleList;
@property (nonatomic, weak) UIButton              *floatButton;
@property (nonatomic, assign) BOOL              isFloat;
@property (nonatomic, assign) CGFloat           distanceY;
@property (nonatomic, strong) NSMutableDictionary    *filterDic;
@property (nonatomic, copy) NSString *seletedTag;

@end

@implementation ZMHouseExampleViewController
{
    CGFloat     marginTop,marginSpace,scrollHeight;
    NSInteger  page;
}

- (UIButton *)floatButton{
    if (!_floatButton) {
        UIButton  *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.hidden = YES;
        if (self.seletedTag.length) {
            [btn setTitle:self.seletedTag forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"筛选" forState:UIControlStateNormal];
        }
        [btn setImage:[UIImage imageNamed:@"icon_expend"] forState:UIControlStateNormal];
        btn.titleLabel.font = [ZMFont boldGothamWithSize:10];
        [btn setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, self.navView.bottom, kScreenWidth, 35);
        btn.backgroundColor = [ZMColor whiteColor];
        [self.view addSubview:btn];
        [self.view bringSubviewToFront:btn];
        [btn addTarget:self action:@selector(clickFloatButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, - btn.imageView.image.size.width, 0, btn.imageView.image.size.width)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
        
        _floatButton = btn;
    }
    return _floatButton;
}

- (ZMHouseExampleListModel *)exampleList{
    if (!_exampleList) {
        _exampleList = [[ZMHouseExampleListModel alloc] init];
    }
    return _exampleList;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = [ZMColor whiteColor];
//        [self.view addSubview:self.headView];
        self.headView.width = kScreenWidth;
        self.headView.height = marginTop + self.cateArray.count * scrollHeight + marginSpace * (self.cateArray.count - 1) + marginTop;
        self.headView.left = 0;
        self.headView.top = self.navView.bottom;
        
        UIView  *line = [UIView new];
        line.backgroundColor = [ZMColor appBgGrayColor];
        line.width = kScreenWidth;
        line.height = 0.5;
        line.top = self.headView.height - line.height;
        line.left = 0;
        [self.headView addSubview:line];
        
        //设置滚动容器
        NSMutableArray *temp = [NSMutableArray new];
        ZMCategoryScrollView *lastView;
        for (int i = 0; i < self.cateArray.count; i++) {
            ZMCategoryTypeModel *model = [self.cateArray safeObjectAtIndex:i];
            CGFloat y;
            if (lastView) {
                y = lastView.bottom + marginSpace;
            }else{
                y = marginTop;
            }
            ZMCategoryScrollView *scrollView = [[ZMCategoryScrollView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, scrollHeight) cate:model];
            scrollView.delegates = self;
            lastView = scrollView;
            [self.headView addSubview:scrollView];
            [temp addObject:scrollView];
        }
        self.scrollViewArray = temp;
    }
    return _headView;
}

- (ZMAdvertScrollView *)bannerView{
    if (!_bannerView) {
        ZMAdvertItemModel *model = [self.advertArray safeObjectAtIndex:0];
        _bannerView = [[ZMAdvertScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, model.image.height + 30 * 2) advertArray:self.advertArray];
        _bannerView.backgroundColor = [ZMColor whiteColor];
    }
    return _bannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterDic = [NSMutableDictionary dictionary];
    marginTop = 10;
    marginSpace = 5;
    scrollHeight = 35;
    page = 1;
    [self setupNavView];
    [self requestGroupTask];
}

- (void)setupNavView{
    [super setupNavView];//icon_uniform_back_b   back_no_border
    [self.navView.centerButton setTitle:@"整屋案例" forState:UIControlStateNormal];
    [self.navView.leftButton setImage:[UIImage imageNamed:@"icon_uniform_back_b"] forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"ich_search"] forState:UIControlStateNormal];
    self.navView.isHaveLine = YES;
}

//初始化UI
- (void)configureUI{
    [self.view insertSubview:self.headView  belowSubview:self.navView];
    self.tableView = [[YYTableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kScreenWidth, kScreenHeight - self.navView.bottom) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view insertSubview:self.tableView atIndex:0];
    
    //用一个空的视图表示
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.headView.height)];
    self.tableView.tableHeaderView = view;
    ZMCustomGifFooter *footer = [ZMCustomGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isFloat = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    HBLog(@"移动了距离 = %.2f",distanceY);
    //判断移动了多少距离
    CGFloat distanceY = scrollView.contentOffset.y;
    if (self.isFloat) {
        //为了和原App保持一致效果，当用户点击悬浮按钮之后 让scrollView马上停止滚动，如若想继续滚动，注释代码即可
        scrollView.contentOffset = CGPointMake(0, self.distanceY);
        return;
    }else{
        self.distanceY = distanceY;
        self.headView.top = -distanceY + self.navView.bottom;
    }
    
    if (distanceY >= self.headView.height) {
        self.floatButton.hidden = NO;
    }else{
        self.floatButton.hidden = YES;
    }
}

#pragma mark
- (void)clickFloatButton:(UIButton *)btn{
    self.isFloat = YES;
    btn.hidden = YES;
    self.tableView.contentOffset = CGPointMake(0, self.distanceY);
    self.headView.top = self.navView.bottom;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.bannerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        ZMAdvertItemModel *model = [self.advertArray safeObjectAtIndex:0];
        return model.image.height + 30 * 2;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = _exampleList.articleArray.count == 0;
    return _exampleList.articleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_exampleList.articleArray.count) return 0;
    return [self.exampleList.articleArray objectAtIndex:indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMHouseExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMHouseExampleCell"];
    if (!cell) {
        cell = [[ZMHouseExampleCell alloc] initWithStyle:0 reuseIdentifier:@"ZMHouseExampleCell"];
    }
    cell.model = [self.exampleList.articleArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - ZMCategoryScrollViewDelegate
- (void)didSelected:(ZMCategoryScrollView *)view item:(ZMCategoryItemModel *)item{
    HBLog(@"=%@,=%@",view,item);
    if (item.params.count) {
        NSDictionary *oldValue = [ZMHelpUtil jsonStrinToDictionary:[self.filterDic objectForKey:@"params"]];
        NSMutableDictionary *paramValue = [[NSMutableDictionary alloc] initWithDictionary:oldValue];
        paramValue[@"page"] = @"1";
        for (int i = 0; i < item.params.count; i++) {
            ZMCategoryKeyModel *model = [item.params objectAtIndex:i];
            [paramValue setObject:model.value forKey:model.key];
        }
        //将字典转字符串格式
        NSString *text = [ZMHelpUtil dictionaryToJsonString:paramValue];
        //过滤请求
        NSDictionary *dic = @{@"params":text};
        self.filterDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        page = 1;
        [self requestTask:dic];
    }
    //遍历查询UIScrollView 中选择的按钮
    NSString *title = @"";
    for (ZMCategoryScrollView *cateView in self.scrollViewArray) {
        NSString *selectedText = cateView.selectedItemModel.name;
        if (selectedText.length && cateView.selectedButton.tag != 0) {
            title = [NSString stringWithFormat:@"%@%@ · ",title,selectedText];
        }
    }
    //去掉最后2个字符 多一个空格
    if (title.length >= 2) {
        title = [title substringWithRange:NSMakeRange(0, title.length -2)];
    }
    self.seletedTag = title;
    if (self.seletedTag.length) {
        [self.floatButton setTitle:self.seletedTag forState:UIControlStateNormal];
    }else{
        [self.floatButton setTitle:@"筛选" forState:UIControlStateNormal];
    }
    [self.floatButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.floatButton.imageView.image.size.width, 0, self.floatButton.imageView.image.size.width)];
    [self.floatButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.floatButton.titleLabel.bounds.size.width, 0, -self.floatButton.titleLabel.bounds.size.width)];
}

#pragma mark - 过滤标签请求
- (void)requestTask:(NSDictionary *)param{
    self.isFloat = NO;
    [ZMNetWorkManager requestWithType:Post withUrlString:@"https://yapi.haohaozhu.com/ArticleSelect/getarticle" withParameters:param withSuccessBlock:^(id response) {
        HBLog(@"结果=%@",response);
        if (KVerifyHttpSuccessCode(response)) {
            ZMHouseExampleListModel *model = [[ZMHouseExampleListModel alloc] initWithDictionary:response[@"data"]];
            self.exampleList = model;
            //主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.exampleList.articleArray.count) {
                    //这个is_over并无意义，改成数组数量少于10条的条件
                    if (model.articleArray.count < 10) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else{
                        [self.tableView.mj_footer resetNoMoreData];
                    }
                }
                [self.tableView reloadData];
                [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"%@",error);
    }];
}

#pragma mark - 任务组
- (void)requestGroupTask{
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.全局异步队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //全部分类
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [ZMNetWorkManager requestWithType:Post withUrlString:KAPIExampleCategoryList withParameters:nil withSuccessBlock:^(id response) {
            if (KVerifyHttpSuccessCode(response)) {
                        HBLog(@"结果=%@",response);
                NSArray *list = [ZMHelpUtil arrDispose:response[@"data"]];
                NSMutableArray *temp = [NSMutableArray new];
                for (int i = 0; i < list.count; i++) {
                    NSDictionary *cateDic = [list safeObjectAtIndex:i];
                    ZMCategoryTypeModel *model = [[ZMCategoryTypeModel alloc] initWithDictionary:cateDic];
                    [temp addObject:model];
                }
                self.cateArray = temp;
            }
            dispatch_group_leave(group);
        } withFailureBlock:^(NSError *error) {
            HBLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    //卡片集合
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [ZMNetWorkManager requestWithType:Post withUrlString:KAPIExampleSmallItemList withParameters:nil withSuccessBlock:^(id response) {
                        HBLog(@"结果=%@",response);
            if (KVerifyHttpSuccessCode(response)) {
                NSArray *list = [ZMHelpUtil arrDispose:response[@"data"]];
                NSMutableArray *temp = [NSMutableArray new];
                for (int i = 0; i < list.count; i++) {
                    NSDictionary *advertDic = [list safeObjectAtIndex:i];
                    ZMAdvertItemModel *model = [[ZMAdvertItemModel alloc] initWithDictionary:advertDic];
                    [temp addObject:model];
                }
                self.advertArray = temp;
            }
            dispatch_group_leave(group);
        } withFailureBlock:^(NSError *error) {
            HBLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    //案例详情
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [ZMNetWorkManager requestWithType:Post withUrlString:KAPIExampleBigItemList withParameters:nil withSuccessBlock:^(id response) {
            HBLog(@"结果=%@",response);
            if (KVerifyHttpSuccessCode(response)) {
                ZMHouseExampleListModel *model = [[ZMHouseExampleListModel alloc] initWithDictionary:response[@"data"]];
                self.exampleList = model;
            }
            dispatch_group_leave(group);
        } withFailureBlock:^(NSError *error) {
            HBLog(@"%@",error);
            dispatch_group_leave(group);
        }];
    });
    
    //4.队列组所有请求完成回调刷新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"请求完毕，主线程中刷新UI");
        HBLog(@"分类 = %@",self.cateArray);
        [self configureUI];
    });
}

- (void)loadMoreData{
    page ++;
    self.filterDic[@"page"] = @(page);
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIExampleBigItemList withParameters:self.filterDic withSuccessBlock:^(id response) {
        HBLog(@"结果=%@",response);
        if (KVerifyHttpSuccessCode(response)) {
            NSArray *recommendArray = [ZMHelpUtil arrDispose:response[@"data"][@"rows"]];
            NSInteger total = [[ZMHelpUtil dispose:response[@"data"][@"is_over"]] integerValue];
            for (NSDictionary *dic in recommendArray) {
                ZMHouseExampleModel *model = [[ZMHouseExampleModel alloc] initWithDictionary:dic];
                [self.exampleList.articleArray addObject:model];
            }
            //主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                if (total < 10) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
                [self.tableView reloadData];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

@end

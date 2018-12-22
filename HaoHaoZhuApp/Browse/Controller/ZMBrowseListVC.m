//
//  ZMBrowseListVC.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/21.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBrowseListVC.h"
#import "ZMBrowseListCell.h"

@interface ZMBrowseListVC ()<UITableViewDataSource,UITableViewDelegate,KSPhotoBrowserDelegate>

@property (nonatomic, strong) YYTableView            *tableView;

@end

@implementation ZMBrowseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self configureUI];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.leftButton setImage:KNavgationLeftBackIconBlack forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"看图" forState:UIControlStateNormal];
    self.navView.isHaveLine = YES;
}

- (void)configureUI{
    self.tableView = [[YYTableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kScreenWidth, kScreenHeight - self.navView.bottom) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [ZMColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    if (self.selectedIndex < self.dataArray.count) {
//        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    @weakify(self);
    self.tableView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
        [ZMHelpUtil openNormalShakeFeedback];
        self.page = 1;
        [weak_self getPhotoList];
    }];
    self.tableView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:^{
        self.page ++;
        [weak_self getPhotoList];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMBrowseModel *model = [self.dataArray safeObjectAtIndex:indexPath.row];
    return model.listCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMBrowseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMBrowseListCell"];
    if (!cell) {
        cell = [[ZMBrowseListCell alloc] initWithStyle:0 reuseIdentifier:@"ZMBrowseListCell"];
    }
    cell.model = [self.dataArray safeObjectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMBrowseModel *model = [self.dataArray safeObjectAtIndex:indexPath.row];
    //当前cell
    ZMBrowseListCell   *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSMutableArray *items = @[].mutableCopy;
//    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:nil imageUrl:[NSURL URLWithString:self.model.photo.ori_pic_url]];
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:nil thumbImage:cell.coverView.image imageUrl:[NSURL URLWithString:model.photo.ori_pic_url]];
    [items addObject:item];
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    browser.delegate = self;
    browser.bounces = NO;
    [browser showFromViewController:self];
    
}

- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index{
    HBLog(@"选中了%ld",index);
}

- (void)getPhotoList{
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIBrowsePhotoList withParameters:nil withSuccessBlock:^(id response) {
        if (KVerifyHttpSuccessCode(response)) {
            NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"rows"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            for (NSDictionary *dic in list) {
                ZMBrowseModel *model = [[ZMBrowseModel alloc] initWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            //主线程更新
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.page == 1) {
                    [self.tableView.mj_header endRefreshing];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
                [self.tableView reloadData];
                if (self.updateBlock) {
                    self.updateBlock(self.page);
                }
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"错误");
    }];
}

@end

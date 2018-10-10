//
//  ZMArticleDetailViewController.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/7.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMArticleDetailViewController.h"
#import "ZMArticleDetailModel.h"
#import "ZMArticleDetailPhotoContentCell.h"
#import "ZMArticleQuestionAskCell.h"
#import "ZMArticleCopyrightDeclareCell.h"
#import "ZMArticleUserProfileCell.h"
#import "ZMArticleCommentCell.h"
#import "ZMArticleRelaRecommendCell.h"

@interface ZMArticleDetailViewController ()<UITableViewDataSource,UITableViewDelegate,KSPhotoBrowserDelegate>

@property (nonatomic, strong) ZMArticleDetailModel *model;
@property (nonatomic, strong) UIScrollView              *scrollView;
@property (nonatomic, strong) UIView                       *mainView;
@property (nonatomic, strong) YYTableView              *tableView;
@property (nonatomic, strong) NSArray<ZMArticleCommentInfoModel *>            *commentList;
@property (nonatomic, strong) NSArray<ZMArticleRelaRecommendInfoModel *> *relaRecommendList;
@property (nonatomic, strong) NSArray *items;

@end

@implementation ZMArticleDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [KSPhotoBrowser setImageManagerClass:KSYYImageManager.class];
    [KSPhotoBrowser setImageViewClass:YYAnimatedImageView.class];
}

- (void)setupNavView{
    [super setupNavView];//icon_uniform_back_b   back_no_border
    [self.navView.centerButton setTitle:@"文章详情" forState:UIControlStateNormal];
    [self.navView.centerButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
    [self.navView.leftButton setImage:KNavgationLeftBackIconWhite forState:UIControlStateNormal];
    self.navView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
}

- (void)configureUI{
    self.tableView = [[YYTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view insertSubview:self.tableView atIndex:0];
    self.mainView = [UIView new];
    self.mainView.backgroundColor = [ZMColor whiteColor];
    self.mainView.frame = CGRectMake(0, 0, kScreenWidth, self.scrollView.height + 1);
    [self.scrollView addSubview:self.mainView];
    
    //头部图片
    ZMImageView *coverView = [ZMImageView new];
    coverView.width = self.model.article_info.head_info.image.width;
    coverView.height = self.model.article_info.head_info.image.height;
    coverView.left = 0;
    coverView.top = 0;
    [self.mainView addSubview:coverView];
//    [coverView setImageWithURL:[NSURL URLWithString:self.model.article_info.head_info.cover_pic_url] placeholder:placeholderAvatarImage];
    [coverView setAnimationLoadingImage:[NSURL URLWithString:self.model.article_info.head_info.cover_pic_url] placeholder:placeholderAvatarImage];
    
    //标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [ZMColor blackColor];
    titleLabel.font = [ZMFont boldGothamWithSize:20];
    titleLabel.text = self.model.article_info.head_info.title;
    [self.mainView addSubview:titleLabel];
    titleLabel.width = kScreenWidth - 20 * 2;
    titleLabel.height = self.model.article_info.head_info.titleHeight;
    titleLabel.left = 20;
    titleLabel.top = coverView.bottom + 20;
    
    //头像昵称
    UIImageView *headImage = [UIImageView new];
    headImage.size = CGSizeMake(20, 20);
    headImage.clipsToBounds = YES;
    headImage.layer.cornerRadius = headImage.width * 0.5;
    [self.mainView addSubview:headImage];
    headImage.left = 20;
    headImage.top = titleLabel.bottom + 20;
    [headImage setImageWithURL:[NSURL URLWithString:self.model.user_info.big_avatar] placeholder:placeholderAvatarImage];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = [ZMColor appSubColor];
    nameLabel.font = [ZMFont defaultAppFontWithSize:14];
    nameLabel.text = self.model.user_info.nick;
    [self.mainView addSubview:nameLabel];
    [nameLabel sizeToFit];
    nameLabel.left = headImage.right + 5;
    nameLabel.centerY = headImage.centerY;
    
    //精选
    UIImageView *recommendIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"editor_selected"]];
    recommendIcon.size = CGSizeMake(40, 40);
    [self.mainView addSubview:recommendIcon];
    recommendIcon.left = 20;
    recommendIcon.top = nameLabel.bottom + 20;
    
    UILabel *recommendTitle = [UILabel new];
    recommendTitle.numberOfLines = 2;
    recommendTitle.textColor = [ZMColor blackColor];
    recommendTitle.font = [ZMFont defaultAppFontWithSize:14];
    recommendTitle.text = self.model.article_info.head_info.title;
    [self.mainView addSubview:recommendTitle];
    recommendTitle.width = kScreenWidth - recommendIcon.right - 20 * 2;
    recommendTitle.height = self.model.article_info.head_info.recommendHeight;
    recommendTitle.left = recommendIcon.right + 20;
    recommendTitle.centerY = recommendIcon.centerY;
    
    //说在前面
    UILabel *firstLabel = [UILabel new];
    firstLabel.text = @"说在前面";
    firstLabel.textColor = [ZMColor blackColor];
    firstLabel.font = [ZMFont boldGothamWithSize:18];
    [self.mainView addSubview:firstLabel];
    [firstLabel sizeToFit];
    firstLabel.left = 20;
    firstLabel.top = recommendIcon.bottom + 40;
    
    //描述
    UILabel *descLabel = [UILabel new];
    descLabel.numberOfLines = 0;
    descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    descLabel.font = [ZMFont defaultAppFontWithSize:15];
    descLabel.textColor = [ZMColor blackColor];
    [self.mainView addSubview:descLabel];
    descLabel.width = kScreenWidth - 20 * 2;
    descLabel.height = self.model.article_info.head_info.descHeight;
    descLabel.left = 20;
    descLabel.top = firstLabel.bottom + 20;
    [descLabel setText:self.model.article_info.head_info.desc lineSpacing:10];
    
    self.mainView.height = descLabel.bottom;
    self.tableView.tableHeaderView = self.mainView;
}

- (void)setAid:(NSString *)aid{
    _aid = aid;
    [self getArticleDetailData];
    [self getBaseCommnetData];
    [self getRelaRecommendData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    HBLog(@"边距 = %2.0f",scrollView.contentOffset.y);
    CGFloat contentOffY = scrollView.contentOffset.y;
    if (contentOffY <= 0) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    CGFloat reOffset = contentOffY + (kScreenHeight - self.navView.height) * 0.2;
    CGFloat alpha = reOffset / ((kScreenHeight - self.navView.height) * 0.2);
    if (alpha <= 1)//下拉永不显示导航栏
    {
        alpha = 0;
    }
    else//上划前一个导航栏的长度是渐变的
    {
        alpha -= 1;
    }
    self.navView.backgroundColor = [UIColor colorWithWhite:1 alpha:alpha];
    
    //超过头部图片位置，改变颜色
    if (contentOffY + self.navView.height >= self.model.article_info.head_info.image.height) {
        [self.navView.centerButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        [self.navView.leftButton setImage:KNavgationLeftBackIconBlack forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }else{
        [self.navView.centerButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
        [self.navView.leftButton setImage:KNavgationLeftBackIconWhite forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section < self.model.article_info.show_photo_info.count) {
        UIView *view = [UIView new];
        view.size = CGSizeMake(kScreenWidth, 50);
        view.backgroundColor = [ZMColor whiteColor];
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [ZMColor blackColor];
        titleLabel.font = [ZMFont boldGothamWithSize:18];
        [view addSubview:titleLabel];
        ZMArticlePhotoInfoModel *model = [self.model.article_info.show_photo_info objectAtIndex:section];
        titleLabel.text = model.name;
        [titleLabel sizeToFit];
        titleLabel.left = 20;
        titleLabel.centerY = view.centerY;
        return view;
    }else if (section == self.model.article_info.show_photo_info.count && self.model.article_info.question_info.count){
        UIView *view = [UIView new];
        view.size = CGSizeMake(kScreenWidth, 50);
        view.backgroundColor = [ZMColor whiteColor];
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [ZMColor blackColor];
        titleLabel.font = [ZMFont boldGothamWithSize:20];
        [view addSubview:titleLabel];
        titleLabel.text = @"问答";
        [titleLabel sizeToFit];
        titleLabel.left = 20;
        titleLabel.centerY = view.centerY;
        return view;
    }else if (section == self.model.article_info.show_photo_info.count + 3 && self.commentList.count){
        UIView *view = [UIView new];
        view.size = CGSizeMake(kScreenWidth, 50);
        view.backgroundColor = [ZMColor whiteColor];
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [ZMColor blackColor];
        titleLabel.font = [ZMFont boldGothamWithSize:20];
        [view addSubview:titleLabel];
        titleLabel.text = @"评论";
        [titleLabel sizeToFit];
        titleLabel.left = 20;
        titleLabel.centerY = view.centerY;
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == self.model.article_info.show_photo_info.count + 3 && self.commentList.count && self.model.counter.comment.length){
        UIView *view = [UIView new];
        view.size = CGSizeMake(kScreenWidth, 100);
        view.backgroundColor = [ZMColor whiteColor];
        
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        moreButton.size = CGSizeMake(view.width, 40);
        moreButton.left = 0;
        moreButton.top = (view.height - moreButton.height) * 0.5;
        moreButton.titleLabel.font = [ZMFont defaultAppFontWithSize:15];
        NSString *text = [NSString stringWithFormat:@"查看全部 %@ 条评论",self.model.counter.comment];
        [moreButton setTitle:text forState:UIControlStateNormal];
        [moreButton setTitleColor:[ZMColor appMainThemeColor] forState:UIControlStateNormal];
        [moreButton setImage:[UIImage imageNamed:@"ich_more_green"] forState:UIControlStateNormal];
        [view addSubview:moreButton];
        [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - moreButton.imageView.image.size.width, 0, moreButton.imageView.image.size.width)];
        [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, moreButton.titleLabel.bounds.size.width + 5, 0, - moreButton.titleLabel.bounds.size.width - 5)];
        
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [ZMColor appBorderColor];
        bottomLine.frame = CGRectMake(20, view.height - 0.5, view.width - 20 * 2, 0.5);
        [view addSubview:bottomLine];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < self.model.article_info.show_photo_info.count) {
        return 50;
    }else if (section == self.model.article_info.show_photo_info.count && self.model.article_info.question_info.count){
        return 50;
    }else if (section == self.model.article_info.show_photo_info.count + 3 && self.commentList.count){
        return 50;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.model.article_info.show_photo_info.count + 3 && self.commentList.count && self.model.counter.comment.length){
        return 100;
    }
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //图片 + 问题 + 版权声明 + 用户信息 + 用户评论 + 相关推荐案例
    NSInteger section = self.model.article_info.show_photo_info.count + 1 + 1 + 1 + 1 + 1;
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < self.model.article_info.show_photo_info.count) {
        ZMArticlePhotoInfoModel *model = [self.model.article_info.show_photo_info objectAtIndex:section];
        return model.show_pics.count;
    }else if (section == self.model.article_info.show_photo_info.count){
        return self.model.article_info.question_info.count;
    }else if (section == self.model.article_info.show_photo_info.count + 1){
        return 1;
    }else if (section == self.model.article_info.show_photo_info.count + 2){
        return 1;
    }else if (section == self.model.article_info.show_photo_info.count + 3){
        return self.commentList.count;
    }else if (section == self.model.article_info.show_photo_info.count + 4){
        return self.relaRecommendList.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.model.article_info.show_photo_info.count) {
        ZMArticlePhotoInfoModel *model = [self.model.article_info.show_photo_info objectAtIndex:indexPath.section];
        return [model.show_pics objectAtIndex:indexPath.row].cellHeight;
    }else if (indexPath.section == self.model.article_info.show_photo_info.count){
        ZMArticleQuestionAskModel *model = [self.model.article_info.question_info objectAtIndex:indexPath.row];
        return model.cellHeight;
    }else if (indexPath.section == self.model.article_info.show_photo_info.count + 1){
        return self.model.article_info.head_info.declareCellHeight;
    }else if (indexPath.section == self.model.article_info.show_photo_info.count + 2){
        return 105;
    }else if (indexPath.section == self.model.article_info.show_photo_info.count + 3){
        return [self.commentList objectAtIndex:indexPath.row].cellHeight;
    }else if (indexPath.section == self.model.article_info.show_photo_info.count + 4){
        ZMArticleRelaRecommendInfoModel *model = [self.relaRecommendList objectAtIndex:indexPath.row];
        return model.cellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section < self.model.article_info.show_photo_info.count) {
        ZMArticleDetailPhotoContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMArticleDetailPhotoContentCell"];
        if (!cell) {
            cell = [[ZMArticleDetailPhotoContentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMArticleDetailPhotoContentCell"];
        }
        ZMArticlePhotoInfoModel *model = [self.model.article_info.show_photo_info objectAtIndex:section];
        cell.model = [model.show_pics objectAtIndex:row];
        @weakify(self);
        @weakify(cell);
        cell.didTapImageBlock = ^{
            HBLog(@"点击了图片");
            NSMutableArray *items = @[].mutableCopy;
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:weak_cell.coverImg imageUrl:[NSURL URLWithString:weak_cell.model.ne_pic_url]];
            [items addObject:item];
            [weak_self showBrowserWithPhotoItems:items selectedIndex:0];
        };
        return cell;
    }else if (section == self.model.article_info.show_photo_info.count && self.model.article_info.question_info.count){
        ZMArticleQuestionAskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMArticleQuestionAskCell"];
        if (!cell) {
            cell = [[ZMArticleQuestionAskCell alloc] initWithStyle:0 reuseIdentifier:@"ZMArticleQuestionAskCell"];
        }
        cell.model = [self.model.article_info.question_info safeObjectAtIndex:row];
        return cell;
    }else if (section == self.model.article_info.show_photo_info.count + 1){
        ZMArticleCopyrightDeclareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMArticleCopyrightDeclareCell"];
        if (!cell) {
            cell = [[ZMArticleCopyrightDeclareCell alloc] initWithStyle:0 reuseIdentifier:@"ZMArticleCopyrightDeclareCell"];
        }
        cell.model = self.model;
        return cell;
    }else if (section == self.model.article_info.show_photo_info.count + 2){
        ZMArticleUserProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMArticleUserProfileCell"];
        if (!cell) {
            cell = [[ZMArticleUserProfileCell alloc] initWithStyle:0 reuseIdentifier:@"ZMArticleUserProfileCell"];
        }
        cell.model = self.model.user_info;
        return cell;
    }else if (section == self.model.article_info.show_photo_info.count + 3 && self.commentList.count){
        ZMArticleCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMArticleCommentCell"];
        if (!cell) {
            cell = [[ZMArticleCommentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMArticleCommentCell"];
        }
        cell.model = [self.commentList safeObjectAtIndex:indexPath.row];
        return cell;
    }else if (section == self.model.article_info.show_photo_info.count + 4 && self.relaRecommendList.count){
        ZMArticleRelaRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMArticleRelaRecommendCell"];
        if (!cell) {
            cell = [[ZMArticleRelaRecommendCell alloc] initWithStyle:0 reuseIdentifier:@"ZMArticleRelaRecommendCell"];
        }
        cell.model = [self.relaRecommendList objectAtIndex:indexPath.row];
        return cell;
    }
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYTableViewCell"];
    if (!cell) {
        cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"YYTableViewCell"];
    }
    cell.backgroundColor = [ZMColor appMoneyColor];
    return cell;
}

- (void)showBrowserWithPhotoItems:(NSArray *)items selectedIndex:(NSUInteger)selectedIndex {
    self.items = items;
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:selectedIndex];
    browser.delegate = self;
    browser.bounces = NO;
    [browser showFromViewController:self];
}

// MARK: - KSPhotoBrowserDelegate
- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index {
    NSLog(@"selected index: %ld", index);
}

- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didLongPressItem:(KSPhotoItem *)item atIndex:(NSUInteger)index {
    UIImage *image = [browser imageForItem:item];
    NSLog(@"long pressed image:%@", image);
}

#pragma mark - 任务
- (void)getArticleDetailData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"article_id"] = _aid;
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIArticleDetail withParameters:param withSuccessBlock:^(id response) {
        if (KVerifyHttpSuccessCode(response)) {
            ZMArticleDetailModel *model = [[ZMArticleDetailModel alloc] initWithDictionary:response[@"data"]];
            self.model = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                //加载UI
                [self configureUI];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"加载错误");
    }];
}

#pragma mark - 评论
- (void)getBaseCommnetData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"obj_id"] = _aid;
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIArticleBaseCommentList withParameters:param withSuccessBlock:^(id response) {
        if (KVerifyHttpSuccessCode(response)) {
            NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"new_comments"]];
            NSMutableArray *temp = [NSMutableArray new];
            for (int i = 0; i < list.count; i++) {
                NSDictionary *dic = [list safeObjectAtIndex:i];
                ZMArticleCommentInfoModel *model = [[ZMArticleCommentInfoModel alloc] initWithDictionary:dic];
                [temp addObject:model];
            }
            self.commentList = temp;
            dispatch_async(dispatch_get_main_queue(), ^{
                //加载UI
                [self.tableView reloadData];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"加载错误");
    }];
}

#pragma mark - 相关案例
- (void)getRelaRecommendData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"article_id"] = _aid;
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIArticleRelaRecommend withParameters:param withSuccessBlock:^(id response) {
        if (KVerifyHttpSuccessCode(response)) {
            NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"recommend_block_list"]];
            NSMutableArray *temp = [NSMutableArray new];
            for (int i = 0; i < list.count; i++) {
                NSDictionary *dic = [list safeObjectAtIndex:i];
                ZMArticleRelaRecommendInfoModel *model = [[ZMArticleRelaRecommendInfoModel alloc] initWithDictionary:dic];
                [temp addObject:model];
            }
            self.relaRecommendList = temp;
        }
            dispatch_async(dispatch_get_main_queue(), ^{
                //加载UI
                [self.tableView reloadData];
            });
    } withFailureBlock:^(NSError *error) {
        HBLog(@"加载错误");
    }];
}

@end

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

@interface ZMArticleDetailViewController ()<UITableViewDataSource,UITableViewDelegate,KSPhotoBrowserDelegate>

@property (nonatomic, strong) ZMArticleDetailModel *model;
@property (nonatomic, strong) UIScrollView              *scrollView;
@property (nonatomic, strong) UIView                       *mainView;
@property (nonatomic, strong) YYTableView              *tableView;

@property (nonatomic, strong) NSArray *items;

@end

@implementation ZMArticleDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
//    [KSPhotoBrowser setImageManagerClass:KSSDImageManager.class];
//    [KSPhotoBrowser setImageViewClass:FLAnimatedImageView.class];
    
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
    UIImageView *coverView = [UIImageView new];
    coverView.width = self.model.article_info.head_info.image.width;
    coverView.height = self.model.article_info.head_info.image.height;
    coverView.left = 0;
    coverView.top = 0;
    [self.mainView addSubview:coverView];
    [coverView setImageWithURL:[NSURL URLWithString:self.model.article_info.head_info.cover_pic_url] placeholder:placeholderAvatarImage];
    
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
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    HBLog(@"边距 = %2.0f",scrollView.contentOffset.y);
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.article_info.show_photo_info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZMArticlePhotoInfoModel *model = [self.model.article_info.show_photo_info objectAtIndex:section];
    return model.show_pics.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMArticlePhotoInfoModel *model = [self.model.article_info.show_photo_info objectAtIndex:indexPath.section];
    return [model.show_pics objectAtIndex:indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMArticleDetailPhotoContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMArticleDetailPhotoContentCell"];
    if (!cell) {
        cell = [[ZMArticleDetailPhotoContentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMArticleDetailPhotoContentCell"];
    }
    ZMArticlePhotoInfoModel *model = [self.model.article_info.show_photo_info objectAtIndex:indexPath.section];
    cell.model = [model.show_pics objectAtIndex:indexPath.row];
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
}

- (void)showBrowserWithPhotoItems:(NSArray *)items selectedIndex:(NSUInteger)selectedIndex {
    self.items = items;
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:selectedIndex];
    browser.delegate = self;
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleScale;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlack;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleDeterminate;
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

@end

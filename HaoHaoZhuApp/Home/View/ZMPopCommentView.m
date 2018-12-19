//
//  ZMPopCommentView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/11.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMPopCommentView.h"
#import "ZMPopCommentCell.h"

@interface ZMPopCommentView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView       *contentView;
@property (nonatomic, strong) UIButton    *backgroundButton;
@property (nonatomic, assign) CGFloat      contentHeight;
@property (nonatomic, strong) YYTableView       *tableView;
@property (nonatomic, strong) UIView        *topView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIButton      *closeButton;
@property (nonatomic, strong) UIView        *bottomLine;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *sortBtn;

@end

@implementation ZMPopCommentView
{
    CGFloat kAnimationDuration;
    BOOL    kActionSheetShowing;
    NSInteger page,pageSize;
    NSInteger sortType;
}

- (void)setCornerRadius:(NSInteger)cornerRadius{
    _cornerRadius = cornerRadius;
}

- (void)setShowCornerRadius:(BOOL)showCornerRadius{
    _showCornerRadius = showCornerRadius;
    if (showCornerRadius && _cornerRadius) {
        //设置圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.contentView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.contentView.layer.mask = maskLayer;
    }
}

+ (instancetype)initFrame:(CGRect)frame count:(NSInteger)count aid:(NSString *)aid uid:(NSString *)uid{
    return [[self alloc] initWithFrame:frame count:count aid:aid uid:uid];
}

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count aid:(NSString *)aid uid:(NSString *)uid{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _showCornerRadius = YES;
        _cornerRadius = 10;
        kAnimationDuration = 0.1;
        kActionSheetShowing = NO;
        _count = count;
        _aid = aid;
        _uid = uid;
        page = 1;
        pageSize = 20;
        sortType = 1; //默认为1
        self.contentHeight = frame.size.height;
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    self.backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundButton.backgroundColor = [UIColor colorWithWhite:0.000 alpha:1];
    self.backgroundButton.alpha = 0.0;
    self.backgroundButton.frame = [UIScreen mainScreen].bounds;
    [self.backgroundButton addTarget:self action:@selector(backgroundButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backgroundButton];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.contentView = [[UIView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, 0}];
    self.contentView.backgroundColor = [ZMColor whiteColor];
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    self.contentView.height = self.contentHeight;
    self.contentView.top = kScreenHeight;
    
    //顶部视图
    self.topView = [UIView new];
    self.topView.frame = CGRectMake(0, 0, self.contentView.width, 50);
    self.topView.backgroundColor = [ZMColor whiteColor];
    [self.contentView addSubview:self.topView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [ZMFont defaultAppFontWithSize:13];
    self.titleLabel.textColor = [ZMColor blackColor];
    [self.topView addSubview:self.titleLabel];
    self.titleLabel.text = [NSString stringWithFormat:@"%ld条评论",self.count];
    [self.titleLabel sizeToFit];
    self.titleLabel.left = (self.topView.width - self.titleLabel.width) * 0.5;
    self.titleLabel.top = (self.topView.height - self.titleLabel.height) * 0.5;
    
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = [ZMColor appBorderColor];
    [self.topView addSubview:self.bottomLine];
    self.bottomLine.frame = CGRectMake(0, self.topView.height - 0.5, self.topView.width, 0.5);
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"mall_show_spu_close"] forState:UIControlStateNormal];
    [self.topView addSubview:self.closeButton];
    self.closeButton.size = CGSizeMake(self.topView.height, self.topView.height);
    self.closeButton.left = self.topView.width - self.closeButton.width -0;
    self.closeButton.top = 0;
    [self.closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[YYTableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, self.contentView.width, self.contentView.height - self.topView.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [ZMColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.contentView addSubview:self.tableView];
    @weakify(self);
    self.tableView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
        [ZMHelpUtil openNormalShakeFeedback];
        page = 1;
        [weak_self getCommentList];
    }];
    self.tableView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:nil];
    [self getCommentList];
    self.showCornerRadius = YES;
    
}

#pragma mark - 关闭视图
- (void)closeView{
    [self hide:YES];
}

#pragma mark - 头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    mainView.backgroundColor = [ZMColor whiteColor];
    UILabel *titleLable = [UILabel new];
    titleLable.text = @"全部评论";
    titleLable.textColor = [ZMColor blackColor];
    titleLable.font = [ZMFont boldGothamWithSize:18];
    [mainView addSubview:titleLable];
    [titleLable sizeToFit];
    titleLable.left = 20;
    titleLable.top = mainView.height - titleLable.height - 5;
    
    UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (sortType == 1) {
        [sortBtn setImage:[UIImage imageNamed:@"ich_comment_sort_n"] forState:UIControlStateNormal];
    }else{
        [sortBtn setImage:[UIImage imageNamed:@"ich_comment_sort_s"] forState:UIControlStateNormal];
    }
    
    [mainView addSubview:sortBtn];
    sortBtn.size = CGSizeMake(40, 30);
    sortBtn.left = mainView.width - sortBtn.width - 10;
    sortBtn.top = mainView.height - sortBtn.height;
    [sortBtn addTarget:self action:@selector(clickSort:) forControlEvents:UIControlEventTouchUpInside];
    return mainView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark - Private Action
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = self.dataArray.count == 0;
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_dataArray.count) {
        return 0;
    }
    ZMPopCommentInfoModel *model = [self.dataArray safeObjectAtIndex:indexPath.row];
    return model.cellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_dataArray.count) {
        YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
        }
        return cell;
    }
    ZMPopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPopCommentCell"];
    if (!cell) {
        cell = [[ZMPopCommentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPopCommentCell"];
    }
    cell.model = [self.dataArray safeObjectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 评论排序
- (void)clickSort:(UIButton *)btn{
    if (sortType == 1) {
        sortType = 2;
        [btn setImage:[UIImage imageNamed:@"ich_comment_sort_s"] forState:UIControlStateNormal];
    }else{
        sortType = 1;
        [btn setImage:[UIImage imageNamed:@"ich_comment_sort_n"] forState:UIControlStateNormal];
    }
    [self getCommentList];
}
#pragma mark - 获取评论数据
- (void)getCommentList{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"obj_id"] = self.aid;
    param[@"sort_type"] = @(sortType);
    [ZMNetWorkManager requestWithType:Post withUrlString:KAPIArticleAllCommentList withParameters:param withSuccessBlock:^(id response) {
        [self.dataArray removeAllObjects];
        if (KVerifyHttpSuccessCode(response)) {
            NSArray *list = [ZMHelpUtil arrDispose:response[@"data"][@"rows"]];
            NSMutableArray *temp = [NSMutableArray new];
            for (int i = 0; i < list.count; i++) {
                NSDictionary *dic = [list safeObjectAtIndex:i];
                ZMPopCommentInfoModel *model = [[ZMPopCommentInfoModel alloc] initWithDictionary:dic];
                //判断是否是作者
                if ([self.uid isEqualToString:model.user_info.uid]) {
                    model.isAuthor = YES;
                }else{
                    model.isAuthor = NO;
                }
                [temp addObject:model];
            }
            self.dataArray = temp;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                //加载UI
                [self.tableView reloadData];
            });
        }
    } withFailureBlock:^(NSError *error) {
        HBLog(@"加载错误");
    }];
}

- (void)backgroundButtonPressed {
    [self hide:YES];
}

- (void)show:(BOOL)animated{
    kActionSheetShowing = YES;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    void (^showBlock)() = ^{
        self.hidden = NO;
        self.backgroundButton.alpha = 0.0f;
        [window bringSubviewToFront:self];
        if (animated) {
            [UIView animateWithDuration:kAnimationDuration + (self.contentHeight / 100) * 0.1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.2 options:UIViewAnimationOptionCurveLinear animations:^{
                self.backgroundButton.alpha = 0.5f;
                self.contentView.top = kScreenHeight - self.contentHeight;
            } completion:nil];
        } else {
            self.backgroundButton.alpha = 0.5f;
            self.contentView.top = kScreenHeight - self.contentHeight;
        }
        
//    };
}

- (void)hide:(BOOL)animated{
    kActionSheetShowing = NO;
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration + (self.contentHeight / 120) * 0.1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundButton.alpha = 0.0f;
            self.contentView.top = kScreenHeight;
        } completion:^(BOOL finished) {
            self.hidden = YES;
            [self removeFromSuperview];
        }];
    } else {
        self.backgroundButton.alpha = 0.0f;
        self.contentView.top = kScreenHeight;
        self.hidden = YES;
        [self removeFromSuperview];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)dealloc{
    HBLog(@"%@安全释放",NSStringFromClass([self class]));
    
}

@end

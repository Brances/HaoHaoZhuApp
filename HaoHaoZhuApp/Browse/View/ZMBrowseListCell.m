//
//  ZMBrowseListCell.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/12/21.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBrowseListCell.h"
#import "ZMPopCommentView.h"

@implementation ZMBrowseListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appBgGrayColor];
        [self configureUI];
    }
    return self;
}


- (void)configureUI{
    self.mainView = [UIView new];
    self.mainView.backgroundColor = [ZMColor whiteColor];
    [self.contentView addSubview:self.mainView];
    
    self.profileView = [[ZMUserProfileView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
    [self.mainView addSubview:self.profileView];
    
    self.coverView = [[ZYTagImageView alloc] initWithFrame:CGRectZero];
    self.coverView.userInteractionEnabled = NO;
    [self.mainView addSubview:self.coverView];
 
    self.descLabel = [UILabel new];
    self.descLabel.hidden = YES;
    self.descLabel.numberOfLines = 0;
    self.descLabel.font = [ZMFont defaultAppFontWithSize:14];
    self.descLabel.textColor = [ZMColor blackColor];
    [self.mainView addSubview:self.descLabel];
    
    self.operationView = [[ZMOperationView alloc] initWithFrame:CGRectZero];
    self.operationView.backgroundColor = [ZMColor whiteColor];
    @weakify(self);
    self.operationView.didTapBtn = ^(NSInteger index) {
        //弹出评论视图
        [weak_self openCommentView:index];
    };
    [self.mainView addSubview:self.operationView];
    
}

#pragma mark - 弹出评论视图
- (void)openCommentView:(NSInteger)index{
    if (index == 1) {
        ZMPopCommentView *view = [ZMPopCommentView initFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight - 150) count:[self.model.counter.comment integerValue] aid:self.model.photo.pid uid:self.model.user_info.uid];
        view.showCornerRadius = YES;
        [view show:YES];
    }
}


- (void)setModel:(ZMBrowseModel *)model{
    _model = model;
    self.profileView.user = model.user_info;
//    [self.coverView setAnimationLoadingImage:[NSURL URLWithString:model.photo.ne_pic_url] placeholder:placeholderAvatarImage];
//    [self.coverView setImageWithURL:[NSURL URLWithString:model.photo.thumb_tag_pic] placeholder:placeholderAvatarImage];
    [self.coverView setAnimationLoadingImage:[NSURL URLWithString:model.photo.thumb_tag_pic] placeholder:[YYImage imageWithColor:[UIColor randomFlatColor]]];
    [self.descLabel setText:model.photo.remark lineSpacing:5];
    self.operationView.count = model.counter;
    if (model.photo.isTag) {
        [self.coverView removeAllTags];
        [self.coverView addTagsWithTagInfoArray:model.photo.tags];
        [self.coverView setAllTagsEditEnable:NO];
    }else{
        //尝试添加标签
        [self.coverView removeAllTags];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame = CGRectMake(0, 0, self.width, self.height - 10);
    self.profileView.frame = CGRectMake(0, 0, self.width, self.model.listUserInfoHeight);
    self.coverView.frame = CGRectMake(0, self.profileView.bottom, self.width, self.model.listImageHeight);
    if (self.model.listRemarkHeight) {
        self.descLabel.hidden = NO;
        self.descLabel.width = self.width - 20 * 2;
        self.descLabel.height = self.model.listRemarkHeight;
        self.descLabel.top = self.coverView.bottom + 10;
        self.descLabel.left = 20;
        
        self.operationView.width = self.width;
        self.operationView.height = self.model.counter.operationHeight;
        self.operationView.left = 0;
        self.operationView.top = self.descLabel.bottom + 20;
        
    }else{
        self.operationView.width = self.width;
        self.operationView.height = self.model.counter.operationHeight;
        self.operationView.left = 0;
        self.operationView.top = self.coverView.bottom + 20;
    }
    
    
}

@end

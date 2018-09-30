//
//  ZMCategoryScrollView.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMCategoryTypeModel.h"
#import "ZMAdvertItemModel.h"
@protocol ZMCategoryScrollViewDelegate;
@interface ZMCategoryScrollView : UIScrollView

//@property (nonatomic, strong) NSMutableArray            *buttonArray;
@property (nonatomic, strong) ZMCategoryTypeModel   *cateModel;
@property (nonatomic, strong) UIButton                          *selectedButton;
@property (nonatomic, strong) ZMCategoryItemModel     *selectedItemModel;
@property (nonatomic, strong) UIColor                           *selectedColor;
@property (nonatomic, strong) UIColor                           *unSelectedColor;
@property (nonatomic, weak) id<ZMCategoryScrollViewDelegate>    delegates;

- (instancetype)initWithFrame:(CGRect)frame cate:(ZMCategoryTypeModel *)cate;

@end

@protocol ZMCategoryScrollViewDelegate <NSObject>

@optional

- (void)didSelected:(ZMCategoryScrollView *)view item:(ZMCategoryItemModel *)item;

@end
/** 整屋案例广告 */
@interface ZMAdvertScrollView : UIScrollView

@property (nonatomic, strong) NSArray<ZMAdvertItemModel *> *advertArray;
- (instancetype)initWithFrame:(CGRect)frame advertArray:(NSArray<ZMAdvertItemModel *> *)advertArray;

@end



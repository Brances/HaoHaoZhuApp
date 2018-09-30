//
//  ZMHomeTabView.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//  代码参考 https://github.com/SPStore/SPPageMenu

#import <UIKit/UIKit.h>

@protocol ZMHomeTabViewDelegate;
@interface ZMHomeTabView : UIView

@property (nonatomic, strong) NSArray           *items;
@property (nonatomic, assign) CGFloat             buttonMargin;
@property (nonatomic, strong) NSMutableArray *buttonArrray;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, assign)  CGFloat trackerWidth; // 跟踪器的宽度
@property (nonatomic, assign) CGFloat  trackerHeight;
@property (nonatomic, strong) UIScrollView *bridgeScrollView;

@property (nonatomic, strong) UIColor *selectedItemTitleColor;   // 选中的item标题颜色
@property (nonatomic, strong) UIColor *unSelectedItemTitleColor; // 未选中的item标题颜色
@property (nonatomic, strong) UIView     *tracker;
@property (nonatomic, assign) NSInteger selectedItemIndex; // 选中的item下标，改变其值可以用于切换选中的item
// 起始偏移量,为了判断滑动方向
@property (nonatomic, assign) CGFloat beginOffsetX;

@property (nonatomic, weak) id<ZMHomeTabViewDelegate> delegate;

- (void)setItems:(NSArray *)items selectedItemIndex:(NSInteger)selectedItemIndex;

@end

@protocol ZMHomeTabViewDelegate <NSObject>
@required
- (void)itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end


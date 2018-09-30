//
//  ZMNavView.h

//
//  Created by Brances on 2018/5/21.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMNavView : UIView

/** 主视图 */
@property (nonatomic, strong) UIView    *mainView;
/** 导航遮罩 */
@property (nonatomic, strong) UIImageView   *cover;
/** 左边按钮 */
@property (nonatomic, strong) UIButton *leftButton;
/** 左边第二个按钮 */
@property (nonatomic, strong) UIButton *leftTwoButton;
/** 右边按钮 */
@property (nonatomic, strong) UIButton *rightButton;
/** 中间按钮 */
@property (nonatomic, strong) UIButton *centerButton;
/** 中间按钮文字 */
@property (nonatomic, strong) YYLabel  *centerLabel;
/** 右边标签 */
@property (nonatomic, strong) UILabel   *rightLabel;
/** 是否有下划线 */
@property (nonatomic, assign, getter=isHaveLine) BOOL isHaveLine;
/** 下划线 */
@property (nonatomic, strong) UILabel *bottomLineLabel;

/** 设置中间文本 */
@property (nonatomic, copy) NSString   *centerButtonTitle;
/** 设置右边按钮文本 */
@property (nonatomic, copy) NSString   *rightButtonTitle;

/** 左边按钮block */
@property (nonatomic, copy) void (^ leftButtonBlock)(void);
/** 右边按钮block */
@property (nonatomic, copy) void (^ rightButtonBlock)(void);

@end

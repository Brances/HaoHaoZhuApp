//
//  ZMSearchView.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZMSearchViewDelegate;
@interface ZMSearchView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIView            *mainView;
@property (nonatomic, strong) UIImageView   *iconView;
@property (nonatomic, strong) UITextField      *textField;
@property (nonatomic, strong) UIButton         *coverBtn;
@property (nonatomic, strong) UIButton         *cleanBtn;
@property (nonatomic, copy) NSString            *text;
@property (nonatomic, copy) NSString           *placeHolder;
@property (nonatomic, weak) id <ZMSearchViewDelegate> delegate;
@property (nonatomic, copy) void(^didClickButtonBlock)(UIButton *btn);
/** 文本框是否可点击，用于点击跳转 */
@property (nonatomic, assign) BOOL      enable;

- (void)cleanAll;

@end

@protocol ZMSearchViewDelegate <NSObject>

@optional
- (void)didSelectedPushButton;
- (void)didSelectedCleanButton;
- (void)textDidChange;

@end

@interface ZMSearchViewContainer : UIView

@property (nonatomic, strong) ZMSearchView *view;

@end


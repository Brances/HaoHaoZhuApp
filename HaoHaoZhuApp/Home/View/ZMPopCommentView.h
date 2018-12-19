//
//  ZMPopCommentView.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/10/11.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPopCommentView : UIView

@property (nonatomic, assign) NSInteger    count;
/** 默认显示 */
@property (nonatomic, assign) BOOL          showCornerRadius;
/** default 5 */
@property (nonatomic, assign) NSInteger    cornerRadius;
/** 文章ID */
@property (nonatomic, copy) NSString *aid;
/** 用户ID */
@property (nonatomic, copy) NSString *uid;

#pragma mark - 提供初始化类方法
+ (instancetype)initFrame:(CGRect)frame count:(NSInteger)count aid:(NSString *)aid uid:(NSString *)uid;
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end

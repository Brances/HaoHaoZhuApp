//
//  ZMColor.h

//
//  Created by Brances on 2018/2/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMColor : NSObject

+ (UIColor *)randomColor;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)clearColor;
+ (UIColor *)whiteColor;
+ (UIColor *)blackColor;

/** 视图灰色背景 F5F5F5 */
+ (UIColor *)appBgGrayColor;
/** 文字颜色#222222 */
+ (UIColor *)appMainTextColor;
/** 文本灰色 （副标题文本颜色）#999999 */
+ (UIColor *)appSubColor;
/** 灰色间距 #E5E5E5(历史：F4F4F4)*/
+ (UIColor *)appSeparatorLineColor;
/** 金黄色💰 #FF6500 */
+ (UIColor *)appMoneyColor;
/** 主题颜色 主题颜色  */
+ (UIColor *)appMainThemeColor;
+ (UIColor *)appBorderColor;
/** 主按钮激活背景颜色  */
+ (UIColor *)appButtonActiveColor;

/** 主按钮高亮颜色 */
+ (UIColor *)appButtonHightColor;

/** 主按钮禁用颜色 */
+ (UIColor *)appButtonDisableColor;

/** 辅助按钮激活背景颜色 */
+ (UIColor *)appSupportButtonActiveColor;

/** 辅助按钮高亮颜色 */
+ (UIColor *)appSupportButtonHightColor;

/** 辅助按钮禁用颜色 */
+ (UIColor *)appSupportButtonDisableColor;

/** 警告按钮激活背景颜色 */
+ (UIColor *)appWarnButtonActiveColor;

/** 警告按钮高亮颜色 */
+ (UIColor *)appWarnButtonHightColor;

/** 警告按钮禁用颜色 */
+ (UIColor *)appWarnButtonDisableColor;

/** 主按钮文本激活颜色 */
+ (UIColor *)appButtonTitleActiveColor;

/** 主按钮文本高亮颜色 */
+ (UIColor *)appButtonTitleHightColor;

/** 主按钮文本禁用颜色 */
+ (UIColor *)appButtonTitleDisableColor;

/** 辅助按钮文本激活颜色 */
+ (UIColor *)appSupportButtonTitleActiveColor;

/** 辅助按钮文本高亮颜色 */
+ (UIColor *)appSupportButtonTitleHightColor;

/** 辅助按钮文本禁用颜色 */
+ (UIColor *)appSupportButtonTitleDisableColor;

/** 警告按钮文本激活颜色 */
+ (UIColor *)appWarnButtonTitleActiveColor;

/** 警告按钮文本高亮颜色 */
+ (UIColor *)appWarnButtonTitleHightColor;

/** 警告按钮文本禁用颜色 */
+ (UIColor *)appWarnButtonTitleDisableColor;

@end

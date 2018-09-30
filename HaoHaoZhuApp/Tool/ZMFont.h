//
//  ZMFont.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/27.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMFont : NSObject

/** APP默认字体 Gotham-Book.otf ，实际上的名称是 li-song-regular，可尝试删除引用 */
+ (UIFont *)defaultAppFontWithSize:(CGFloat)size;
/** APP Gotham-Bold.otf 加粗字体 */
+ (UIFont *)boldGothamWithSize:(CGFloat)size;
/** 系统自带字体 */
+ (UIFont *)sysTemFontWithSize:(CGFloat)size;

@end

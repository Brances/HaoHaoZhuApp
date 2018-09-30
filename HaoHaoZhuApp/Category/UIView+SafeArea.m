//
//  UIView+SafeArea.m

//
//  Created by Brances on 2018/4/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "UIView+SafeArea.h"

@implementation UIView (SafeArea)

+ (CGFloat)sc_statusBarHeight{
    if (KDevice_Is_iPhoneX) {
        return 44.0f;
    }
    return 20;
}

+ (CGFloat)sc_navigationBarHeighExcludeStatusBar{
    return 44;
}

+ (CGFloat)sc_navigationBarHeight{
    return self.sc_statusBarHeight + self.sc_navigationBarHeighExcludeStatusBar;
}

+ (CGFloat)sc_bottomInset{
//    if (@available(iOS 11.0, *)) {
//        return UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
//    }
    if (KDevice_Is_iPhoneX) {
        return 34.0f;
    }
    return 0;
}

@end

//
//  UIView+SafeArea.h

//
//  Created by Brances on 2018/4/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SafeArea)

@property (class, nonatomic, readonly) CGFloat sc_statusBarHeight; // 37 for iPhone X, 20 for Others
@property (class, nonatomic, readonly) CGFloat sc_navigationBarHeighExcludeStatusBar; // 44
@property (class, nonatomic, readonly) CGFloat sc_navigationBarHeight; // status + naviExStatus
@property (class, nonatomic, readonly) CGFloat sc_bottomInset;

@end

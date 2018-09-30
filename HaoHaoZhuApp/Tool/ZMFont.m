//
//  ZMFont.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/27.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMFont.h"

@implementation ZMFont

+ (UIFont *)defaultAppFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"li-song-regular" size:size];
}

+ (UIFont *)boldGothamWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"Gotham-Bold" size:size];
}

+ (UIFont *)sysTemFontWithSize:(CGFloat)size{
    return [UIFont systemFontOfSize:size];
}

@end

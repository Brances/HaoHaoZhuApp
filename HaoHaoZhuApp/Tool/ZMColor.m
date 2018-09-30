//
//  ZMColor.m

//
//  Created by Brances on 2018/2/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMColor.h"

@implementation ZMColor

+ (UIColor *)randomColor{
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}
+ (UIColor *)clearColor{
    return [UIColor clearColor];
}

+ (UIColor *)whiteColor{
    return [UIColor whiteColor];
}

+ (UIColor *)blackColor{
    return [UIColor blackColor];
}

+ (UIColor *)appBgGrayColor{
    return [self colorWithHexString:@"#F7F7F7" alpha:1.0f];
}

+ (UIColor *)appMainTextColor{
    return [self colorWithHexString:@"#222222" alpha:1.0f];
}

+ (UIColor *)appSubColor{
    return [self colorWithHexString:@"#999999" alpha:1.0f];
}
+ (UIColor *)appSeparatorLineColor{
    return [self colorWithHexString:@"#E5E5E5" alpha:1.0f];
}
+ (UIColor *)appMoneyColor{
    return [self colorWithHexString:@"#FF6500" alpha:1.0f];
}

+ (UIColor *)appMainThemeColor{
    return [self colorWithHexString:@"#28B4B5" alpha:1.0f];
}

+ (UIColor *)appBorderColor{
    return [self colorWithHexString:@"#F2F2F2" alpha:1.0f];
}

+ (UIColor *)appButtonActiveColor{
    return [self colorWithHexString:@"#FF8B00" alpha:1.0f];
}

+ (UIColor *)appButtonHightColor{
    return [self colorWithHexString:@"#FF8B00" alpha:0.8f];
}

+ (UIColor *)appButtonDisableColor{
    return [self colorWithHexString:@"#FF8B00" alpha:0.4f];
}

+ (UIColor *)appSupportButtonActiveColor{
    return [self colorWithHexString:@"#F8F8F8" alpha:1.0f];
}

+ (UIColor *)appSupportButtonHightColor{
    return [self colorWithHexString:@"#000000" alpha:0.1f];
}

+ (UIColor *)appSupportButtonDisableColor{
    return [self colorWithHexString:@"#F8F8F8" alpha:1.0f];
}

+ (UIColor *)appWarnButtonActiveColor{
    return [self colorWithHexString:@"#E64340" alpha:1.0f];
}

+ (UIColor *)appWarnButtonHightColor{
    return [self colorWithHexString:@"#E64340" alpha:0.8f];
}

+ (UIColor *)appWarnButtonDisableColor{
    return [self colorWithHexString:@"#E64340" alpha:0.6f];
}

+ (UIColor *)appButtonTitleActiveColor{
    return [self colorWithHexString:@"#FFFFFF" alpha:1.0f];
}

+ (UIColor *)appButtonTitleHightColor{
    return [self colorWithHexString:@"#E57C00" alpha:1.0f];
}

+ (UIColor *)appButtonTitleDisableColor{
    return [self colorWithHexString:@"#FFFFFF" alpha:0.6f];
}

+ (UIColor *)appSupportButtonTitleActiveColor{
    return [self colorWithHexString:@"#000000" alpha:1.0f];
}

+ (UIColor *)appSupportButtonTitleHightColor{
    return [self colorWithHexString:@"#000000" alpha:0.6f];
}

+ (UIColor *)appSupportButtonTitleDisableColor{
    return [self colorWithHexString:@"#000000" alpha:0.3f];
}

+ (UIColor *)appWarnButtonTitleActiveColor{
    return [self colorWithHexString:@"#FFFFFF" alpha:1.0f];
}

+ (UIColor *)appWarnButtonTitleHightColor{
    return [self colorWithHexString:@"#FFFFFF" alpha:0.6f];
}

+ (UIColor *)appWarnButtonTitleDisableColor{
    return [self colorWithHexString:@"#FFFFFF" alpha:0.6f];
}

@end

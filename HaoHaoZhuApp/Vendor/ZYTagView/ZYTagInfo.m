//
//  ZYTagInfo.m
//  ZYTagViewDemo
//
//  Created by ripper on 2016/9/28.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import "ZYTagInfo.h"

@implementation ZYTagInfo

ZYPositionProportion ZYPositionProportionMake(CGFloat x, CGFloat y)
{
    ZYPositionProportion p; p.x = x; p.y = y; return p;
}

+ (instancetype)tagInfo
{
    return [[self alloc] init];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        CGFloat   x = [[ZMHelpUtil dispose:dict[@"center_local"][@"x"]] floatValue];
        CGFloat   y = [[ZMHelpUtil dispose:dict[@"center_local"][@"y"]] floatValue];
        ZYPositionProportion  proportion = ZYPositionProportionMake(x, y);
        self.proportion = proportion;
        if ([[ZMHelpUtil dispose:dict[@"center_local"][@"arrow"]] isEqualToString:@"0"]) {
            self.direction = ZYTagDirectionLeft;
        }else{
            self.direction = ZYTagDirectionRight;
        }
        self.title = [ZMHelpUtil dispose:dict[@"brand"]];
//        self.tagInfo.proportion = ZYPositionProportionMake(self.tagInfo.point.x / superview.zy_width, self.tagInfo.point.y / superview.zy_height);
    }
    return self;
}

@end

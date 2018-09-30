//
//  ZMBaseModel.m

//
//  Created by Brances on 2018/3/1.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"

@implementation ZMBaseModel

- (NSString *)dispose:(id)data{
    if (data == nil || [data isEqual:[NSNull null]]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",data];
}

- (NSArray *)arrDispose:(id)data{
    if ([data isKindOfClass:[NSArray class]]) {
        return data;
    }
    return [NSArray array];
}

- (NSDictionary *)dicDispose:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    return [NSDictionary dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
    }
    return self;
}

@end

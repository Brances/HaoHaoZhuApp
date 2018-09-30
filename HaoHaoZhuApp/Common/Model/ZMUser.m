//
//  ZMUser.m
//  
//
//  Created by Brances on 2018/3/31.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMUser.h"

@implementation ZMUser

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.uid = [ZMHelpUtil dispose:dict[@"uid"]];
        self.nick = [ZMHelpUtil dispose:dict[@"nick"]];
        self.gender = [ZMHelpUtil dispose:dict[@"gender"]];
        //读取地区信息感觉太慢了
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        self.status = [ZMHelpUtil dispose:dict[@"status"]];
        self.profile = [ZMHelpUtil dispose:dict[@"profile"]];
        self.avatar_small = [ZMHelpUtil dispose:dict[@"avatar_small"]];
        self.avatar = [ZMHelpUtil dispose:dict[@"avatar"]];
        self.big_avatar = [ZMHelpUtil dispose:dict[@"big_avatar"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSString *)description{
    NSString * desc = @"\n";
    unsigned int outCount;
    //获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //获取property的C字符串
        const char * propName = property_getName(property);
        if (propName) {
            //获取NSString类型的property名字
            NSString    * prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            //获取property对应的值
            id obj = [self valueForKey:prop];
            //将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"%@ : %@;\n",prop,obj];
        }
    }
    free(properties);
    return desc;
}


@end

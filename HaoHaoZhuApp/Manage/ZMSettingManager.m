//
//  ZMSettingManager.m

//
//  Created by Brances on 2018/4/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMSettingManager.h"

@implementation ZMSettingManager

+ (instancetype)shareInstance{
    static ZMSettingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZMSettingManager alloc] init];
    });
    return manager;
}

#pragma mark - 通用配置
- (void)configure{
    //全局并行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        //读取省市区文件从磁盘取到内存当中，这样访问速度会快
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"]];
        NSArray *list = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        self.provinceList = list;
    });
}

@end

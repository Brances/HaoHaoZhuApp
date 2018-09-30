//
//  ZMSettingManager.h

//
//  Created by Brances on 2018/4/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UISCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define UISCREENHEIGHT      [UIScreen mainScreen].bounds.size.height
#define KUserDefaults            [NSUserDefaults standardUserDefaults]
#define KDevice_Is_iPhoneX   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface ZMSettingManager : NSObject

+ (instancetype)shareInstance;

/** 取出本地的省市区文件 */
@property (nonatomic, strong) NSArray *provinceList;

#pragma mark - 通用配置初始化
- (void)configure;

@end

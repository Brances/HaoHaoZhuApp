//
//  ZMUserManage.h

//
//  Created by Brances on 2018/4/24.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMUser.h"

@interface ZMUserManager : NSObject

@property (nonatomic, strong) ZMUser   *user;

+ (instancetype)shareInstance;

/** 解析用户信息 */
- (void)initWithUserDictionarys:(NSDictionary *)dict;

/** 保存用户信息到沙盒 */
- (void)saveUserInfoToSandbox;

/** 从沙盒中加载用户信息 */
- (void)loadUserInfoFromSandbox;

/** 移除用户所有信息 */
//- (void)removeAll;

/** 退出登录 */
- (void)loginOut;

@end

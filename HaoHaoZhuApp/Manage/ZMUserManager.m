//
//  ZMUserManage.m

//
//  Created by Brances on 2018/4/24.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMUserManager.h"

@implementation ZMUserManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static ZMUserManager *manage;
    dispatch_once(&onceToken, ^{
        manage = [[self alloc] init];
    });
    return manage;
}

- (ZMUser *)user{
    if (!_user) {
        _user = [[ZMUser alloc] init];
    }
    return _user;
}

- (void)initWithUserDictionarys:(NSDictionary *)dict{
    if (!dict.allKeys.count) return;
    
   
    
}

#pragma mark - 保存用户信息到沙盒
- (void)saveUserInfoToSandbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
   
    [defaults synchronize];
}

#pragma mark - 从沙盒中加载用户信息
- (void)loadUserInfoFromSandbox{
    
    

    
}

- (void)removeAll{
    
    
    
}

- (void)loginOut{
    [self removeAll];
}

@end

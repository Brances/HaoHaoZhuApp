//
//  ZMBaseModel.h

//
//  Created by Brances on 2018/3/1.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMBaseModel : NSObject

- (NSString *)dispose:(id)data;
- (NSArray *)arrDispose:(id)data;
- (NSDictionary *)dicDispose:(id)data;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

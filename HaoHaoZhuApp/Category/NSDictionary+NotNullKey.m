//
//  NSDictionary+NotNullKey.m

//
//  Created by Brances on 2018/4/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "NSDictionary+NotNullKey.h"

@implementation NSDictionary (NotNullKey)

// in case of [NSNull null] values a nil is returned ...
- (id)objectForSafeKey:(id)key {
    id object = [self objectForKey:key];
    if ([object isEqual:[NSNull null]]){
        return nil;
    }
    return object;
}

@end

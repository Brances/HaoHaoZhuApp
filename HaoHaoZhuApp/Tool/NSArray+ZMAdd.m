//
//  NSArray+ZMAdd.m

//
//  Created by Brances on 2018/3/7.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "NSArray+ZMAdd.h"

@implementation NSArray (ZMAdd)

- (id)safeObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end

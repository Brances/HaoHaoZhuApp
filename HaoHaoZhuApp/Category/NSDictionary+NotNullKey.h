//
//  NSDictionary+NotNullKey.h

//
//  Created by Brances on 2018/4/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NotNullKey)

- (id)objectForSafeKey:(id)key;

@end

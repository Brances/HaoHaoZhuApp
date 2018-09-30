//
//  ZMPhoneFormat.h

//
//  Created by Brances on 2018/5/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPhoneFormat : UITextField

@property (nonatomic, copy) void (^textDidChange)(NSString *);

- (BOOL)valueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range;

@end

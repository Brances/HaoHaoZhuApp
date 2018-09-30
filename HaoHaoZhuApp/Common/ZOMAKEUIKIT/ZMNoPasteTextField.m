//
//  ZMNoPasteTextField.m

//
//  Created by Brances on 2018/6/16.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMNoPasteTextField.h"

@implementation ZMNoPasteTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(paste:)) {
        return  NO;
    }
    if (action == @selector(select:)) {
        return  NO;
    }
    if (action == @selector(selectAll:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end

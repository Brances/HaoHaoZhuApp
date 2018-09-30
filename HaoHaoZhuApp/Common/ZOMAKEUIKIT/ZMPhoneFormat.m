//
//  ZMPhoneFormat.m

//
//  Created by Brances on 2018/5/22.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMPhoneFormat.h"
@interface ZMPhoneFormat()
{
    CGFloat _defaultYOffset; //标记_FieldEditorContentView初始偏y方向移量
}
@end
@implementation ZMPhoneFormat

- (BOOL)valueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range{
    NSString *text = self.text;
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    NSLog(@"%@",NSStringFromRange(range));
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    NSString *subString = [text substringToIndex:MIN(text.length, 3)];
    newString = [newString stringByAppendingString:subString];
    if (subString.length == 3) {
        newString = [newString stringByAppendingString:@" "];
    }
    text = [text substringFromIndex:MIN(text.length, 3)];
    if (text.length > 0) {
        NSString *subString2 = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString2];
        if (subString2.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        NSString *subString3 = [text substringFromIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString3];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    if (newString.length >= 14) {
        return NO;
    }
    [self setText:newString];
//    if (newString.length && self.textDidChange) {
//        self.textDidChange(newString);
//    }
    return NO;
}

//- (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectInset(bounds, 1, 0.5);
//}
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    return CGRectInset(bounds, 1, 0);
//}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    for (UIScrollView *fieldEditor in self.subviews) {
//        if ([fieldEditor isKindOfClass:[UIScrollView class]]) { // UIFieldEditor
//            CGFloat currentYOffset = 0.0f;
//            for (UIView *fieldEditorContentView in fieldEditor.subviews) { //_FieldEditorContentView
//                currentYOffset = fieldEditorContentView.frame.origin.y;
//                if (_defaultYOffset == 0.0f && currentYOffset != 0.0f) {
//                    _defaultYOffset = currentYOffset;
//                }
//            }
//            CGPoint offset = fieldEditor.contentOffset;
//            if (currentYOffset == 0.0f && _defaultYOffset != 0.0f) {
//                offset.y = -_defaultYOffset;
//            } else {
//                offset.y = 0.0f;
//            }
//            if (self.text.length == 0 && self.attributedText.length == 0) { //字体为空时重置_defaultYOffset
//                offset.y = 0.0f;
//                _defaultYOffset = 0.0f;
//            }
//            fieldEditor.contentOffset = offset;
//            break;
//        }
//    }
//}

@end

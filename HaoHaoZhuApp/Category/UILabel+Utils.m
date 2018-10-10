//
//  UILabel+Utils.m
//  delivelyuser
//
//  Created by Brances on 2018/8/27.
//  Copyright © 2018年 HBL. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing{
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

- (void)setCommentText:(NSString*)text lineSpacing:(CGFloat)lineSpacing beginColorRange:(NSRange)range{
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    //li-song-regular   Gotham-Bold
    label.font = [ZMFont defaultAppFontWithSize:fontSize];
    label.numberOfLines = 0;
    [label setText:text lineSpacing:lineSpacing];
    [label sizeToFit];
    return label.height;
}

+ (CGFloat)text:(NSString*)text boldHeightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    //li-song-regular   Gotham-Bold
    label.font = [ZMFont boldGothamWithSize:fontSize];
    label.numberOfLines = 0;
    [label setText:text lineSpacing:lineSpacing];
    [label sizeToFit];
    return label.height;
}

@end

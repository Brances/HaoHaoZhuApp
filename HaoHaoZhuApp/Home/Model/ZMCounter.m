//
//  ZMCounter.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMCounter.h"

@implementation ZMCounter

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.marginLeft = 10;
        self.marginSpace = 2;
        self.operationTop = 0;
        self.operationHeight = 50;
        self.operationBottom = 25;
        self.operationTotalHeight = self.operationTop + self.operationHeight + self.operationBottom;
        
        self.comment = [ZMHelpUtil dispose:dict[@"comment"]];
        self.like = [ZMHelpUtil dispose:dict[@"like"]];
        self.favorite = [ZMHelpUtil dispose:dict[@"favorite"]];
        self.share = [ZMHelpUtil dispose:dict[@"share"]];
        self.read = [ZMHelpUtil dispose:dict[@"read"]];
        
        self.commentUrl = @"Talk";
        self.commentIcon = [UIImage imageNamed:self.commentUrl];
        CGFloat commentBageW = [ZMHelpUtil WidthForString:self.comment withSizeOfFont:11];
        self.commentW = self.commentIcon.size.width + self.marginSpace + commentBageW + self.marginLeft * 2;
        self.commentX = (self.commentW - self.commentIcon.size.width - commentBageW - self.marginSpace) * 0.5;
        
        self.favoriteUrl = @"collect_water~iphone";
        self.favoriteIcon = [UIImage imageNamed:self.favoriteUrl];
        CGFloat favoriteBageW = [ZMHelpUtil WidthForString:self.favorite withSizeOfFont:11];
        self.favoriteW = self.commentIcon.size.width + self.marginSpace + favoriteBageW + self.marginLeft * 2;
        self.favoriteX = (self.favoriteW - self.favoriteIcon.size.width - favoriteBageW - self.marginSpace) * 0.5;
        
        self.likeUrl = @"ich_nice_n";
        self.likeIcon = [UIImage imageNamed:self.likeUrl];
        CGFloat likeBageW = [ZMHelpUtil WidthForString:self.like withSizeOfFont:11];
        self.likeW = self.likeIcon.size.width + self.marginSpace + likeBageW + self.marginLeft * 2;
        self.likeX = (self.likeW - self.likeIcon.size.width - likeBageW - self.marginSpace) * 0.5;
        
        
    }
    return self;
}

@end

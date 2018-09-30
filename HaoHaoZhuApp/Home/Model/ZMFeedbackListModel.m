//
//  ZMFeedbackListModel.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMFeedbackListModel.h"

@implementation ZMFeedbackListModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        NSArray *list = [ZMHelpUtil arrDispose:dict[@"feedback_list"]];
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < list.count; i++) {
            ZMFeedbackModel *model = [[ZMFeedbackModel alloc] initWithDictionary:[list safeObjectAtIndex:i]];
            [temp addObject:model];
        }
        self.feedbackArray = temp;
        self.tag = [ZMHelpUtil dispose:dict[@"tag"]];
    }
    return self;
}

@end


@implementation ZMFeedbackModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.type = [ZMHelpUtil dispose:dict[@"type"]];
        self.param = [ZMHelpUtil dispose:dict[@"param"]];
        self.remark = [ZMHelpUtil dispose:dict[@"remark"]];
    }
    return self;
}

@end

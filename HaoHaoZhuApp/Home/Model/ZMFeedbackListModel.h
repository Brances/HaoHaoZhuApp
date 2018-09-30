//
//  ZMFeedbackListModel.h
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMBaseModel.h"
@class ZMFeedbackModel;
@interface ZMFeedbackListModel : ZMBaseModel

@property (nonatomic, strong) NSMutableArray<ZMFeedbackModel *> *feedbackArray;
@property (nonatomic, copy) NSString *tag;

@end

@interface ZMFeedbackModel : ZMBaseModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *param;
@property (nonatomic, copy) NSString *remark;

@end

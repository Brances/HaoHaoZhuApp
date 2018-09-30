//
//  ZMEnum.h

//
//  Created by Brances on 2018/2/28.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMEnum : NSObject

/** 广告图片类型 */
typedef NS_ENUM(NSInteger,ZMAdvertType){
    ZMAdvertTypeUnkonw,                //未知
    ZMAdvertTypeText,                     //纯文字
    ZMAdvertTypePicture,                 //纯图片
    ZMAdvertTypePictureList,           //广告图片列表
};

/** 操作按钮类型 */
typedef NS_ENUM(NSInteger,ZMOperationType){
    ZMOperationTypeShare,                    //分享
    ZMOperationTypeComment,            //评论
    ZMOperationTypeCollect,                 //收藏
    ZMOperationTypeLike,                //点赞
};

/** 推荐头部 */
typedef NS_ENUM(NSInteger,ZMRecommendHeadType){
    ZMRecommendHeadTypeExample,         //整屋案例
    ZMRecommendHeadTypeTopic,            //家具经验
    ZMRecommendHeadTypeMall,              //买家具
    ZMRecommendHeadTypeDesigner,       //找设计师
};

@end

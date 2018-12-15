//
//  ZMNetWorkManager.h

//
//  Created by Brances on 2018/3/6.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol ZMNetWorkManagerDelegate;
@class ZMNetworkDelegateModel;
/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, HttpRequestType){
    Get = 0,
    Post
};

/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSInteger, ZMNetworkStatusType){
    /*! 未知网络 */
    ZMNetworkStatusUnknown  = 0,
    /*! 没有网络 */
     ZMNetworkStatusNotReachable,
    /*! 手机自带网络 */
     ZMNetworkStatusReachableViaWWAN,
    /*! wifi */
     ZMNetworkStatusReachableViaWiFi
};

/// 网络状态的Block
typedef void(^ZMNetworkStatus)(ZMNetworkStatusType status);
/*! 定义请求成功的block */
typedef void( ^ ResponseSuccess)(id response);
/*! 定义请求失败的block */
typedef void( ^ ResponseFail)(NSError *error);

/*! 定义上传进度block */
typedef void( ^ UploadProgress)(NSProgress *progress);
/*! 定义下载进度block */
typedef void( ^ DownloadProgress)(CGFloat);

@interface ZMNetWorkManager : NSObject

+ (instancetype)shareManager;

/*! 获取当前网络状态 */
@property (nonatomic, assign) ZMNetworkStatusType  netWorkStatus;

#pragma mark - 添加代理
- (void)addDelegate:(id<ZMNetWorkManagerDelegate>)delegate;

#pragma mark - 移除代理
- (void)removeDelegate:(id<ZMNetWorkManagerDelegate>)delegate;

#pragma mark - 网络变化回调block
+ (void)networkStatusWithBlock:(ZMNetworkStatus)networkStatus;

/// 有网YES, 无网:NO
+ (BOOL)isNetwork;

/*!
 *  网络请求方法,block回调
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 */
+ (NSURLSessionTask *)requestWithType:(HttpRequestType)type
                                withUrlString:(NSString *)urlString
                                withParameters:(NSDictionary *)parameters
                                withSuccessBlock:(ResponseSuccess)successBlock
                                withFailureBlock:(ResponseFail)failureBlock;


/*!
 *  上传图片+参数签名 + 登录验证
 *
 *  @param URL                  请求地址
 *  @param parameters       参数
 *  @param imageData        图片二进制数据
 *  @param progress          回调进度
 *  @param successBlock   请求成功的回调
 *  @param failureBlock      请求失败的回调
 */
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                                withParameters:(id)parameters
                            withImageData:(NSData *)imageData
                             withProgress:(UploadProgress)progress
                         withSuccessBlock:(ResponseSuccess)successBlock
                         withFailureBlock:(ResponseFail)failureBlock;

/** 获取访问设备ID */
+ (void)getVisitDeviceID:(ResponseSuccess)successBlock withFailureBlock:(ResponseFail)failureBlock;


@end

/** 网络请求 */
@protocol ZMNetWorkManagerDelegate <NSObject>

@optional

- (void)didChangeNetworkStatus:(ZMNetworkStatusType)type;

@end


@interface ZMNetworkDelegateModel : NSObject

@property (nonatomic, weak) id delegate;

- (instancetype)initWithDelegate:(id)delegate;

@end



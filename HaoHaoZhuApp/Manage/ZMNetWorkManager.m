//
//  ZMNetWorkManager.m

//
//  Created by Brances on 2018/3/6.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMNetWorkManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface ZMNetWorkManager()

@property (nonatomic, strong) NSMutableArray        *delegateArray;

@end

@implementation ZMNetWorkManager

- (NSMutableArray *)delegateArray {
    if (!_delegateArray) {
        _delegateArray = [NSMutableArray array];
    }
    return _delegateArray;
}

#pragma mark - Public
- (void)addDelegate:(id<ZMNetWorkManagerDelegate>)delegate{
    BOOL isExist = NO;
    for (ZMNetworkDelegateModel *model in self.delegateArray) {
        if ([delegate isEqual:model.delegate]) {
            isExist = YES;
            break;
        }
    }
    if (!isExist) {
        ZMNetworkDelegateModel *model = [[ZMNetworkDelegateModel alloc] initWithDelegate:delegate];
        [self.delegateArray addObject:model];
    }
}

- (void)removeDelegate:(id<ZMNetWorkManagerDelegate>)delegate{
    NSArray *copyArray = [self.delegateArray copy];
    for (ZMNetworkDelegateModel *model in copyArray) {
        if ([model.delegate isEqual:delegate]) {
            [self.delegateArray removeObject:model];
        }else if (!model.delegate) {
            //这里model中的delegate引用的对象释放后，自己也会置为nil,所以此时model.delegate就变成了nil
            [self.delegateArray removeObject:model];
        }
    }
}

+ (instancetype)shareManager{
    static ZMNetWorkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZMNetWorkManager alloc] init];
    });
    return instance;
}

+ (AFHTTPSessionManager *)sharedAFManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        /*! 设置请求超时时间 */
        manager.requestSerializer.timeoutInterval = 15;
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        /*! 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存【注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad】 */
        //manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            @weakify(self);
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    HBLog(@"未知网络");
                    [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusUnknown;
                    //代理处理
                    for (ZMNetworkDelegateModel *model  in weak_self.delegateArray) {
                        id <ZMNetWorkManagerDelegate> delegate = model.delegate;
                        if (delegate && [delegate respondsToSelector:@selector(didChangeNetworkStatus:)]) {
                            [delegate didChangeNetworkStatus:ZMNetworkStatusUnknown];
                        }
                    }
                    break;
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    HBLog(@"没有网络");
                    [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusNotReachable;
                    //代理处理
                    for (ZMNetworkDelegateModel *model  in weak_self.delegateArray) {
                        id <ZMNetWorkManagerDelegate> delegate = model.delegate;
                        if (delegate && [delegate respondsToSelector:@selector(didChangeNetworkStatus:)]) {
                            [delegate didChangeNetworkStatus:ZMNetworkStatusNotReachable];
                        }
                    }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    HBLog(@"手机自带网络");
                    [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusReachableViaWWAN;
                    //代理处理
                    for (ZMNetworkDelegateModel *model  in weak_self.delegateArray) {
                        id <ZMNetWorkManagerDelegate> delegate = model.delegate;
                        if (delegate && [delegate respondsToSelector:@selector(didChangeNetworkStatus:)]) {
                            [delegate didChangeNetworkStatus:ZMNetworkStatusReachableViaWWAN];
                        }
                    }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusReachableViaWiFi;
                    //代理处理
                    for (ZMNetworkDelegateModel *model  in weak_self.delegateArray) {
                        id <ZMNetWorkManagerDelegate> delegate = model.delegate;
                        if (delegate && [delegate respondsToSelector:@selector(didChangeNetworkStatus:)]) {
                            [delegate didChangeNetworkStatus:ZMNetworkStatusReachableViaWiFi];
                        }
                    }
                    HBLog(@"WIFI在线网络");
                    break;
            }
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

#pragma mark - 有无网络
+ (BOOL)isNetwork{
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(ZMNetworkStatus)networkStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                HBLog(@"未知网络");
                [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusUnknown;
                networkStatus ? networkStatus(ZMNetworkStatusUnknown) : nil;
                break;
            
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                HBLog(@"没有网络");
                [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusNotReachable;
                networkStatus ? networkStatus(ZMNetworkStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                HBLog(@"手机自带网络");
                [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusReachableViaWWAN;
                networkStatus ? networkStatus(ZMNetworkStatusReachableViaWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [ZMNetWorkManager shareManager].netWorkStatus = ZMNetworkStatusReachableViaWiFi;
                networkStatus ? networkStatus(ZMNetworkStatusReachableViaWiFi) : nil;
                HBLog(@"WIFI在线");
                break;
        }
    }];
}

+ (NSString *)strUTF8Encoding:(NSString *)str{
    /*! ios9适配的话 打开第一个 */
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}

#pragma mark - 普通请求
+ (NSURLSessionTask *)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParameters:(NSDictionary *)parameters withSuccessBlock:(ResponseSuccess)successBlock withFailureBlock:(ResponseFail)failureBlock{
    if (urlString == nil){
        return nil;
    }
    if ([ZMNetWorkManager shareManager].netWorkStatus == ZMNetworkStatusNotReachable) {   //没有网络
        failureBlock([NSError errorWithDomain:@"connerror" code:0 userInfo:nil]);
        return nil;
    }
    /*! 检查地址中是否有中文 */
    //NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    AFHTTPSessionManager *manager = [self sharedAFManager];
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSString *pathStr = @"";
    if ([urlString hasPrefix:@"http"]) {
        pathStr=urlString;
    }else{
//        pathStr=[NSString stringWithFormat:@"%@%@",KBaseUrl,urlString];
    }
    NSURLSessionTask *sessionTask = nil;
    NSString *develop = nil,*userAgent = nil,*currenLanguage = @"";
#ifdef TestFlag
    develop = @"dev";
#endif
#ifdef TestBeta
    develop = @"beta";
#endif
#ifdef DisFlag
    develop = @"stable";
#endif
    // 系统语言
    NSArray *currenLanguageArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    if (currenLanguageArray.count) {
        currenLanguage = [currenLanguageArray objectAtIndex:0];
    }
    userAgent = [NSString stringWithFormat:@"HaoHaoZhu/%@ %@(iOS/%@; %@; %@)", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],develop, [[UIDevice currentDevice] systemVersion],[ZMHelpUtil deviceModelName],currenLanguage];
//    [[self sharedAFManager].requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    // vid_622c47e267b13d7c1d81a7e587cd7221
    [manager.requestSerializer setValue:@"visitor_token=vid_622c47e267b13d7c1d81a7e587cd7221;" forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:@"HaoHaoZhu/3.7.0 (iPhone; iOS 12.0; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
    
    HBLog(@"******************** 请求参数 ***************************");
    HBLog(@"请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n",
          [self sharedAFManager].requestSerializer.HTTPRequestHeaders, (type == Get) ? @"GET":@"POST",[NSMutableString stringWithFormat:@"%@",pathStr], parameters);
    HBLog(@"******************************************************");
    
    if (type == Get){
        sessionTask  = [manager GET:pathStr parameters:dicParams progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (successBlock){
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failureBlock){
                failureBlock(error);
            }
        }];
    }else if (type == Post){
        //添加头部信息
        
        sessionTask = [manager POST:pathStr parameters:dicParams progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (successBlock){
                successBlock(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failureBlock){
                failureBlock(error);
                HBLog(@"错误信息：%@",error);
            }
        }];
    }
    return sessionTask;
}

#pragma mark - 上传图片签名 + 登录验证
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL withParameters:(id)parameters withImageData:(NSData *)imageData withProgress:(UploadProgress)progress withSuccessBlock:(ResponseSuccess)successBlock withFailureBlock:(ResponseFail)failureBlock{
    NSURLSessionTask    *sessionTask = nil;
    NSMutableDictionary  *paramSortDic;
    NSMutableString *signatureString  =[NSMutableString string];
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        paramSortDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    }else{
        paramSortDic = [NSMutableDictionary dictionary];
    }

    NSArray *paramSortKeys = [paramSortDic allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [paramSortKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //拼接字符串
    for (NSString *paramKey in sortedArray) {
        [signatureString appendFormat:@"%@=%@&", paramKey, [paramSortDic objectForKey:paramKey]];
    }

    //参数加密
    NSString *md5String = [ZMHelpUtil md5:signatureString];
    paramSortDic[@"signature"] = md5String.uppercaseString;
    
    //增加请求头信息
    NSString *develop = nil,*userAgent = nil,*currenLanguage = @"";
    AFHTTPSessionManager *manager = [self sharedAFManager];

    // 系统语言
    NSArray *currenLanguageArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    if (currenLanguageArray.count) {
        currenLanguage = [currenLanguageArray objectAtIndex:0];
    }
    userAgent = [NSString stringWithFormat:@"kooidi/%@ %@(iOS/%@; %@; %@)", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey],develop, [[UIDevice currentDevice] systemVersion],[ZMHelpUtil deviceModelName],currenLanguage];
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    sessionTask = [manager POST:URL parameters:paramSortDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        HBLog(@"fileName------%@",fileName);
        // 上传图片，以文件流的格式  获取当前时间作为文件名
        //[formData appendPartWithFileData:data name:@"img" fileName:fileName mimeType:@"image/png"];
        [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (uploadProgress) {
                progress(uploadProgress);
            }
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failureBlock(error);
        }
    }];
    
    return sessionTask;
}

@end


@implementation ZMNetworkDelegateModel

- (instancetype)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

@end




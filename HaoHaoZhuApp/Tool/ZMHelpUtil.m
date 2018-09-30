//
//  ZMHelpUtil.m

//
//  Created by Brances on 2018/3/3.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHelpUtil.h"
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>
#include <mach/mach.h>
#import <sys/mount.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

struct utsname systemInfo;

@implementation ZMHelpUtil

+ (NSString *)timeFormatted:(NSInteger )totalSeconds{
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = (totalSeconds / 3600) % 24;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, seconds];
}
+ (NSString *)timeFormattedMinute:(NSInteger )totalSeconds{
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
}
+ (NSString *)dispose:(id)data{
    if (data == nil || [data isEqual:[NSNull null]]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",data];
}

+ (NSArray *)arrDispose:(id)data{
    if ([data isKindOfClass:[NSArray class]]) {
        return data;
    }
    return [NSArray array];
}

+ (NSDictionary *)dicDispose:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    return [NSDictionary dictionary];
}

+ (NSString *)getCurrenVersion{
    NSString *version = nil;
    version = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (long long)dataChangeTimeInterval:(NSDate *)date{
    long long time = 0;
    if ([date isKindOfClass:[NSDate class]]) {
        time = [date timeIntervalSince1970];
    }
    return time;
}

+ (NSDate *)getCurrenTimeZone:(NSDate *)date{
    if (!date) {
        date = [NSDate date];
    }
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+ (NSString *)getCurrenTimeText:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (NSString *)getCurrenFormatTime:(long long)timesp{
    NSTimeInterval time=(double)timesp;//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)getCurrenFormatTime:(long long)timesp format:(NSString *)format{
    NSTimeInterval time=(double)timesp;//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    if (!format.length) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }else{
        [dateFormatter setDateFormat:format];
    }
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"HH:mm"];
    NSString * todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    today=[ dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //startTime格式为 02:22   expireTime格式为 12:44
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}


+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour{
    NSDate *date8 = [self getCustomDateWithHour:fromHour];
    NSDate *date23 = [self getCustomDateWithHour:toHour];
    NSDate *currentDate = [NSDate date];
    if([currentDate compare:date8] == NSOrderedDescending && [currentDate compare:date23] == NSOrderedAscending){
        HBLog(@"该时间在 %ld:00-%ld:00 之间！", fromHour, toHour);
        return YES;
    }
    return  NO;
}

+ (NSDate *)getCustomDateWithHour:(NSInteger)hour{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}

+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size = CGSizeMake(contentWidth, 2000);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}

#pragma mark -  计算字符串长度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size = [text sizeWithAttributes:dict];
    return ceilf(size.width);
}

+ (CGFloat)widthForString:(NSString *)text font:(UIFont *)font{
    if (!font) {
        return 20.f;
    }
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize size = [text sizeWithAttributes:dict];
    return ceilf(size.width);
}

+ (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width text:(NSString *)text {
    CGFloat height = 0;
    if (text.length == 0) {
        height = 0;
    } else {
        NSDictionary *attribute = @{NSFontAttributeName:font};
        CGSize rectSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:NSStringDrawingTruncatesLastVisibleLine|
                           NSStringDrawingUsesLineFragmentOrigin|
                           NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
        height = rectSize.height;
    }
    return height;
}

//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+ (long long)changeTimeToTimeSp:(NSString *)timeStr{
    long long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [format setTimeZone:timeZone];
    time= (long long)[fromdate timeIntervalSince1970];
    return time;
}

//将时间戳按指定格式时间输出,spString为毫秒
+ (NSString*)nsdateToTime:(long long)spString formatStr:(NSString *)formatStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:spString/1000];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    //    @"yyyy-MM-dd HH:mm:ss"
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:formatStr];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}
//将时间戳按HH:mm格式时间输出,spString为毫秒
+ (NSString*)nsdateToTime:(long long)spString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:spString/1000];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    //    @"yyyy-MM-dd HH:mm:ss"
    [dateFormat setDateFormat:@"HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormat setTimeZone:timeZone];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}

+ (void)showFPSLabel{
#ifdef DEBUG
    YYFPSLabel *label = [[YYFPSLabel alloc] init];
    label.frame = CGRectMake(10, UISCREENHEIGHT - 49 - 30 - 10, 60, 30);
    [[[ UIApplication  sharedApplication] keyWindow] addSubview:label];
#endif
}

+ (NSString *)getAppDisplayName{
    NSString *name = @"";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return name;
}

+ (NSString*)deviceModelName{
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7plus";
    
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
//    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
//    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
//    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
//    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}

+ (NSString *)getUniqueDeviceIdentifierAsString{
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    NSString *applicationUUID =  [YYKeychain getPasswordForService:appName account:KKechainAcountUUIDName];
    if (applicationUUID == nil){
        applicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSError *error = nil;
        YYKeychainItem *query = [[YYKeychainItem alloc] init];
        query.service = appName;
        query.account = KKechainAcountUUIDName;
        query.password = applicationUUID;
        query.synchronizable = YYKeychainQuerySynchronizationModeNo;
        if ([YYKeychain insertItem:query error:&error]) {
            HBLog(@"插入唯一设备id成功");
        }else{
            HBLog(@"插入唯一设备id失败");
        }
    }
    return applicationUUID;
}

+ (void)gotoUrlSystemSetting{
    if (([UIDevice currentDevice].systemVersion.floatValue) >= 10) {
        //跳转方式变更
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }else{
        NSURL*url = [NSURL   URLWithString:@"prefs:root=Privacy"];
        [[UIApplication sharedApplication] openURL:url];
    }
}


+ (void)opendAppstore{
    
}

+ (UIAlertController *)createAlertWithTitle:(NSString *)title message:(NSString *)message controllStyle:(UIAlertControllerStyle)style leftText:(NSString *)leftText rightText:(NSString *)rightText cancleHandler:(void(^)(UIAlertAction *cancleAction))cancleHandler confirmHandler:(void(^)(UIAlertAction *confirmAction))confirmHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (rightText.length) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightText style:UIAlertActionStyleDefault handler:confirmHandler];
        [alertController addAction:confirmAction];
    }
    if (leftText.length) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftText style:UIAlertActionStyleCancel handler:cancleHandler];
        [alertController addAction:cancleAction];
    }
    return alertController;
}

+ (BOOL)checkPhoneNum:(NSString *)phone{
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *regexStr = @"^1[0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    BOOL isMatch = [pred evaluateWithObject:phone];
    return isMatch;
}

+ (NSString *)stringByTrimSpace:(NSString *)text{
    NSString *result = @"";
    if ([text isKindOfClass:[NSString class]] && text.length) {
        result = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return result;
}

+ (BOOL)checkPasswordFormat:(NSString *)password{
    NSString *regexStr = @"^[a-zA-Z0-9]{6,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)checkNotificationIsOpen{
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
        return NO;
    }else{
        return YES;
    }
}

+ (BOOL)checkLocationServiceIsOpen{
    if ([CLLocationManager locationServicesEnabled]){
        //system location enabled
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
            [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways){
            return YES;
        }
        return NO;
    }
    return NO;
}

+ (UIViewController *)getCurrenVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    if (![window subviews].count) {
        return nil;
    }
    UIView *frontView = [[window subviews] objectAtIndex : 0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        result = [((UINavigationController *)nextResponder).viewControllers lastObject];
    }else if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result;
}

//md5 encode
+(NSString *) md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    return output;
}

#pragma mark - 判断相机是否可用
+ (BOOL)isCameravail{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限
        return NO;
    }
    return   [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - 判断图库是否可用
+ (BOOL)isPhotoLibrary{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}

+ (void)callPhone:(NSString *)phoneNum {
    NSString *callPhone = [NSString stringWithFormat:@"tel://%@", phoneNum];
    /// 解决iOS10及其以上系统弹出拨号框延迟的问题
    /// 方案一
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        /// 10及其以上系统
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        /// 10以下系统
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

+(UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (void)openShakeFeedback:(UIImpactFeedbackStyle)style{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *impactFeedBack = [[UIImpactFeedbackGenerator alloc] initWithStyle:style];
        [impactFeedBack prepare];
        [impactFeedBack impactOccurred];
    }
}

+ (void)openNormalShakeFeedback{
    [ZMHelpUtil openShakeFeedback:UIImpactFeedbackStyleMedium];
}

+ (CGSize)getImageSizeWithUrl:(NSString *)url{
    CGSize size;
    //解析图片宽高
    NSArray *imageInfo = [url componentsSeparatedByString:@"&"];
    HBLog(@"=%@",imageInfo);
    //遍历数组取出宽高
    CGFloat width = 0,height = 0;
    for (int i = 0; i < imageInfo.count; i++) {
        NSString *preStr = [imageInfo safeObjectAtIndex:i];
        if ([preStr hasPrefix:@"w="] || [preStr hasPrefix:@"h="]) {
            if ([preStr hasPrefix:@"w"]) {
                NSScanner *scanner = [NSScanner scannerWithString:preStr];
                [scanner scanUpToCharactersFromSet:[NSCharacterSet
                                                    decimalDigitCharacterSet] intoString:nil];
                float number;
                [scanner scanFloat:&number];
                width = number;
            }else{
                NSScanner *scanner = [NSScanner scannerWithString:preStr];
                [scanner scanUpToCharactersFromSet:[NSCharacterSet
                                                    decimalDigitCharacterSet] intoString:nil];
                float number;
                [scanner scanFloat:&number];
                height = number;
            }
        }
    }
    size = CGSizeMake(width, height);
    return size;
}

+ (NSString *)dictionaryToJsonString:(NSDictionary *)dic{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted  error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSDictionary *)jsonStrinToDictionary:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (AppDelegate *)getCurrenAppdegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (NSString *)documentDirectory:(NSString *)filename{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documents stringByAppendingPathComponent:filename];
}

+ (BOOL)saveSingleObject:(id)object to:(NSString *)filename{
    NSString *path = [self documentDirectory:filename];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:path];
    HBLog(@"单个文件%@", success ? @"存储成功" : @"存储失败");
    return success;
}
//反归档
+ (id)loadSingleObjectFrom:(NSString *)filename{
    NSString *path = [self documentDirectory:filename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return object;
}

@end

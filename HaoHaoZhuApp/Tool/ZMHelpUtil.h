//
//  ZMHelpUtil.h
//
//
//  Created by Brances on 2018/3/3.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYFPSLabel.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
@interface ZMHelpUtil : NSObject

#pragma mark - 将整型时间格式化为01:58:23;
+ (NSString *)timeFormatted:(NSInteger )totalSeconds;
#pragma mark - 将整型时间格式化为01:23;
+ (NSString *)timeFormattedMinute:(NSInteger )totalSeconds;

#pragma mark - 格式化为不奔溃的字符串
+ (NSString *)dispose:(id)data;
#pragma mark - 格式化数组
+ (NSArray *)arrDispose:(id)data;
#pragma mark - 格式化字典
+ (NSDictionary *)dicDispose:(id)data;
#pragma mark - 获取当前版本号
+ (NSString *)getCurrenVersion;
#pragma mark - 日期转时间戳
+ (long long)dataChangeTimeInterval:(NSDate *)date;
#pragma mark - 时间戳转日期
+ (NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap;
#pragma mark - 将当前日期转为当前时区日期
+ (NSDate *)getCurrenTimeZone:(NSDate *)date;
#pragma mark - 将当前日期转为当前时间年月日 = yyyy-MM-dd
+ (NSString *)getCurrenTimeText:(NSDate *)date;
#pragma mark - 将时间戳转为yyyy-MM-dd : HH:mm:ss 格式
+ (NSString *)getCurrenFormatTime:(long long)timesp;
#pragma mark - 将时间戳转为yyyy-MM-dd 格式
+ (NSString *)getCurrenFormatTime:(long long)timesp format:(NSString *)format;
#pragma mark - 判断时间是否在某一天的某个时间段
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime;
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;
#pragma mark - 计算字符串高度
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth;
#pragma mark - 计算字符串宽度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font;
#pragma mark - 计算字符串宽度-UIFont
+ (CGFloat)widthForString:(NSString *)text font:(UIFont *)font;
#pragma mark - 计算字符串高度
+ (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width text:(NSString *)text;
#pragma mark - 将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+ (long long)changeTimeToTimeSp:(NSString *)timeStr;
#pragma mark - 将时间戳按指定格式时间输出,spString为毫秒
+ (NSString*)nsdateToTime:(long long)spString formatStr:(NSString *)formatStr;
+ (NSString*)nsdateToTime:(long long)spString;
#pragma mark - 显示FPS
+ (void)showFPSLabel;
#pragma mark - 获取app名称
+ (NSString *)getAppDisplayName;
#pragma mark - 获取设备名称
+ (NSString*)deviceModelName;
#pragma mark - 获取设备唯一标识符（APP删除后还可以获取到）
+ (NSString *)getUniqueDeviceIdentifierAsString;
#pragma mark - 跳转用户隐私设置界面
+ (void) gotoUrlSystemSetting;
#pragma mark - 跳转到APPStore
+ (void) opendAppstore;
#pragma mark - 返回UIAlertController
+ (UIAlertController *)createAlertWithTitle:(NSString *)title message:(NSString *)message controllStyle:(UIAlertControllerStyle)style leftText:(NSString *)leftText rightText:(NSString *)rightText cancleHandler:(void(^)(UIAlertAction *cancleAction))cancleHandler confirmHandler:(void(^)(UIAlertAction *confirmAction))confirmHandler;
#pragma mark - 判断1开头的11位数字
+ (BOOL)checkPhoneNum:(NSString *)phone;
#pragma mark - 去除字符串中的空格
+ (NSString *)stringByTrimSpace:(NSString *)text;
#pragma mark - 验证密码格式（6-15位字母或数字）
+ (BOOL)checkPasswordFormat:(NSString *)password;
#pragma mark - 是否打开通知权限
+ (BOOL)checkNotificationIsOpen;
#pragma mark - 是否打开定位服务
+ (BOOL)checkLocationServiceIsOpen;

#pragma mark - 获取当前window显示的控制器
+ (UIViewController *)getCurrenVC;
#pragma mark - MD5加密
+(NSString *) md5:(NSString *)str;
#pragma mark - 判断相机是否可用
+ (BOOL)isCameravail;
#pragma mark - 判断图库是否可用
+ (BOOL)isPhotoLibrary;
#pragma mark - 压缩图片质量
+ (NSData *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
#pragma mark - 拨打电话
+ (void)callPhone:(NSString *)phoneNum;
#pragma mark - 改变图片方向
+ (UIImage *)fixOrientation:(UIImage *)aImage;
#pragma mark - 打开震动反馈
+ (void)openShakeFeedback:(UIImpactFeedbackStyle)style;
#pragma mark - 打开默认震动反馈
+ (void)openNormalShakeFeedback;
#pragma mark - 根据字符串解析出图片宽高
+ (CGSize)getImageSizeWithUrl:(NSString *)url;
#pragma mark - 字典转json字符串
+ (NSString *)dictionaryToJsonString:(NSDictionary *)dic;
#pragma mark - json字符串转字典
+ (NSDictionary *)jsonStrinToDictionary:(NSString *)jsonString;
#pragma mark - 获取appdelegate对象
+ (AppDelegate *)getCurrenAppdegate;
#pragma mark - 获取documents文件夹下对应的目录
+ (NSString *)documentDirectory:(NSString *)filename;
#pragma mark - 归档
+ (BOOL)saveSingleObject:(id)object to:(NSString *)filename;
#pragma mark - 解档
+ (id)loadSingleObjectFrom:(NSString *)filename;
#pragma mark - 将 date 格式化成微博的友好显示
+ (NSString *)stringWithTimelineDate:(NSDate *)date;

@end

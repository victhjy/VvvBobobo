//
//  VBTools.h
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBTools : NSObject
/**
 *  16进制颜色
 *
 *  @param hexColorString 16进制值
 *
 *  @return 16进制对应颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;

/**
 *  根据字典生成属性
 *
 *  @param dic 输入的字典
 */
+(void)importADic:(NSDictionary*)dic;

/**
 *  根据字符串字体获取字符串大小
 *
 *  @param text 字符串
 *  @param size **
 *  @param font 字体
 *
 *  @return 所占位置
 */
+(CGSize)string:(NSString* )text boundingRectWithSize:(CGSize)size font:(UIFont* )font;

/**
 *  字符串转字符串时间
 *
 *  @param string 时间格式的字符串
 *
 *  @return 时间字符串，月月-日日 时时：分分
 */
+(NSString* )stringDateFromString:(NSString* )string;

/**
 *  缓存数据
 *
 *  @param object 需要缓存的数据
 *  @param key    key
 */
+(void)cacheData:(NSObject* )object withKey:(NSString* )key;

/**
 *  获取缓存
 *
 *  @param key key
 *
 *  @return 取出的缓存
 */
+(NSObject* )getCacheDataForKey:(NSString* )key;

/**
 *  utc时间转换成本地时间
 *
 *  @param anyDate utc时间
 *
 *  @return 本地时间
 */
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

/**
 *  讲字符串转换成nsdate
 *
 *  @param dateString 时间型字符串
 *
 *  @return NSDate型时间
 */
+(NSDate* )getDateFromDataString:(NSString* )dateString;


/**
 *  nsdate转字符串
 *
 *  @param date 输入NSDate
 *
 *  @return 输出字符串型的时间 10-12 12：00
 */
+(NSString* )dateStringFromNSDate:(NSDate* )date;

/**
 *  showMessage
 *
 *  @param message 提示信息
 *  @param view  提示的界面
 *
 *
 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view seconds:(int )sec;

/**
 *  输入链接中的参数部分，转换为对应数组
 *
 *  @param paramString 链接参数
 */
+(void)getArrayFromParamString:(NSString* )paramString;

+(void)MBHudShow;

+(void)MBHudHidden;

//解析新浪微博中的日期
+ (NSString*)resolveSinaWeiboDate:(NSString*)date;

@end

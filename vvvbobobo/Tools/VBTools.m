//
//  VBTools.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBTools.h"

@implementation VBTools
+ (UIColor *)colorWithHexString:(NSString *)hexColorString {
    if ([hexColorString length] < 6) { //长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString = [hexColorString lowercaseString];
    if ([tempString hasPrefix:@"0x"]) { //检查开头是0x
        tempString = [tempString substringFromIndex:2];
    } else if ([tempString hasPrefix:@"#"]) { //检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] != 6) {
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range = NSMakeRange(0, 2);
    NSString *rString = [tempString substringWithRange:range];
    range.location = 2;
    NSString *gString = [tempString substringWithRange:range];
    range.location = 4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0f];
}

/**
 *  根据字典生成属性
 *
 *  @param dic 输入的字典
 */
+(void)importADic:(NSDictionary*)dic{
    NSMutableString *codes = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString* code;
        if ([obj isKindOfClass:[NSString class]]) {
            code=[NSString stringWithFormat:@"@property(nonatomic,strong)NSString* %@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }
        else if([obj isKindOfClass:[NSArray class]]){
            code=[NSString stringWithFormat:@"@property(nonatomic,strong)NSArray* %@;",key];
        }
        else if([obj isKindOfClass:[NSDictionary class]]){
            code=[NSString stringWithFormat:@"@property(nonatomic,strong)NSDictionary* %@;",key];
        }
        else if([obj isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }
        [codes appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"%@",codes);
}

/**
 *  根据字符串字体获取字符串大小
 *
 *  @param text 字符串
 *  @param size **
 *  @param font 字体
 *
 *  @return 所占位置
 */
+(CGSize)string:(NSString* )text boundingRectWithSize:(CGSize)size font:(UIFont* )font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}

/**
 *  字符串转字符串时间
 *
 *  @param string 时间格式的字符串
 *
 *  @return 时间字符串，月月-日日 时时：分分
 */
+(NSString* )stringDateFromString:(NSString* )string{
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    
    NSDateFormatter *stringFormatter = [[NSDateFormatter alloc] init] ;
    [stringFormatter setDateFormat:@"MM-dd hh:mm"];
    NSString* returnString=[stringFormatter stringFromDate:date];
    
    
    return returnString;
}

/**
 *  缓存数据
 *
 *  @param object 需要缓存的数据
 *  @param key    key
 */
+(void)cacheData:(NSObject* )object withKey:(NSString* )key{
    NSData* data=[NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    [userdefault setObject:data forKey:key];
    [userdefault synchronize];
}

/**
 *  获取缓存
 *
 *  @param key key
 *
 *  @return 取出的缓存
 */
+(NSObject* )getCacheDataForKey:(NSString* )key{
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    NSData* data=[userdefault objectForKey:key];
    NSObject* obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return obj;
}

/**
 *  utc时间转换成本地时间
 *
 *  @param anyDate utc时间
 *
 *  @return 本地时间
 */
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

/**
 *  将字符串转换成nsdate
 *
 *  @param dateString 时间型字符串
 *
 *  @return NSDate型时间
 */
+(NSDate* )getDateFromDataString:(NSString* )dateString{
    //需要转换的字符串
    //    NSString *dateString = @"2015-06-26 08:08:08";
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

/**
 *  nsdate转字符串
 *
 *  @param date 输入NSDate
 *
 *  @return NSString 10-12 12:00
 */
+(NSString* )dateStringFromNSDate:(NSDate* )date{
    NSDateFormatter *stringFormatter = [[NSDateFormatter alloc] init] ;
    [stringFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString* returnString=[stringFormatter stringFromDate:date];
    return returnString;
}

/**
 *  showMessage
 *
 *  @param message 提示信息
 *  @param view  提示的界面
 *
 *
 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view seconds:(int )sec{
    //kScreenWidth-80
    MBProgressHUD * hud=[[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    
    //    CGSize size = [message sizeWithFont:font maxWidth:maxWidth];
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize size;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize maxSize = CGSizeMake(UIScreenWidth - 80, MAXFLOAT);
    
    // 获得系统版本
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    size =  [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
#else
    size = [message sizeWithFont:font constrainedToSize:maxSize];
#endif
    
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    customLabel.lineBreakMode = NSLineBreakByWordWrapping;
    customLabel.font = font;
    customLabel.numberOfLines = 0;
    customLabel.textColor = [UIColor blackColor];
    customLabel.text = message;
    hud.userInteractionEnabled = NO;
    
    hud.customView = customLabel;
    hud.mode = MBProgressHUDModeCustomView;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:sec];
}

/**
 *  输入链接中的参数部分，转换为对应数组
 *
 *  @param paramString 链接参数
 */
+(void)getArrayFromParamString:(NSString* )paramString{
    NSArray* arr=[paramString componentsSeparatedByString:@"&"];
    NSMutableArray* muArr=[NSMutableArray new];
    for (int  i = 0; i<arr.count; i++) {
        [muArr addObject:[[NSString stringWithFormat:@"气@\"%@",arr[i]] stringByReplacingOccurrencesOfString:@"=" withString:@"\":气@\""]];
    }
    VBLog(@"%@",muArr);
}

+(void)MBHudShow{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+(void)MBHudHidden{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}


@end

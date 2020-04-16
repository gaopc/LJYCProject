//
//  NSDate+convenience.h
//  
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
   NSDate (Convenience) 是 Category（IOS的分类）
   使用是定义
   NSDate *currentMonth = [NSDate date]; 
   currentMonth 就可以调用里面的方法
  [currentMonth year:date];
*/

@interface NSDate (Convenience)

-(NSDate *)offsetMonth:(int)numMonths;
-(NSDate *)offsetDay:(int)numDays;
-(NSDate *)offsetHours:(int)hours;
-(int)numDaysInMonth;
//获取当前日期
-(int)firstWeekDayInMonth;
-(int)year;
-(int)year:(NSDate *)date;
-(int)month;
-(int)month:(NSDate *)date;
-(int)day;
-(int)day:(NSDate *)date;
+(NSDate *)dateStartOfDay:(NSDate *)date;
+(NSDate *)dateStartOfWeek;
+(NSDate *)dateEndOfWeek;

//month个月后的日期
- (NSDate *)dateafterMonth:(int)month;
//day个日后的日期
+ (NSDate *)dateafterDay:(NSDate *)date day:(int)day;

// 张晓婷 20120923 添加
+ (NSString *)dateafterDay:(NSDate *)date day:(int)day type:(int )type;
+(NSString *)dateFormateTicketQuery:(NSDate *)date;

+(NSString *)dateFormateCarQuery:(NSDate *)date;



//获取节日与上班的时间
- (NSMutableDictionary *)getGregorianDict:(NSDate *)date;

//日期显示格式年 月 日
+ (NSString *)dateStr:(NSDate*)date;
//日期传递格式2012-01-01
+ (NSString *)dateCode:(NSDate*)date;
//日期传递格式2012-11-04 
+ (NSString *)laterDateStr:(NSDate*)date;
//日期传递格式2012-01-01 10:00
+ (NSString *)dateTimeCode:(NSDate*)date;
//NSString类型转换成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString;
//当期日期是周几
+ (NSString *)getWeekDay:(NSDate*)date;
+ (NSString *)getWeekDayLongStr:(NSString*)dateStr;

- (NSString *)stringWithFormat:(NSString *)fmt;
+ (NSDate *)dateFromString:(NSString *)str withFormat:(NSString *)fmt;
+ (NSDate *)dateFromString:(NSString *)str withFormat:(NSString *)fmt locale:(NSLocale *)locale;

//两个日期相差天数
+ (int ) dayInterval :(NSDate *)starDate withEndDay:(NSDate *)etarDate;

@end

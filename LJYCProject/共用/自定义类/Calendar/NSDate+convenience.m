//
//  NSDate+convenience.m
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import "NSDate+convenience.h"

@implementation NSDate (Convenience)

//获取系统日期年份
-(int)year {
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
	return [components year];
}
//获取传递日期年份
-(int)year:(NSDate *)date {
	
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:date];
	
	return [components year];
}
//获取系统日期月份
-(int)month {
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
	return [components month];
}
//获取传递日期月份
-(int)month:(NSDate *)date {
	
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:date];
	return [components month];
}

//获取系统日期天
-(int)day {
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
	return [components day];
}
//获取传递日期天
-(int)day:(NSDate *)date {
	
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:date];
	return [components day];
}

//获取当前日期
-(int)firstWeekDayInMonth {
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	[gregorian setFirstWeekday:2]; //monday is first day
	//[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
	
	//Set date to first of month
	NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self];
	[comps setDay:1];
	NSDate *newDate = [gregorian dateFromComponents:comps];
	
	return [gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:newDate];
}

-(NSDate *)offsetMonth:(int)numMonths {
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	[gregorian setFirstWeekday:2]; //monday is first day
	
	NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init]autorelease];
	[offsetComponents setMonth:numMonths];
	return [gregorian dateByAddingComponents:offsetComponents
					  toDate:self options:0];
}


-(NSDate *)offsetHours:(int)hours {
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	[gregorian setFirstWeekday:2]; //monday is first day
	
	NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init]autorelease];
	//[offsetComponents setMonth:numMonths];
	[offsetComponents setHour:hours];
	//[offsetComponents setMinute:30];
	return [gregorian dateByAddingComponents:offsetComponents
					  toDate:self options:0];
}

-(NSDate *)offsetDay:(int)numDays {
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	[gregorian setFirstWeekday:2]; //monday is first day
	
	NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init]autorelease];
	[offsetComponents setDay:numDays];
	//[offsetComponents setHour:1];
	//[offsetComponents setMinute:30];
	
	return [gregorian dateByAddingComponents:offsetComponents
					  toDate:self options:0];
}



-(int)numDaysInMonth {
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
	NSUInteger numberOfDaysInMonth = rng.length;
	return numberOfDaysInMonth;
}

+(NSDate *)dateStartOfDay:(NSDate *)date {
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	
	NSDateComponents *components =
	[gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
			       NSDayCalendarUnit) fromDate: date];
	return [gregorian dateFromComponents:components];
}

+(NSDate *)dateStartOfWeek {
	NSCalendar *gregorian = [[[NSCalendar alloc]
				  initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	[gregorian setFirstWeekday:2]; //monday is first day
	
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
	
	NSDateComponents *componentsToSubtract = [[[NSDateComponents alloc] init]autorelease];
	[componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
					  + 7 ) % 7)];
	NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
	
	NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
							    fromDate: beginningOfWeek];
	
	//gestript
	beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
	
	return beginningOfWeek;
}

+(NSDate *)dateEndOfWeek {
	NSCalendar *gregorian =[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
	
	
	NSDateComponents *componentsToAdd = [[[NSDateComponents alloc] init]autorelease];
	[componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
				      + 7 ) % 7))+6];
	NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
	
	NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
							    fromDate: endOfWeek];
	
	//gestript
	endOfWeek = [gregorian dateFromComponents: componentsStripped];
	return endOfWeek;
}

//month个月后的日期
- (NSDate *)dateafterMonth:(int)month
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
	[componentsToAdd setMonth:month];
	NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
	[componentsToAdd release];
	return dateAfterMonth;
}
//day个日后的日期
+ (NSDate *)dateafterDay:(NSDate *)date day:(int)day 
{
	NSCalendar *gregorian =[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *componentsToAdd = [[[NSDateComponents alloc] init]autorelease];
	[componentsToAdd setDay:day];
	NSDate *dateAfterDay = [gregorian dateByAddingComponents:componentsToAdd toDate:date options:0];
	
	NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
							    fromDate: dateAfterDay];
	dateAfterDay = [gregorian dateFromComponents: componentsStripped];
	return dateAfterDay;
        
}

+(NSString *)dateFormateTicketQuery:(NSDate *)date
{
	NSArray * dateArray =  [[NSDate dateCode:date ] componentsSeparatedByString:@"-"];
	NSString * month = [dateArray objectAtIndex:1];
	NSString * day = [dateArray objectAtIndex:2];
	NSString * week = [NSDate getWeekDay:date];
	return  [NSString stringWithFormat:@"%@%@月-%@",week,month,day];
}

+(NSString *)dateFormateCarQuery:(NSDate *)date // 09月-28日-周五
{
	NSArray * dateArray =  [[NSDate dateCode:date ] componentsSeparatedByString:@"-"];
	NSString * month = [dateArray objectAtIndex:1];
	NSString * day = [dateArray objectAtIndex:2];
	NSString * week = [NSDate getWeekDay:date];
	return  [NSString stringWithFormat:@"%@月-%@-%@",month,day,week];
}

+ (NSString *)dateafterDay:(NSDate *)date day:(int)day type:(int )type
{
	NSCalendar *gregorian =[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *componentsToAdd = [[[NSDateComponents alloc] init]autorelease];
	[componentsToAdd setDay:day];
	NSDate *dateAfterDay = [gregorian dateByAddingComponents:componentsToAdd toDate:date options:0];
	
	NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
							    fromDate: dateAfterDay];
	dateAfterDay = [gregorian dateFromComponents: componentsStripped];
	
	NSDateFormatter* format = [[NSDateFormatter alloc]init];
	switch (type) {
		case 0:
			[format setDateFormat:@"yyyy年MM月dd日"];
			break;
		case 1:
			[format setDateFormat:@"yyyy-MM-dd"];
			break;
		case 2:
			[format setDateFormat:@"yyyyMMdd"];   
			break;
		case 3: // 返回机票查询的样式 周五09月28
			[format release];
			return [NSDate dateFormateTicketQuery:dateAfterDay];
			break;
		case 4: // 返回机票查询的样式 周五09月28
			[format release];
			return [NSDate dateFormateCarQuery:dateAfterDay];
			break;
		case 5: // 返回机票查询的样式 周五09月28
			[format setDateFormat:@"yyyy-MM-dd HH:mm"];
			break;
		case 6: // 返回机票查询的样式 周五09月28
			[format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
			break;
		default:
			break;
	}
	NSString* time = [format stringFromDate: dateAfterDay]; 
	[format release];
	return time;
}



//获取节日与上班的时间
- (NSMutableDictionary *) getGregorianDict:(NSDate *)date
{
	NSMutableDictionary * gregorianDict= [[[NSMutableDictionary alloc] init] autorelease];
	[gregorianDict setObject:@"2012-2014" forKey:@"year"];
	NSCalendar *localeCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDictionary *yearHoliDay = [NSDictionary dictionaryWithObjectsAndKeys: @"元旦", @"1-1",@"2", @"1-2",@"3", @"1-3", @"除夕", @"2-9", @"春节",@"2-10", @"11", @"2-11",@"12", @"2-12",@"13",@"2-13",@"14", @"2-14",@"15", @"2-15",@"清明", @"4-4",@"5", @"4-5",@"6", @"4-6",@"29", @"4-29",@"30", @"4-30",@"劳动", @"5-1",@"10", @"6-10",@"11", @"6-11", @"端午", @"6-12", @"中秋", @"9-19",@"20", @"9-20",@"21", @"9-21", @"国庆", @"10-1",@"2", @"10-2",@"3", @"10-3",@"4", @"10-4",@"5", @"10-5",@"6", @"10-6",@"7", @"10-7", nil];
	NSDictionary *yearWork = [NSDictionary dictionaryWithObjectsAndKeys: @"5",@"1-5",@"6",@"1-6",@"16",@"2-16",@"17",@"2-17", @"7", @"4-7", @"27",@"4-27",@"28", @"4-28",@"8",@"6-8",@"9",@"6-9", @"22",@"9-22", @"29",@"9-29",@"12",@"10-12",nil];  
	NSDictionary *nextYearHoliDay = [NSDictionary dictionaryWithObjectsAndKeys: @"元旦", @"1-1", @"除夕", @"1-30", @"春节",@"1-31",@"清明", @"4-5", @"劳动", @"5-1",@"端午",@"6-2",@"中秋",@"9-8",@"国庆", @"10-1", nil];
	
	NSDateComponents *localeComp =[localeCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:date];
	NSString *key_str = [NSString stringWithFormat:@"%d-%d",localeComp.month,localeComp.day];
	NSString *holiday = [yearHoliDay objectForKey:key_str]; 
	NSString *work = [yearWork objectForKey:key_str];
	NSString *nextHoliday = [nextYearHoliDay objectForKey:key_str]; 
	
	if (holiday) 
		[gregorianDict setObject:holiday forKey:@"holiday"];
	if (work) 
		[gregorianDict setObject:work forKey:@"work"];
	if (nextHoliday) 
		[gregorianDict setObject:nextHoliday forKey:@"nextHoliday"];
	
	return gregorianDict;
	
	
	
}

//日期显示格式年 月 日
+ (NSString *)dateStr:(NSDate*)date
{
	NSDateFormatter* format = [[NSDateFormatter alloc]init];
	[format setDateFormat:@"yyyy年MM月dd日"];
	NSString* time = [format stringFromDate: date]; // [NSDate date]
	[format release];
	return time;
}
//日期传递格式2012-01-01
+ (NSString *)dateCode:(NSDate*)date
{
	NSDateFormatter* format = [[NSDateFormatter alloc]init];
	[format setDateFormat:@"yyyy-MM-dd"];
	NSString* time = [format stringFromDate: date]; // [NSDate date]
	[format release];
	return time;
}

//日期传递格式2012-11-04 
+ (NSString *)laterDateStr:(NSDate*)date
{
	NSDateFormatter* format = [[NSDateFormatter alloc]init];
	[format setDateFormat:@"yyyy-MM-dd HH:mm"];
	NSString* time = [format stringFromDate: date]; // [NSDate date]
	[format release];
	return time;
}

//NSString类型转换成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat: @"yyyy-MM-dd"]; 
	NSDate *destDate= [dateFormatter dateFromString:dateString];
	[dateFormatter release];
	return destDate;
}

//日期传递格式2012-01-01 10:00
+ (NSString *)dateTimeCode:(NSDate*)date
{
	NSDateFormatter* format = [[NSDateFormatter alloc]init];
	[format setDateFormat:@"yyyy-MM-dd HH:mm"];
	NSString* time = [format stringFromDate: date]; // [NSDate date]
	[format release];
	return time;
}

//当期日期是周几
+ (NSString *)getWeekDay:(NSDate*)date
{
	NSCalendar *gregorian =[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:date];
	
	NSString *timeString = nil;
	switch ([components weekday]) {
		case 1:
			timeString=@"周日";
			break;
		case 2:
			timeString=@"周一";
			break;
		case 3:
			timeString=@"周二";
			break;
		case 4:
			timeString=@"周三";
			break;
		case 5:
			timeString=@"周四";
			break;
		case 6:
			timeString=@"周五";
			break;
		case 7:
			timeString=@"周六";
			break;
		default:
			break;
	}
	return timeString;
}
+ (NSString *)getWeekDayLongStr:(NSString*)dateStr
{
	NSDate * date = [self dateFromString:dateStr];
	NSCalendar *gregorian =[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSDateComponents *components = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:date];
	
	NSString *timeString = nil;
	switch ([components weekday]) {
		case 1:
			timeString=@"星期日";
			break;
		case 2:
			timeString=@"星期一";
			break;
		case 3:
			timeString=@"星期二";
			break;
		case 4:
			timeString=@"星期三";
			break;
		case 5:
			timeString=@"星期四";
			break;
		case 6:
			timeString=@"星期五";
			break;
		case 7:
			timeString=@"星期六";
			break;
		default:
			break;
	}
	return timeString;
}
- (NSString*)stringWithFormat:(NSString*)fmt {
	static NSDateFormatter *fmtter;
	
	if (fmtter == nil) {
		fmtter = [[NSDateFormatter alloc] init];
	}
	
	if (fmt == nil || [fmt isEqualToString:@""]) {
		fmt = @"HH:mm:ss";
	}
	
	[fmtter setDateFormat:fmt];
	
	return [fmtter stringFromDate:self];
}


+ (NSDate *)dateFromString:(NSString*)str withFormat:(NSString*)fmt {
	return [self dateFromString:str withFormat:fmt locale:nil];
}


+ (NSDate *)dateFromString:(NSString*)str withFormat:(NSString*)fmt locale:(NSLocale *)locale {
	static NSDateFormatter *fmtter;
	
	if (fmtter == nil) {
		fmtter = [[NSDateFormatter alloc] init];
	}
	
	if (fmt == nil || [fmt isEqualToString:@""]) {
		fmt = @"HH:mm:ss";
	}
	
	[fmtter setDateFormat:fmt];
	if (locale != nil) {
		[fmtter setLocale:locale];
	}
	
	return [fmtter dateFromString:str];
}

//两个日期相差天数
+ (int ) dayInterval :(NSDate *)starDate withEndDay:(NSDate *)etarDate {
	
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	unsigned int unitFlags = NSDayCalendarUnit;
	NSDateComponents *comps = [gregorian components:unitFlags fromDate:starDate  toDate:etarDate  options:0];
	int days = [comps day];
	return days; 
}



@end

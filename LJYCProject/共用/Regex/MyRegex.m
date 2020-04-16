//
//  MyRegex.m
//  FlightProject
//
//  Created by green kevin on 12-11-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyRegex.h"

@implementation MyRegex


//检查名字
+(BOOL)checkname:(NSString*)name
{
	if ([name isMatchedByRegex:NUMBER]) {
		return NO;
	}
	if ([[name componentsSeparatedByRegex:NAME_CHINESE] count] == 0)
	{
		return YES;
	}
	else if ([[name componentsSeparatedByRegex:NAME_ENGLISH] count] == 0)
	{
		NSArray *nameArray = [name componentsSeparatedByString:@"/"];
		
		if ([nameArray count] == 2) 
		{
			if ([[nameArray objectAtIndex:0] length] != 0 && [[nameArray objectAtIndex:1] length] != 0) 
			{
				return YES;
			}
		}
	}
	else if ([[name componentsSeparatedByRegex:NAME_CHINESE_ENGLISH] count] == 0 && [[[name substringToIndex:1] componentsSeparatedByRegex: @"\\b[\u4e00-\u9fa5]\\b"] count] == 0)
	{
		NSArray *str = [name componentsSeparatedByRegex:@"\\b[\u4e00-\u9fa5]\\b"];
		NSLog(@"%@", str);
		for (int i = 0; i < [name length]; i ++)
		{
			NSString *aa = [name substringWithRange:NSMakeRange(i, 1)];
			NSLog(@"aa= %@", aa);
			if ([[aa componentsSeparatedByRegex: @"\\b[a-zA-Z]\\b"] count] == 0)
			{
				NSString *tmp = [name substringFromIndex:i];
				NSLog(@"tmp = %@", tmp);
				NSLog(@"%@", [tmp componentsSeparatedByRegex:@"\\b[a-zA-Z]{1,55}\\b"]);
				if ([[tmp componentsSeparatedByRegex:@"\\b[a-zA-Z]{1,55}\\b"] count] == 0) 
				{
					return YES;
				}
				else {
					return NO;
				}
			}
		}
	}
	
	return NO;
}
//验证身份证号码的合法性
+(BOOL)checkIsCertificateNum:(NSString *)str
{
	if ([str length] == 18) 
	{
		NSString *Certificatenum = @"";
		if ([str length] == 18) 
		{
			Certificatenum = @"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)[0-9]{4}(19[0-9]{2}|200[0-9]|2010)(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[0-9]{3}[0-9xX]$";
		}
		NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Certificatenum];
		BOOL res = [regExPredicate evaluateWithObject:str];
		if (res && [str length] == 18) 
		{
			res = [self CheckLastNum:str];
		}
		return res;
	}
	else
	{
		return NO;
	}
}
+(BOOL)CheckLastNum:(NSString*)strNum
{
	NSMutableArray * certificate = [[NSMutableArray alloc]initWithCapacity:4];
	NSArray* compareStr = [NSArray arrayWithObjects:@"1",@"0",@"x",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",nil];
	NSArray* wi = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1", nil];
	int sum = 0;
	for (int i = 0; i < [strNum length]; i++) 
	{
		NSRange range = NSMakeRange(i, 1);
		NSString* temp = [NSString stringWithString:[strNum substringWithRange:range]];
		[certificate addObject:temp];
	}
	for (int j = 0; j < [certificate count]-1; j++) 
	{
		sum += [[certificate objectAtIndex:j]intValue]*[[wi objectAtIndex:j]intValue]; 
	}
	int index = sum % 11;
	if (![[certificate objectAtIndex:17] caseInsensitiveCompare:[compareStr objectAtIndex:index]]) 
	{
		return YES;
	}
	else
	{
		return NO;
	}
}

@end

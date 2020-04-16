//
//  UserInfoDataResponse.m
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "UserInfoDataResponse.h"

@implementation UserInfoDataResponse
@synthesize _userInfo;

+ (UserInfo *)userInfo:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	UserInfo *info = [[[UserInfo alloc] init] autorelease];
	info._integral =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"integral"]];
	info._lcdCurrency =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"lcdCurrency"]];
	info._level =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"level"]];
	info._commentCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"commentCount"]];
	info._signInCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"signInCount"]];
	info._pictureCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"pictureCount"]];
	info._qACount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"qaCount"]];
    info._telephone = [NSString stringWithFormat:@"%@", [dic objectForKey:@"telephone"]];
	
    return info;
}

@end


@implementation UserInfo
@synthesize _integral,_lcdCurrency,_level,_commentCount,_signInCount,_pictureCount,_qACount,_telephone;

-(void)dealloc
{
	self._integral = nil;
	self._lcdCurrency = nil;
	self._level = nil;
	self._commentCount = nil;
	self._signInCount = nil;
	self._pictureCount = nil;
    self._qACount = nil;
    self._telephone = nil;
	
	[super dealloc];
}

@end
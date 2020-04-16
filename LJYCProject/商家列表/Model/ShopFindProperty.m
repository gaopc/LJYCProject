//
//  ShopFindProperty.m
//  SystemArchitecture
//
//  Created by z1 on 13-10-21.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopFindProperty.h"


@implementation Shops
@synthesize _id,_name,_picUrl,_type,_star,_isNotice,_isClaim,_distance,_telephone,_serviceTags,_district,_longitude,_latitude,_state;
@synthesize _isVouchers;
-(void)dealloc
{
	self._id = nil;
	self._name = nil;
	self._picUrl = nil;
	self._type = nil;
	self._star = nil;
	self._isNotice = nil;
	self._isClaim = nil;
    self._isVouchers = nil;
	self._distance = nil;
	self._telephone = nil;
	self._serviceTags = nil;
	self._district = nil;
	self._longitude = nil;
	self._latitude = nil;
	self._state = nil;

	[super dealloc];
}
+(Shops *)ShopsWithDic:(NSDictionary*)dicList
{
    Shops *shop = [[Shops alloc] init];
    shop._id = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"id"]] ;
    shop._name =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"name"]] ;
    shop._picUrl =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"picUrl"]] ;
    shop._type =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"type"]] ;
    shop._star =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"star"]] ;
    shop._isNotice =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"isNotice"]];
    shop._isClaim =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"isClaim"]];
    shop._isVouchers =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"isVouchers"]];
    shop._distance =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"distance"]] ;
    shop._telephone =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"telephone"]] ;
    shop._serviceTags =   [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"serviceTags"]] stringByReplacingOccurrencesOfString :@"&" withString:@"、"] ;
    shop._district =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"district"]] ;
    shop._longitude =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"longitude"]] ;
    shop._latitude =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"latitude"]] ;
    shop._state =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"state"]] ;
    return [shop autorelease];
}

+ (Shops *)activetyShopsWithDic:(NSDictionary *)dic
{
    Shops *shop = [[Shops alloc] init];
    shop._id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopId"]] ;
    shop._name =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]] ;
    shop._picUrl =   [NSString stringWithFormat:@"%@", [dic objectForKey:@"picUrl"]] ;
    shop._district =   [NSString stringWithFormat:@"%@", [dic objectForKey:@"address"]] ;
    return [shop autorelease];
}
@end


@implementation ShopFindProperty

@synthesize _type,_orderBy,_serviceTagId,_distance,_longitude,_latitude,_pageIndex,_keyword,_filter,_districtId,_cityId;
-(void)dealloc
{
	self._type = nil;
	self._orderBy = nil;
	self._serviceTagId = nil;
	self._distance = nil;
	self._longitude = nil;
	self._longitude = nil;
	self._latitude = nil;
	self._pageIndex = nil;
	self._keyword = nil;
	//self._telephone = nil;
	self._filter = nil;
	self._districtId = nil;
	self._cityId = nil;
	[super dealloc];
}

@end

//
//  ShopCollectDataResponse.m
//  LJYCProject
//
//  Created by z1 on 13-11-11.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopCollectDataResponse.h"

@implementation ShopCollectDataResponse
@synthesize totalPage,count,collects,citys;
-(void)dealloc
{
	self.totalPage = nil;
	self.count = nil;
	self.collects = nil;
	self.citys = nil;
	[super dealloc];
}

+ (ShopCollectDataResponse *)findCollect:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSArray *collectList = [dic valueForKey:@"shops"];
	NSArray *cityList = [dic valueForKey:@"citys"];
	ShopCollectDataResponse * shopCollectDR = [[[ShopCollectDataResponse  alloc] init] autorelease];
	
	shopCollectDR.totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]] ;
	shopCollectDR.count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]] ;
	
	NSMutableArray *list = [[NSMutableArray alloc] init];
	if ([collectList isKindOfClass:[NSArray class]]) {
		if (![collectList isEqual:@""])
		{
			for (NSDictionary *dicList in collectList) {
				ShopCollect *collect = [[ShopCollect alloc] init];
				collect._id = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"id"]] ;
				collect._name =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"name"]] ;
				collect._picUrl =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"picUrl"]] ;
				collect._district =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"district"]] ;
				collect._serviceTags =   [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"serviceTags"]] stringByReplacingOccurrencesOfString :@"&" withString:@"、"] ;
				collect._star =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"star"]];
				collect._time =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"time"]];
				collect._type =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"type"]];
				collect._isNotice =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"isNotice"]];
				collect._isClaim =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"isClaim"]];
				collect._telephone =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"telephone"]];
				collect._state =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"state"]];
				[list addObject: collect];
				[collect release];
			}
		}
	}
	shopCollectDR.collects=list;
	
	
	NSMutableArray *clist = [[NSMutableArray alloc] init];
	if ([cityList isKindOfClass:[NSArray class]]) {
		if (![cityList isEqual:@""])
		{
			for (NSDictionary *dicList in cityList) {
				City *city = [[City alloc] init];
				city._id = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"id"]] ;
				city._name =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"name"]] ;
				city._firstLetter = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"firstLetter"]] ;
				city._initial = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"initial"]] ;
				city._pinyin = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"pinyin"]] ;
				city._topFlag = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"topFlag"]] ;
				[clist addObject: city];
				[city release];
			}
		}
	}
	shopCollectDR.citys=clist;

	[clist release];
	if ([shopCollectDR.collects count] == 0) {
		shopCollectDR.collects = nil;
	}
	if ([shopCollectDR.citys count] == 0) {
		shopCollectDR.citys = nil;
	}
	return shopCollectDR;
}

//收藏添加成功提示
+ (NSString*)collectAddMessage:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSString * message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]];
	return message;
}
@end
@implementation ShopCollect
@synthesize _id,_name,_district,_serviceTags,_star,_time,_picUrl,_isNotice,_isClaim,_telephone,_type,_state;

-(void)dealloc
{
	self._id = nil;
	self._name = nil;
	self._district = nil;
	self._serviceTags = nil;
	self._star = nil;
	self._time = nil;
        self._picUrl = nil;
	self._isNotice = nil;
	self._isClaim = nil;
	self._telephone = nil;
	self._type = nil;
	self._state = nil;
	
	[super dealloc];
}
@end

@implementation CollectProperty
@synthesize _userId,_pageIndex,_order,_shopTypeId,_cityId;

-(void)dealloc
{
	self._userId = nil;
	self._pageIndex = nil;
	self._order = nil;
	self._shopTypeId = nil;
	self._cityId = nil;
	
	[super dealloc];
}




@end

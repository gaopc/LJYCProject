//
//  ShopFindDataResponse.m
//  SystemArchitecture
//
//  Created by z1 on 13-10-21.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopFindDataResponse.h"

@implementation ShopFindDataResponse
@synthesize totalPage,count,shops;
-(void)dealloc
{
	self.totalPage = nil;
	self.count = nil;
	self.shops = nil;
	

	[super dealloc];
}

+ (ShopFindDataResponse *)findShop:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSArray *shopList = [dic valueForKey:@"shops"];
	ShopFindDataResponse * shopFindDR = [[[ShopFindDataResponse  alloc] init] autorelease];
	
	shopFindDR.totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]] ;
	shopFindDR.count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]] ;
	
	NSMutableArray *list = [[NSMutableArray alloc] init];
	if ([shopList isKindOfClass:[NSArray class]]) {
		if (![shopList isEqual:@""])
		{
			for (NSDictionary *dicList in shopList) {
				[list addObject: [Shops ShopsWithDic:dicList]];
			}
		}
	}
	shopFindDR.shops=list;
	[list release];
	if ([shopFindDR.shops count] == 0) {
		shopFindDR.shops = nil;
	}
	
	return shopFindDR;
}
- (NSString *) stringByReplacing:(NSString *) str0{
	
	NSString *str = @"";
	return str = [str0 stringByReplacingOccurrencesOfString :@" " withString:@"&"];
}


@end

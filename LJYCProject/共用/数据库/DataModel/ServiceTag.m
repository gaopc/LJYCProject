//
//  ServiceTag.m
//  LJYCProject
//
//  Created by z1 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ServiceTag.h"

@implementation ServiceTag
@synthesize _tag_id,_tag_name,_tag_type,_tag_picUrl,_tag_defaultNum,_tag_index;
-(void)dealloc
{
	self._tag_id = nil;
	self._tag_name = nil;
	self._tag_type = nil;
    self._tag_picUrl = nil;
    self._tag_defaultNum = nil;
	self._tag_index = nil;
	[super dealloc];
}

+ (ServiceTag *)serviceNewTagFromElem:(NSArray *)array
{
	ServiceTag * tag = [[ServiceTag alloc] init];
	tag._tag_id = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
	tag._tag_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
	tag._tag_type = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
	return [tag autorelease];
}

+(ServiceTag *) serviceTagFromElem:(NSArray *)array
{
	ServiceTag * tag = [[ServiceTag alloc] init];
	tag._tag_id = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
	tag._tag_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
	tag._tag_type = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    tag._tag_picUrl = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    tag._tag_defaultNum = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
	return [tag autorelease];
}

+(ShopType *) shopTypeFromElem:(NSArray *)array
{
	ShopType * type = [[ShopType alloc] init];
	type._Type_id = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
	type._Type_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
	type._Type_picUrl = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    type._Type_defaultNum = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    
	return [type autorelease];
}


@end


@implementation ShopType
@synthesize _Type_id,_Type_name,_Type_picUrl,_Type_defaultNum,_Type_index;
-(void)dealloc
{
	self._Type_id = nil;
	self._Type_name = nil;
	self._Type_picUrl = nil;
    self._Type_defaultNum = nil;
	self._Type_index = nil;
	[super dealloc];
}
+(ShopType *) ShopTypeFromElem:(NSArray *)array
{
	ShopType * type = [[ShopType alloc] init];
	type._Type_id = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
	type._Type_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    type._Type_picUrl = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    type._Type_defaultNum = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
	
	return [type autorelease];
}
@end
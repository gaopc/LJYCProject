//
//  City.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "City.h"

@implementation City
@synthesize _id,_name,_firstLetter,_initial,_pinyin,_topFlag;

- (void)dealloc
{
    self._id = nil;
    self._name = nil;
    self._firstLetter = nil;
    self._initial = nil;
    self._pinyin = nil;
    self._topFlag = nil;
    
    [super dealloc];
    
}
+(City *) CityWithElem:(NSArray *)array
{
    City * temp = [[City alloc] init];
    temp._id = [array objectAtIndex:0];
    temp._name = [array objectAtIndex:1];
    temp._firstLetter = [array objectAtIndex:2];
    temp._initial = [array objectAtIndex:3];
    temp._pinyin = [array objectAtIndex:4];
    temp._topFlag = [array objectAtIndex:5];
    return [temp autorelease];
}
@end

@implementation District
@synthesize _id,_name,_cityId;

- (void)dealloc
{
    self._id = nil;
    self._name = nil;
    self._cityId = nil;
    
    [super dealloc];
    
}
+(District *) DistrictWithElem:(NSArray *)array
{
    District * temp = [[District alloc] init];
    temp._id = [array objectAtIndex:0];
    temp._name = [array objectAtIndex:1];
    temp._cityId = [array objectAtIndex:2];
    return [temp autorelease];
}
@end

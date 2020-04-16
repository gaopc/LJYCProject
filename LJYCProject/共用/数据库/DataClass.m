//
//  DataClass.m
//  FlightProject
//
//  Created by longcd on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataClass.h"
#import "BaseInfo.h"
#import "City.h"

@implementation DataClass
+(NSArray *) selectFromVersions
{
    NSArray *elem = [NSArray arrayWithObjects:@"table_name", @"version", nil];
    NSString * conditions =[NSString stringWithFormat:@" Versions "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Versions" WithConditions:conditions];
    return array;
}
+(void) insertIntoCityWithArray:(NSArray *)array
{
    [DataBaseClass deleteWithTable:@"City"];
    NSArray * elem = [NSArray arrayWithObjects:@"city_id", @"city_name",@"first_letter",@"hot_flag", @"jian_pin",@"e_name",nil];
    [DataBaseClass insertWithTable:@"City" WithElem:elem WithData:array];
}
+(void) insertIntoCountryWithArray:(NSArray *)array
{
    [DataBaseClass deleteWithTable:@"Country"];
    NSArray * elem = [NSArray arrayWithObjects:@"city_id", @"country_id",@"country_name",@"first_letter",@"hot_flag", @"jian_pin",@"e_letter",nil];
    [DataBaseClass insertWithTable:@"Country" WithElem:elem WithData:array];
}
+(void) insertIntoServiceTagWithArray:(NSArray *)array
{
    [DataBaseClass deleteWithTable:@"ServiceTag"];
    NSArray * elem = [NSArray arrayWithObjects:@"tag_id", @"tag_name",@"tag_type",@"tag_image",@"tag_flag",@"tag_index",nil];
    [DataBaseClass insertWithTable:@"ServiceTag" WithElem:elem WithData:array];
}
+(void) insertIntoShopTypeWithArray:(NSArray *)array
{
    [DataBaseClass deleteWithTable:@"ShopType"];
    NSArray * elem = [NSArray arrayWithObjects:@"Type_id", @"Type_name",@"Type_image",@"Type_flag",@"Type_index",nil];
    [DataBaseClass insertWithTable:@"ShopType" WithElem:elem WithData:array];
}

+(void) insertIntoSearch_HistoryWithArray:(NSArray *)array
{
    // 先删除重复的，再添加  保持10条记录
    
    NSString *where = [NSString stringWithFormat:@"  search_key = '%@' ",[[array objectAtIndex:0] objectAtIndex:0]];
    [DataBaseClass deleteWithTable:@" Search_History " WithARecord:where];
    
    NSArray *elem = [NSArray arrayWithObjects:@"search_key",nil];
    NSUInteger count = [[DataClass selectSearch_History] count];
    if(count < 10)
    {
        [DataBaseClass insertWithTable:@"Search_History" WithElem:elem WithData:array];
    }
    else
    {
        NSString *where = [NSString stringWithFormat:@"  id = (  select min(id) from Search_History ) "];
        
        if ([DataBaseClass deleteWithTable:@" Search_History " WithARecord:where])
        {
            [DataBaseClass insertWithTable:@"Search_History" WithElem:elem WithData:array];
        }
        
    }
    
}

+(void) addServiceToServiceTagWithArray:(NSArray *)array
{
    NSString *where = [NSString stringWithFormat:@"  search_key = '%@' ",[[array objectAtIndex:0] objectAtIndex:0]];
    [DataBaseClass deleteWithTable:@" Search_History " WithARecord:where];
    
    NSArray *elem = [NSArray arrayWithObjects:@"search_key",nil];
    [DataBaseClass insertWithTable:@"Search_History" WithElem:elem WithData:array];
}

+(NSArray *) selectFromCity_Country
{
    //SELECT City.city_id,City.city_name,Country.city_id,Country.country_id,Country.country_name FROM City,Country where City.city_id= Country.city_id order by City.city_id
    NSArray * elem = [NSArray arrayWithObjects:@"City.city_id", @"City.city_name",@"City.first_letter", @"City.jian_pin",@"City.e_name",@"City.hot_flag",@"Country.city_id",@"Country.country_id",@"Country.country_name",nil];
    NSString * conditions =[NSString stringWithFormat:@" City,Country where City.city_id= Country.city_id order by City.city_id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"City" WithConditions:conditions];
    return array;

}
+(NSArray *) selectFromCity
{
    NSArray * elem = [NSArray arrayWithObjects:@"city_id", @"city_name",@"first_letter", @"jian_pin",@"e_name",@"hot_flag",nil];
    NSString * conditions =[NSString stringWithFormat:@" City order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"City" WithConditions:conditions];
    
    NSMutableArray * mArray = [NSMutableArray array];
	for (NSArray * elem in array ) {
		[mArray addObject:[City CityWithElem:elem ]];
	}
	return mArray;
}

+(NSArray *) selectFromCountry
{
    NSArray * elem = [NSArray arrayWithObjects: @"country_id",@"country_name",@"city_id",@"first_letter",@"hot_flag", @"jian_pin",@"e_letter",nil];
    NSString * conditions =[NSString stringWithFormat:@" Country order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Country" WithConditions:conditions];

    NSMutableArray * mArray = [NSMutableArray array];
	for (NSArray * elem in array ) {
		[mArray addObject:[District DistrictWithElem:elem ]];
	}
	return mArray;
}

+(NSArray *) selectFromCountry:(NSString*)districtId
{
	
	NSArray * elem = [NSArray arrayWithObjects: @"country_id",@"country_name",@"city_id",@"first_letter",@"hot_flag", @"jian_pin",@"e_letter",nil];
	NSString * conditions =[NSString stringWithFormat:@" Country where country_id != '%@' ",districtId];
	conditions = [NSString stringWithFormat:@"%@ order by id desc",conditions];
	NSLog(@"conditions %@ ",conditions);
	NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Country" WithConditions:conditions];
	NSMutableArray * mArray = [NSMutableArray array];
	for (NSArray * elem in array ) {
		[mArray addObject:[District DistrictWithElem:elem ]];
	}
	return mArray;
}


+(NSArray *) selectServiceTag
{
	NSArray *elem = [NSArray arrayWithObjects:@"tag_id", @"tag_name",@"tag_type",@"tag_image",@"tag_flag",nil];
	NSString * conditions =[NSString stringWithFormat:@" ServiceTag order by id asc"];
	NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"ServiceTag" WithConditions:conditions];
	NSMutableArray * mArray = [NSMutableArray array];
	for (NSArray * elem in array ) {
		[mArray addObject:[ServiceTag serviceTagFromElem:elem ]];
	}
	return mArray;
}

+(NSArray *) selectShopType
{
	NSArray *elem = [NSArray arrayWithObjects:@"Type_id", @"Type_name",@"Type_image",@"Type_flag",nil];
	NSString * conditions =[NSString stringWithFormat:@" ShopType order by id asc"];
	NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"ShopType" WithConditions:conditions];
	NSMutableArray * mArray = [NSMutableArray array];
	for (NSArray * elem in array ) {
		[mArray addObject:[ServiceTag shopTypeFromElem:elem ]];
	}
	return mArray;
}

+(NSArray *) selectSearch_History
{
	NSArray *elem = [NSArray arrayWithObjects:@"search_key", nil];
	NSString * conditions =[NSString stringWithFormat:@" Search_History order by id desc"];
	NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Search_History" WithConditions:conditions];
	NSMutableArray * mArray = [NSMutableArray array];
	for (NSArray * elem in array ) {
		[mArray addObject:[elem objectAtIndex:0]];
	}
	return mArray;
}

+(void) selectServiceTag_BasicInfo ////@"tag_id", @"tag_name",@"tag_type",@"tag_image",@"tag_flag",@"tag_index"
{
	NSArray *elem = [NSArray arrayWithObjects:@"tag_id", @"tag_name",@"tag_type",@"tag_image",@"tag_flag",@"tag_index",nil];
	NSString * conditions =[NSString stringWithFormat:@" ServiceTag order by tag_index asc"];
	NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"ServiceTag" WithConditions:conditions];
	for (NSArray * elem in array ) {
		[BaseInfo ServiceTagFromArr:elem];
	}
}

+(void) selectShopType_BasicInfo //@"tag_id", @"tag_name",@"tag_image",@"tag_flag",@"Type_index"
{
	NSArray *elem = [NSArray arrayWithObjects:@"Type_id", @"Type_name",@"Type_image",@"Type_flag",@"Type_index",nil];
	NSString * conditions =[NSString stringWithFormat:@" ShopType order by Type_index asc"];
	NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"ShopType" WithConditions:conditions];
	for (NSArray * elem in array ) {
		[BaseInfo ShopTypeFromArr:elem];
	}
}


+(void)deleteSearch_History
{
    [DataBaseClass deleteWithTable:@"Search_History"];
}

//+(NSString * ) selectFromDistrictWithCityName:(NSString *)cityName
//{
//   NSArray * elem = [NSArray arrayWithObjects:@"city_id", @"country_id",@"country_name",@"first_letter",@"hot_flag", @"jian_pin",@"e_letter",nil];
//    NSString * conditions =[NSString stringWithFormat:@" Country   where city_name = '%@' ",cityName];
//    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Country" WithConditions:conditions];
//    NSMutableArray * mArray = [NSMutableArray array];
//    for (NSArray * elem in array ) {
//        [mArray addObject:[Citys cityFromElem:elem ]];
//    }
//    Citys * city = nil;
//    if ([mArray count] > 0) {
//        city = [mArray objectAtIndex:0];
//    }
//    return city._city_code;
//    
//}
@end
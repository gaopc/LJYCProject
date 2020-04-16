//
//  DataClass.h
//  FlightProject
//
//  Created by longcd on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// 所有用到的和数据库交互的具体方法，可以直接在这个类中写方法

#import <Foundation/Foundation.h>
#import "DataBaseClass.h"
@interface DataClass : NSObject
+(NSArray *) selectFromVersions;
+(void) insertIntoCityWithArray:(NSArray *)array;
+(void) insertIntoCountryWithArray:(NSArray *)array;
+(void) insertIntoServiceTagWithArray:(NSArray *)array;
+(void) insertIntoShopTypeWithArray:(NSArray *)array;
+(void) insertIntoSearch_HistoryWithArray:(NSArray *)array;

+(void) addServiceToServiceTagWithArray:(NSArray *)array;
//+(void) insertIntoSearch_HistoryWithArray:(NSArray *)array;
+(NSArray *) selectFromCity;
+(NSArray *) selectFromCountry;
+(NSArray *) selectServiceTag;
+(NSArray *) selectShopType;
+(NSArray *) selectSearch_History;
+(NSArray *) selectFromCity_Country;
+(NSArray *) selectFromCountry:(NSString*)districtId;
+(void)deleteSearch_History;

+(void) selectServiceTag_BasicInfo;
+(void) selectShopType_BasicInfo;
@end

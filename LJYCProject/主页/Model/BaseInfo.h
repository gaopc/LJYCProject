//
//  BaseInfo.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "ServiceTagData.h"
#import "ServiceTag.h"

@interface BaseInfo : NSObject
@property (nonatomic,retain) NSMutableArray * _Citys;
@property (nonatomic,retain) NSMutableArray * _Countrys;
@property (nonatomic,retain) NSDictionary * _CitysCountrys;
@property (nonatomic,retain) NSDictionary * _ServiceTags;


@property (nonatomic,retain) NSMutableDictionary * _ServiceAllTags;
@property (nonatomic,retain) NSMutableArray * _ServiceShowTags;
@property (nonatomic,retain) NSMutableArray * _ServiceShowTags_login;

@property (nonatomic,retain) NSMutableArray * _ShopTypes;
+(BaseInfo *)shareBaseInfo;

+(void) ShopTypeFromArr:(NSArray *)array; //code, name,picUrl,flag
+(void)ServiceTagFromArr:(NSArray*)arr; //[NSArray arrayWithObjects:code,name,type,picUrl,defaultNum,nil]
+(void)CountryFromArr:(NSArray*)arr; 
@end

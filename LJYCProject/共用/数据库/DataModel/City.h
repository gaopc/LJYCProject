//
//  City.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property(nonatomic,retain)NSString *_id;//id
@property(nonatomic,retain)NSString *_name;//名称
@property(nonatomic,retain)NSString *_firstLetter;//拼音首字母
@property(nonatomic,retain)NSString *_pinyin;//全拼
@property(nonatomic,retain)NSString *_initial;//简拼
@property(nonatomic,retain)NSString *_topFlag;//热门标识
+(City *) CityWithElem:(NSArray *)array;
@end


@interface District : NSObject
@property(nonatomic,retain)NSString *_id;//id
@property(nonatomic,retain)NSString *_name;//名称
@property(nonatomic,retain)NSString *_cityId;//拼音首字母
+(District *) DistrictWithElem:(NSArray *)array;
@end

//
//  ShopCollectDataResponse.h
//  LJYCProject
//
//  Created by z1 on 13-11-11.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCollectDataResponse : NSObject
@property (nonatomic,retain) NSString *totalPage;
@property (nonatomic,retain) NSString *count;
@property (nonatomic,retain) NSMutableArray *collects;
@property (nonatomic,retain) NSMutableArray *citys;
+ (ShopCollectDataResponse *)findCollect:(NSDictionary *)dic;
+ (NSString*)collectAddMessage:(NSDictionary *)dic;
@end


@interface ShopCollect : NSObject

@property (nonatomic,retain)NSString * _id; //
@property (nonatomic,retain)NSString * _name; //
@property (nonatomic,retain)NSString * _district; //
@property (nonatomic,retain)NSString * _type; //
@property (nonatomic,retain)NSString * _serviceTags; //
@property (nonatomic,retain)NSString * _star; //
@property (nonatomic,retain)NSString * _picUrl; //
@property (nonatomic,retain)NSString * _isNotice; //
@property (nonatomic,retain)NSString * _isClaim; //
@property (nonatomic,retain)NSString * _telephone; //
@property (nonatomic,retain)NSString * _time; //
@property (nonatomic,retain)NSString * _state; //  店铺状态 0 正常 1 停业 2 休业
@end

@interface CollectProperty : NSObject

@property (nonatomic,retain) NSString * _userId;
@property (nonatomic,retain) NSString * _pageIndex;
@property (nonatomic,retain) NSString * _order;
@property (nonatomic,retain) NSString * _shopTypeId;
@property (nonatomic,retain) NSString * _cityId;

@end
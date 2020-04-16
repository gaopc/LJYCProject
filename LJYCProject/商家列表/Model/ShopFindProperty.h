//
//  ShopFindProperty.h
//  SystemArchitecture
//
//  Created by z1 on 13-10-21.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Shops : NSObject

@property (nonatomic,retain) NSString * _id;
@property (nonatomic,retain) NSString * _name;
@property (nonatomic,retain) NSString * _picUrl;
@property (nonatomic,retain) NSString * _type;
@property (nonatomic,retain) NSString * _star;
@property (nonatomic,retain) NSString * _isNotice;
@property (nonatomic,retain) NSString * _isClaim;
@property (nonatomic,retain) NSString * _isVouchers;

@property (nonatomic,retain) NSString * _distance;
@property (nonatomic,retain) NSString * _telephone;
@property (nonatomic,retain) NSString * _serviceTags;
@property (nonatomic,retain) NSString * _district;
@property (nonatomic,retain) NSString * _longitude;
@property (nonatomic,retain) NSString * _latitude;
@property (nonatomic,retain)NSString * _state; //  店铺状态 0 正常 1 停业 2 休业

+(Shops *)ShopsWithDic:(NSDictionary*)dic;
+ (Shops *)activetyShopsWithDic:(NSDictionary *)dic;

@end

@interface ShopFindProperty : NSObject

@property (nonatomic,retain) NSString * _type; // 店铺类别
@property (nonatomic,retain) NSString * _orderBy; // int 排序
@property (nonatomic,retain) NSString * _serviceTagId; // String 服务标签id
@property (nonatomic,retain) NSString * _distance;  // int 距离
@property (nonatomic,retain) NSString * _longitude; // 经度
@property (nonatomic,retain) NSString * _latitude;  // 纬度
@property (nonatomic,retain) NSString * _pageIndex;  // int 第几页
@property (nonatomic,retain) NSString * _keyword;  // 搜索关键字
//@property (nonatomic,retain) NSString * _telephone;
@property (nonatomic,retain) NSString * _filter; // 过滤条件 0：全部  1：已认领  2：未认领
@property (nonatomic,retain) NSString * _districtId;  // 区县id
@property (nonatomic,retain) NSString * _cityId;  // 城市id
@end

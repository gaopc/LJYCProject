//
//  ShopForDataInfo.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-8.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopForDataInfo : NSObject
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, retain) NSString *_name;
@property (nonatomic, retain) NSString *_type;
@property (nonatomic, retain) NSString *_star;
@property (nonatomic, retain) NSString *_district;
@property (nonatomic, retain) NSString *_address;
@property (nonatomic, retain) NSString *_longitude;
@property (nonatomic, retain) NSString *_latitude;
@property (nonatomic, retain) NSString *_scale;
@property (nonatomic, retain) NSString *_cycle;
@property (nonatomic, retain) NSString *_cycleStart;
@property (nonatomic, retain) NSString *_cycleEnd;
@property (nonatomic, retain) NSString *_introduce;
@property (nonatomic, retain) NSString *_notice;
@property (nonatomic, retain) NSString *_telephone;
@property (nonatomic, retain) NSString *_collectCount;
@property (nonatomic, retain) NSString *_signInCount;
@property (nonatomic, retain) NSString *_state;
@property (nonatomic, retain) NSString *_distance;
@property (nonatomic, retain) NSString *_picUrl;

@property (nonatomic, retain) NSString *_serviceId;
@property (nonatomic, retain) NSString *_serviceName;
@property (nonatomic, retain) NSString *_serviceType;
@property (nonatomic, retain) NSString *_allService;

@property (nonatomic, retain) NSString *_isCollect;
@property (nonatomic, retain) NSString *_isClaim;

@property (nonatomic, retain) NSArray *_picUrlArr;
@property (nonatomic, retain) NSArray *_serviceArr;
@property (nonatomic, retain) NSMutableArray *_groupPurs;
@property (nonatomic, retain) NSMutableArray *_groupVouchers;

+ (ShopForDataInfo *)setShopForDataInfo:(NSDictionary *)dic;
@end



@interface ShopForTuanInfo : NSObject
@property (nonatomic, retain) NSString *_tuanId;
@property (nonatomic, retain) NSString *_tuanName;
@property (nonatomic, retain) NSString *_tuanPrice;

+ (ShopForTuanInfo *)set_tuanData:(NSDictionary *)dic;
@end

@interface VoucherInfo : NSObject
@property (nonatomic, retain) NSString *_Id;
@property (nonatomic, retain) NSString *_note;
@property (nonatomic, retain) NSString *_thePrice;
@property (nonatomic, retain) NSString *_price;

@property (nonatomic, retain) NSString *_code;
@property (nonatomic, retain) NSString *_codeUrl;
@property (nonatomic, retain) NSString *_state;
@property (nonatomic, retain) NSString *_time;

+ (VoucherInfo *)set_voucherData:(NSDictionary *)dic;
@end



@interface ShopForReturn : NSObject
@property (nonatomic, retain) NSString *_orderId;
@property (nonatomic, retain) NSString *_balanceMoney;
@property (nonatomic, retain) NSString *_orderTitle;
@property (nonatomic, retain) NSString *_totalPrice;
@property (nonatomic, retain) NSString *_payPrice;

+ (ShopForReturn *)set_returnData:(NSDictionary *)dic;
@end




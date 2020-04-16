//
//  FindOrders.h
//  LJYCProject
//
//  Created by xiemengyue on 14-3-14.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindOrders : NSObject
@property (nonatomic, retain) NSString *_totalPage;
@property (nonatomic, retain) NSString *_count;
@property (nonatomic, retain) NSMutableArray *_ordersArr;

+(FindOrders*)getFindOrders:(NSDictionary*)dic;
@end

@interface Orders : NSObject
@property (nonatomic, retain) NSString *_orderId;
@property (nonatomic, retain) NSString *_shopId;

@property (nonatomic, retain) NSString *_vouchersid;
@property (nonatomic, retain) NSString *_shopName;
@property (nonatomic, retain) NSString *_thePrice;

@property (nonatomic, retain) NSString *_groupPurId;
@property (nonatomic, retain) NSString *_groupPurName;
@property (nonatomic, retain) NSString *_totalPrice;
@property (nonatomic, retain) NSString *_time;
@property (nonatomic, retain) NSString *_state;
@property (nonatomic, retain) NSString *_picUrl;
@property (nonatomic, retain) NSString *_count;
@property (nonatomic, retain) NSString *_telePhone;

@property (nonatomic, retain) NSString *_status;
@end

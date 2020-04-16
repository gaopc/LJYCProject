//
//  OrderDetailsData.h
//  LJYCProject
//
//  Created by xiemengyue on 14-3-14.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailsData : NSObject
@property(nonatomic,retain)NSString *_orderCode;
@property(nonatomic,retain)NSString *_shopId;
@property(nonatomic,retain)NSString *_totalPrice;
@property(nonatomic,retain)NSString *_count;
@property(nonatomic,retain)NSString *_state;
@property(nonatomic,retain)NSString *_time;
@property(nonatomic,retain)NSString *_groupPurId;
@property(nonatomic,retain)NSString *_groupPurName;
@property(nonatomic,retain)NSString *_payTime;
@property(nonatomic,retain)NSMutableArray *_groupPursArry;

+(OrderDetailsData*)getOrderDetailsData:(NSDictionary*)dic;
@end


@interface GroupPurs : NSObject
@property(nonatomic,retain)NSString *_id;
@property(nonatomic,retain)NSString *_name;
@property(nonatomic,retain)NSString *_code;
@property(nonatomic,retain)NSString *_state;
@property(nonatomic,retain)NSString *_time;
@end
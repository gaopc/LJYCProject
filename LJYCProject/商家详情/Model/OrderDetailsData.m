//
//  OrderDetailsData.m
//  LJYCProject
//
//  Created by xiemengyue on 14-3-14.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "OrderDetailsData.h"

@implementation OrderDetailsData
@synthesize _orderCode,_shopId,_totalPrice,_count,_state,_time,_payTime,_groupPursArry,_groupPurId,_groupPurName;

- (void)dealloc
{
    self._orderCode = nil;
    self._shopId = nil;
    self._totalPrice = nil;
    self._count = nil;
    self._state = nil;
    self._time = nil;
    self._payTime = nil;
    self._groupPursArry = nil;
	self._groupPurName = nil;
	self._groupPurId = nil;
    [super dealloc];
}
+(NSString *)getTimeFormString:(NSString*)str
{
    long long dataLong = [str longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:date];
}

+(OrderDetailsData*)getOrderDetailsData:(NSDictionary*)dic
{
    OrderDetailsData *orderDetailsData = [[[OrderDetailsData alloc] init] autorelease];
    if (![dic isKindOfClass:[NSDictionary class]]) {
//        return nil;
        dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"147559935",@"0",@"500",@"3",@"已支付",@"1378828800000",@"1378828800000", [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3541332",@"火锅",@"0540880246",@"1",@"1378828800000", nil]forKeys:[NSArray arrayWithObjects:@"id",@"name",@"code",@"state",@"time",nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3541332",@"火锅",@"0540880246",@"0",@"1378828800000", nil]forKeys:[NSArray arrayWithObjects:@"id",@"name",@"code",@"state",@"time",nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3541372",@"烤鱼",@"0540880247",@"2",@"1378828800000", nil]forKeys:[NSArray arrayWithObjects:@"id",@"name",@"code",@"state",@"time",nil]], nil],nil] forKeys:[NSArray arrayWithObjects:@"orderCode",@"shopId",@"totalPrice",@"count",@"state",@"time",@"payTime",@"groupPurs", nil]];
    }
    orderDetailsData._orderCode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderCode"]];
    orderDetailsData._shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"shopId"]];
    orderDetailsData._totalPrice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPrice"]];
    orderDetailsData._count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
    orderDetailsData._state = [NSString stringWithFormat:@"%@",[dic objectForKey:@"state"]];
    orderDetailsData._time = [self getTimeFormString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]] ];
    orderDetailsData._payTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"payTime"]];
    orderDetailsData._groupPurId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"groupPurId"]];
    orderDetailsData._groupPurName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"groupPurName "]];
    NSArray * array = [dic objectForKey:@"groupPurs"];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        GroupPurs *groupPurs = [[GroupPurs alloc] init];
        groupPurs._id = [NSString stringWithFormat:@"%@",[elem objectForKey:@"id"]];
        groupPurs._name = [NSString stringWithFormat:@"%@",[elem objectForKey:@"name"]];
        groupPurs._code = [NSString stringWithFormat:@"%@",[elem objectForKey:@"code"]];
        groupPurs._state = [NSString stringWithFormat:@"%@",[elem objectForKey:@"state"]];
        groupPurs._time = [self getTimeFormString:[NSString stringWithFormat:@"%@",[elem objectForKey:@"time"]] ];
       
        [marray addObject:groupPurs];
        [groupPurs release];
        }
    orderDetailsData._groupPursArry = marray;
    
    return orderDetailsData;
}
@end


@implementation GroupPurs
@synthesize _id,_name,_code,_state,_time;

- (void)dealloc
{
    self._id = nil;
    self._name = nil;
    self._code = nil;
    self._state = nil;
    self._time = nil;
    
    [super dealloc];
}
@end
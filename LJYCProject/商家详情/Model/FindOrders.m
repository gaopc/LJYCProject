//
//  FindOrders.m
//  LJYCProject
//
//  Created by xiemengyue on 14-3-14.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "FindOrders.h"

@implementation FindOrders
@synthesize _totalPage,_count,_ordersArr;

- (void)dealloc
{
    self._totalPage = nil;
    self._count = nil;
    self._ordersArr = nil;
    
    [super dealloc];
}

+(NSString *)getTimeFormString:(NSString*)str
{
    long long dataLong = [str longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

+(FindOrders*)getFindOrders:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
//        return nil;
        
        dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"5",[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"100001",@"0",@"老赵家农家乐",@"500",@"1378828800000",@"0",@"http://image.lajiaou.com:8100/image/dc3bd14e6fbd0ac29ffc517a0d798749.jpg", nil] forKeys:[NSArray arrayWithObjects:@"orderId",@"shopId",@"groupPurName",@"totalPrice",@"time",@"state",@"picUrl",nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"120001",@"0",@"游乐园",@"200",@"1378828800000",@"1",@"http://image.lajiaou.com:8100/image/dc3bd14e6fbd0ac29ffc517a0d798749.jpg", nil] forKeys:[NSArray arrayWithObjects:@"orderId",@"shopId",@"groupPurName",@"totalPrice",@"time",@"state",@"picUrl",nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"100301",@"0",@"野生基地",@"1500",@"1398828800000",@"2",@"http://image.lajiaou.com:8100/image/dc3bd14e6fbd0ac29ffc517a0d798749.jpg", nil] forKeys:[NSArray arrayWithObjects:@"orderId",@"shopId",@"groupPurName",@"totalPrice",@"time",@"state",@"picUrl",nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"10023",@"3",@"云梦山",@"60",@"1478828800000",@"3",@"http://image.lajiaou.com:8100/image/dc3bd14e6fbd0ac29ffc517a0d798749.jpg", nil] forKeys:[NSArray arrayWithObjects:@"orderId",@"shopId",@"groupPurName",@"totalPrice",@"time",@"state",@"picUrl",nil]], nil], nil] forKeys:[NSArray arrayWithObjects:@"totalPage",@"count",@"orders", nil]];
    }
    FindOrders *findOrders = [[[FindOrders alloc] init] autorelease];
    findOrders._totalPage = [NSString  stringWithFormat:@"%@",[dic objectForKey:@"totalPage"]];
    findOrders._count = [NSString  stringWithFormat:@"%@",[dic objectForKey:@"count"]];
    NSArray * array = [dic objectForKey:@"orders"];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        Orders *orders = [[Orders alloc] init];
        orders._orderId = [NSString stringWithFormat:@"%@",[elem objectForKey:@"orderId"]];
        orders._shopId = [NSString stringWithFormat:@"%@",[elem objectForKey:@"shopId"]];
        
        orders._vouchersid = [NSString stringWithFormat:@"%@",[elem objectForKey:@"vouchersid"]];
        orders._shopName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"shopName"]];
        orders._thePrice = [NSString stringWithFormat:@"%@",[elem objectForKey:@"theprice"]];

        orders._groupPurName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"groupPurName"]];
        orders._totalPrice = [NSString stringWithFormat:@"%@",[elem objectForKey:@"totalPrice"]];
        orders._time = [self getTimeFormString:[NSString stringWithFormat:@"%@",[elem objectForKey:@"time"]] ];
        orders._state = [NSString stringWithFormat:@"%@",[elem objectForKey:@"state"]];
        orders._picUrl = [NSString stringWithFormat:@"%@",[elem objectForKey:@"picUrl"]];
        orders._count = [NSString stringWithFormat:@"x%@",[elem objectForKey:@"count"]];
        orders._groupPurId = [NSString stringWithFormat:@"%@",[elem objectForKey:@"vouchersId"]];
        orders._telePhone = [NSString stringWithFormat:@"%@", [elem objectForKey:@"telephone"]];
        orders._status = [NSString stringWithFormat:@"%@", [elem objectForKey:@"status"]];
        [marray addObject:orders];
        [orders release];
    }
    findOrders._ordersArr = marray;
    return  findOrders;
}



@end


@implementation Orders
@synthesize _orderId,_shopId,_groupPurName,_totalPrice,_time,_state,_picUrl,_groupPurId,_count;
@synthesize _telePhone;
@synthesize _thePrice,_shopName,_vouchersid;
@synthesize _status;

- (void)dealloc
{
    self._status = nil;
    self._orderId = nil;
    self._shopId = nil;
    self._groupPurName = nil;
    self._totalPrice = nil;
    self._time = nil;
    self._state = nil;
    self._picUrl = nil;
    self._groupPurId = nil;
    self._count = nil;
    self._telePhone = nil;
    
    self._thePrice = nil;
    self._shopName = nil;
    self._vouchersid = nil;
    [super dealloc];
}
@end
//
//  ShopForDataInfo.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-8.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForDataInfo.h"

@implementation ShopForDataInfo
@synthesize _address, _collectCount, _cycle, _district, _introduce, _isCollect, _latitude, _longitude, _name, _notice, _scale, _serviceId, _serviceName, _serviceType, _shopId, _signInCount, _star, _telephone, _type, _isClaim, _allService, _state, _distance, _picUrl;
@synthesize _picUrlArr, _serviceArr;
@synthesize _cycleEnd, _cycleStart,_groupPurs;
@synthesize _groupVouchers;
- (void)dealloc
{
    self._groupPurs = nil;
    self._address = nil,
    self._collectCount = nil,
    self._cycle = nil,
    self._district = nil,
    self._introduce = nil,
    self._isCollect = nil,
    self._latitude = nil,
    self._longitude = nil,
    self._name = nil,
    self._notice = nil,
    self._scale = nil,
    self._serviceId = nil,
    self._serviceName = nil,
    self._serviceType = nil,
    self._shopId = nil,
    self._signInCount = nil,
    self._star = nil,
    self._telephone = nil,
    self._type = nil;
    self._state = nil;
    self._isClaim = nil;
    self._serviceArr = nil;
    self._picUrlArr = nil;
    self._allService = nil;
    self._distance = nil;
    self._picUrl = nil;
    self._cycleStart = nil;
    self._cycleEnd = nil;
    
    self._groupVouchers = nil;
    [super dealloc];
}

+ (ShopForDataInfo *)setShopForDataInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    ShopForDataInfo *dataInfo = [[ShopForDataInfo alloc] init];
    dataInfo._shopId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopId"]];
    dataInfo._name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    dataInfo._type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"type"]];
    dataInfo._star = [NSString stringWithFormat:@"%@", [dic objectForKey:@"star"]];
    dataInfo._district = [NSString stringWithFormat:@"%@", [dic objectForKey:@"district"]];
    dataInfo._address = [NSString stringWithFormat:@"%@", [dic objectForKey:@"address"]];
    dataInfo._longitude = [NSString stringWithFormat:@"%@", [dic objectForKey:@"longitude"]];
    dataInfo._latitude = [NSString stringWithFormat:@"%@", [dic objectForKey:@"latitude"]];
    dataInfo._scale = [NSString stringWithFormat:@"%@", [dic objectForKey:@"scale"]];
    dataInfo._cycle = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cycle"]];
    dataInfo._introduce = [NSString stringWithFormat:@"%@", [dic objectForKey:@"introduce"]];
    dataInfo._notice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"notice"]];
    dataInfo._telephone = [NSString stringWithFormat:@"%@", [dic objectForKey:@"telephone"]];
    dataInfo._collectCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"collectCount"]];
    dataInfo._signInCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"signInCount"]];
    dataInfo._isCollect = [NSString stringWithFormat:@"%@", [dic objectForKey:@"isCollect"]];
    dataInfo._isClaim = [NSString stringWithFormat:@"%@", [dic objectForKey:@"isClaim"]];
    dataInfo._state = [NSString stringWithFormat:@"%@", [dic objectForKey:@"state"]];
    dataInfo._distance = [NSString stringWithFormat:@"%@", [dic objectForKey:@"distance"]];
    dataInfo._picUrl = [NSString stringWithFormat:@"%@", [dic objectForKey:@"picUrl"]];
    dataInfo._cycleStart = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cycleStart"]];
    dataInfo._cycleEnd = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cycleEnd"]];
    
    dataInfo._serviceArr = [dic objectForKey:@"serviceTag"];
    dataInfo._picUrlArr = [dic objectForKey:@"picUrls"];
    dataInfo._groupPurs = [self set_ShopForTuan:dic];
    dataInfo._groupVouchers = [self set_ShopForVouchers:dic];

    dataInfo._allService = @"";
    
    for (int i = 0; i < [dataInfo._serviceArr count]; i ++) {
        
        if (i == 0) {
            
            dataInfo._allService = [NSString stringWithFormat:@"%@", [[dataInfo._serviceArr objectAtIndex:i] objectForKey:@"name"]];
        }
        else {
         
            dataInfo._allService = [dataInfo._allService stringByAppendingFormat:@"、%@", [[dataInfo._serviceArr objectAtIndex:i] objectForKey:@"name"]];
        }
    }
    
    return [dataInfo autorelease];
}
+ (NSMutableArray *)set_ShopForVouchers:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"groupVouchers"];
    if ((![array isKindOfClass:[NSArray class]])  || ([array isKindOfClass:[NSArray class]] && [array count]==0)) {
                return nil;
        //         假数据
        array = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], nil];
        
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[VoucherInfo set_voucherData:elem]];
    }
    return marray;
}

+ (NSMutableArray *)set_ShopForTuan:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"groupPurs"];
    if ((![array isKindOfClass:[NSArray class]])  || ([array isKindOfClass:[NSArray class]] && [array count]==0)) {
//        return nil;
//         假数据
                array = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"火锅", @"80", nil] forKeys:[NSArray arrayWithObjects:@"id",@"name",@"price",nil]], nil];
        
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[ShopForTuanInfo set_tuanData:elem]];
    }
    return marray;
}

@end

@implementation VoucherInfo
@synthesize _Id, _note, _thePrice,_price;
@synthesize _code,_codeUrl,_state,_time;
- (void)dealloc
{
    self._Id = nil;
    self._note = nil;
    self._thePrice = nil;
    self._price = nil;

    self._code = nil;
    self._codeUrl = nil;
    self._state = nil;
    self._time = nil;
    [super dealloc];
}

+ (VoucherInfo *)set_voucherData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    VoucherInfo *tuanInfo = [[VoucherInfo alloc] init];
    tuanInfo._Id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    tuanInfo._note = [NSString stringWithFormat:@"%@", [dic objectForKey:@"note"]];
    tuanInfo._thePrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"thePrice"]];
    tuanInfo._price = [NSString stringWithFormat:@"%@", [dic objectForKey:@"price"]];
    tuanInfo._code = [NSString stringWithFormat:@"%@", [dic objectForKey:@"code"]];
    tuanInfo._codeUrl = [NSString stringWithFormat:@"%@", [dic objectForKey:@"codeUrl"]];
    tuanInfo._state = [NSString stringWithFormat:@"%@", [dic objectForKey:@"state"]];
    tuanInfo._time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"time"]];

    return [tuanInfo autorelease];
}
@end



@implementation ShopForTuanInfo
@synthesize _tuanId, _tuanName, _tuanPrice;

- (void)dealloc
{
    self._tuanPrice = nil;
    self._tuanName = nil;
    self._tuanId = nil;
    [super dealloc];
}

+ (ShopForTuanInfo *)set_tuanData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    ShopForTuanInfo *tuanInfo = [[ShopForTuanInfo alloc] init];
    tuanInfo._tuanId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    tuanInfo._tuanName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    tuanInfo._tuanPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"price"]];
    
    return [tuanInfo autorelease];
}
@end


@implementation ShopForReturn
@synthesize _balanceMoney, _orderId, _orderTitle, _totalPrice, _payPrice;

- (void)dealloc
{
    self._payPrice = nil;
    self._totalPrice = nil;
    self._orderTitle = nil;
    self._orderId = nil;
    self._balanceMoney = nil;
    [super dealloc];
}

+ (ShopForReturn *)set_returnData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        ShopForReturn *returnInfo = [[ShopForReturn alloc] init];
        returnInfo._orderId = [NSString stringWithFormat:@"%@", @"354132"];
        returnInfo._balanceMoney = [NSString stringWithFormat:@"%@", @"546.32"];
        return [returnInfo autorelease];
    }
    
    ShopForReturn *returnInfo = [[ShopForReturn alloc] init];
    returnInfo._orderId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"orderId"]];
    returnInfo._balanceMoney = [NSString stringWithFormat:@"%@", [dic objectForKey:@"balanceMoney"]];
    
    
    
    return [returnInfo autorelease];
}
@end


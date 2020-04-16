//
//  GroupPurDetailData.m
//  LJYCProject
//
//  Created by z1 on 14-3-14.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "GroupPurDetailData.h"
#import "ShopForDataInfo.h"
@implementation GroupPurDetailData
@synthesize _name, _oldPrice,_price,_sellCount,_content,_introduce,_detailInfo,_isAnyTimeRefund,_isExpiryRefund,_maxCount,_time,_state,_detailUrl,_picUrls,_orderId,_didSellCount;
@synthesize _telephone;
@synthesize _id;
@synthesize _shopName,_note,_count,_endDate,_noTime,_orderCode,_payTime,_shopAddress,_shopId,_startDate,_thePice,_totalPrice,_vouchersId,_groupVouchers;
@synthesize _packets;
- (void)dealloc
{
    self._id = nil;
	self._name = nil;
	self._oldPrice = nil;
	self._price = nil;
	self._sellCount = nil;
	self._content = nil;
	self._introduce = nil;
	self._detailInfo = nil;
	self._isAnyTimeRefund = nil;
	self._isExpiryRefund = nil;
	self._maxCount = nil;
	self._time = nil;
	self._state = nil;
	self._detailUrl = nil;
	self._picUrls = nil;
    self._didSellCount = nil;
    self._orderId = nil;
    self._telephone = nil;
    
    self._shopName = nil;
    self._note = nil;
    self._count = nil;
    self._endDate = nil;
    self._noTime = nil;
    self._orderCode = nil;
    self._payTime = nil;
    self._shopAddress = nil;
    self._shopId = nil;
    self._startDate = nil;
    self._thePice = nil;
    self._totalPrice = nil;
    self._vouchersId = nil;
    self._groupVouchers = nil;
    
    self._packets = nil;
    [super dealloc];
}

+ (GroupPurDetailData *)vouchersDetailDataInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GroupPurDetailData *dataInfo = [[GroupPurDetailData alloc] init];
    
    dataInfo._note = [NSString stringWithFormat:@"%@", [dic objectForKey:@"note"]];
    dataInfo._endDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"endDate"]];
    dataInfo._noTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"noTime"]];
    dataInfo._startDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"startDate"]];
    dataInfo._thePice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"thePrice"]];
    dataInfo._price = [NSString stringWithFormat:@"%@", [dic objectForKey:@"price"]];
    dataInfo._vouchersId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    dataInfo._sellCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"sellcount"]];
    
    return [dataInfo autorelease];
}

+ (GroupPurDetailData *) groupPurDetailDataInfo:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
//		return nil;
        //假数据
       
//        [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0",@"", @"太熟悉家常菜", @"1000.00", @"888.00", @"3000.00", @"仅售41元，价值50元代金券1张！穿峨眉才做主打，新派菜肴因佳话！情意浓厚到家尝，香飘四溢热分享！", @"有效期：2013-04-27 至 2014-03-31\n右安门店有效期从2014年2月15日开始\n仅限北京：交大东路店、惠新店、通州店、新源里店、方庄店；廊坊：燕郊店使用\n可使用大厅及包间，包间必须提前1天预约\n3桌及3桌以上包桌和宴会不可使用此券，不可分桌结账\n方庄店早餐10：00之前不可使用\n到店仅限堂食，不提供餐前打包；餐后未吃完，可打包（打包费以店内实际为准）\n本次团购不提供外送服务\n包间必须提前1天预约\n除外日期：12月24日、2014年1月1日-3日、1月30日-2月6日、2月14日", @" - 代金券（1张，仅售41元，价值50元）\n - 代金券（1张，仅售41元，价值50元）", @"false", @"true", @"5", @"3天以上", @"0" ,@"http://m.tmall.com/",  [NSArray arrayWithObjects:@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",nil] ,nil] forKeys:[NSArray arrayWithObjects:@"statusCode",@"message",@"name",@"oldPrice",@"price",@"sellCount",@"content",@"introduce",@"detailInfo",@"isAnyTimeRefund",@"isExpiryRefund",@"maxCount",@"time",@"state",@"detailUrl",@"picUrls",nil]];
        
         dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0",@"", @"20元代金券", @"1000.00", @"0.1", @"已售出：3000", @"满100元可用一张", @"有效期：2013-04-27 至 2014-03-31\n右安门店有效期从2014年2月15日开始\n仅限北京：交大东路店、惠新店、通州店、新源里店、方庄店；廊坊：燕郊店使用\n可使用大厅及包间，包间必须提前1天预约\n3桌及3桌以上包桌和宴会不可使用此券，不可分桌结账\n方庄店早餐10：00之前不可使用\n到店仅限堂食，不提供餐前打包；餐后未吃完，可打包（打包费以店内实际为准）\n本次团购不提供外送服务\n包间必须提前1天预约\n除外日期：12月24日、2014年1月1日-3日、1月30日-2月6日、2月14日", @" - 代金券（1张，仅售41元，价值50元）\n - 代金券（1张，仅售41元，价值50元）", @"false", @"true", @"5", @"3天以上", @"0" ,@"http://m.tmall.com/",  [NSArray arrayWithObjects:@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",@"http://image.lajiaou.com:8100/image/upload/3/27e989be5efe4e0398310e76cd60704e.jpg",nil] ,nil] forKeys:[NSArray arrayWithObjects:@"statusCode",@"message",@"name",@"oldPrice",@"price",@"sellCount",@"content",@"introduce",@"detailInfo",@"isAnyTimeRefund",@"isExpiryRefund",@"maxCount",@"time",@"state",@"detailUrl",@"picUrls",nil]];
	}
    GroupPurDetailData *dataInfo = [[GroupPurDetailData alloc] init];
    
    dataInfo._shopName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopName"]];
    dataInfo._note = [NSString stringWithFormat:@"%@", [dic objectForKey:@"note"]];
    dataInfo._count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]];
    dataInfo._endDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"endDate"]];
    dataInfo._noTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"noTime"]];
    dataInfo._orderCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"orderCode"]];
    dataInfo._payTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"payTime"]];
    dataInfo._shopAddress = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopAddress"]];
    dataInfo._shopId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopId"]];
    dataInfo._startDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"startDate"]];
    dataInfo._thePice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"theprice"]];
    dataInfo._totalPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPrice"]];
    dataInfo._vouchersId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"voucherId"]];
    
    
    NSArray * array = [dic objectForKey:@"groupVouchers"];
    if ((![array isKindOfClass:[NSArray class]])  || ([array isKindOfClass:[NSArray class]] && [array count]==0)) {
    }
    else
    {
        NSMutableArray *marray = [NSMutableArray array];
        for (NSDictionary * elem in array) {
            [marray addObject:[VoucherInfo set_voucherData:elem]];
        }
        dataInfo._groupVouchers = marray;
    }
    
    
    dataInfo._name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    dataInfo._oldPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"thePrice"]];
    dataInfo._price = [NSString stringWithFormat:@"%@", [dic objectForKey:@"price"]];
    dataInfo._sellCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"sellcount"]];
    dataInfo._content = [NSString stringWithFormat:@"%@", [dic objectForKey:@"note"]];
    dataInfo._introduce = [NSString stringWithFormat:@"有效期：%@-%@，%@不可用", [dic objectForKey:@"startDate"],[dic objectForKey:@"endDate"],[dic objectForKey:@"noTime"]];//[NSString stringWithFormat:@"%@", [dic objectForKey:@"introduce"]];
    dataInfo._detailInfo = [NSString stringWithFormat:@"%@", [dic objectForKey:@"detailInfo"]];
    dataInfo._isAnyTimeRefund = [NSString stringWithFormat:@"%@", [dic objectForKey:@"isAnyTimeRefund"]];
    dataInfo._isExpiryRefund = [NSString stringWithFormat:@"%@", [dic objectForKey:@"isExpiryRefund"]];
    dataInfo._maxCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"maxCount"]];
    dataInfo._state = [NSString stringWithFormat:@"%@", [dic objectForKey:@"state"]];
    dataInfo._time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"time"]];
    dataInfo._detailUrl = [NSString stringWithFormat:@"%@", [dic objectForKey:@"detailUrl"]];
	dataInfo._didSellCount = @"1";
    dataInfo._orderId = @"";
    dataInfo._packets = @"";
    dataInfo._telephone = [NSString stringWithFormat:@"%@", [dic objectForKey:@"telephone"]];
    
	 NSArray *piclist =[dic valueForKey:@"picUrls"];
	 NSMutableArray *list = [NSMutableArray array];
	if ([piclist isKindOfClass:[NSArray class]]) {
		for (NSString *dicList in piclist) {
			 [list addObject: dicList];
		}
	}
	dataInfo._picUrls = list;
	
	return [dataInfo autorelease];
	
}
@end

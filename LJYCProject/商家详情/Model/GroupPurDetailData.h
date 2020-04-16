//
//  GroupPurDetailData.h
//  LJYCProject
//
//  Created by z1 on 14-3-14.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupPurDetailData : NSObject
@property (nonatomic, retain) NSString *_id;// 团购id
@property (nonatomic, retain) NSString *_name;// 团购名称
@property (nonatomic, retain) NSString *_oldPrice; // 原始价格
@property (nonatomic, retain) NSString *_price;// 价格
@property (nonatomic, retain) NSString *_sellCount;  // 已购买人数
@property (nonatomic, retain) NSString *_content;// 内容
@property (nonatomic, retain) NSString *_introduce;// 特别提示
@property (nonatomic, retain) NSString *_detailInfo; // 详情
@property (nonatomic, retain) NSString *_isAnyTimeRefund;// 是否支持随时退
@property (nonatomic, retain) NSString *_isExpiryRefund;// 是否支付过期退
@property (nonatomic, retain) NSString *_maxCount; // 最多允许购买数量
@property (nonatomic, retain) NSString *_time; // 剩余时间
@property (nonatomic, retain) NSString *_state;// 状态 0：正常  1：结束
@property (nonatomic, retain) NSString *_detailUrl; // 团购详情Web页面URL
@property (nonatomic, retain) NSArray *_picUrls;// 照片列表

@property (nonatomic, retain) NSString *_didSellCount;  // 已购买数量 用于订单列表-》提交订单
@property (nonatomic, retain) NSString *_orderId;  // 订单id 用于订单列表-》提交订单
@property (nonatomic, retain) NSString *_telephone; //该订单绑定的手机号码

@property (nonatomic, retain) NSString *_orderCode;  // 订单编号
@property (nonatomic, retain) NSString *_shopId;  // 店铺id
@property (nonatomic, retain) NSString *_shopName; //店铺名称
@property (nonatomic, retain) NSString *_shopAddress; //店铺地址
@property (nonatomic, retain) NSString *_totalPrice; //总金额
@property (nonatomic, retain) NSString *_count; //购买数量
@property (nonatomic, retain) NSString *_payTime; //购买时间
@property (nonatomic, retain) NSString *_vouchersId; // 代金劵id
@property (nonatomic, retain) NSString *_thePice; // 代金劵抵用金额
@property (nonatomic, retain) NSString *_startDate; // 有效开始日期
@property (nonatomic, retain) NSString *_endDate;// 有效结束日期
@property (nonatomic, retain) NSString *_noTime; // 不可使用日期
@property (nonatomic, retain) NSString *_note; // 使用规则

@property (nonatomic, retain) NSString *_packets;  // 报文信息


@property (nonatomic, retain) NSMutableArray *_groupVouchers; // 代金券详情列表


+ (GroupPurDetailData *) groupPurDetailDataInfo:(NSDictionary *)dic;
+ (GroupPurDetailData *)vouchersDetailDataInfo:(NSDictionary *)dic;
@end

//
//  InterfaceClass.h
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于生成请求数据 */
#import <Foundation/Foundation.h>
#import "Header.h"
#import "ASIFormDataRequest.h"
#import "ShopFindProperty.h"
#import "AddShopsData.h"
#import "ShopCollectDataResponse.h"
#import "ShopForErrorData.h"
#import "ZipArchive.h"

@interface InterfaceClass : NSObject

+(ASIFormDataRequest *)getConfigurationWithDeviceToken:(NSString *)deviceToken version:(NSString *)version userId:(NSString *)userId; //1
+(ASIFormDataRequest *)getAddress:(NSString *)googleApiUrl; //2
+(ASIFormDataRequest *)getShopList:(ShopFindProperty *)shopFindProperty;
+(ASIFormDataRequest *)userLogin:(NSString*)userName password:(NSString*)password;//登录
+(ASIFormDataRequest *)userRegister:(NSString*)userName password:(NSString*)password;//注册
+(ASIFormDataRequest *)serviceTag;//服务标签基本数据
+(ASIFormDataRequest *)getShopType;//获取店铺类型
+(ASIFormDataRequest *)getCountry;//获取区县类型
+(ASIFormDataRequest *)getCity;//获取城市
+(ASIFormDataRequest *)getConfiguration;//获取统一配置
+(ASIFormDataRequest *)advise:(NSString*)problem telephone:(NSString*)telephone email:(NSString*)email userId:(NSString *)userId userType:(NSString*)userType;//投诉建议
+(ASIFormDataRequest *)addServiceTag:(NSString*)userId name:(NSString*)name;//添加服务标签
+ (ASIFormDataRequest *)getShopDetail:(NSString*)userId withShopId:(NSString*)shopId withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude; //店铺详情
+ (ASIFormDataRequest *)getShopCommentList:(NSString*)userId withShopId:(NSString*)shopId withStar:(NSString *)star withFilter:(NSString *)filter withPageIndex:(NSString*)pageIndex withPageSize:(NSString *)size; //店铺点评列表
+ (ASIFormDataRequest *)getQuestionList:(NSString*)userId withShopId:(NSString*)shopId withFilter:(NSString *)filter withPageIndex:pageIndex withPageSize:(NSString *)size; //问答列表
+ (ASIFormDataRequest *)getCheckCode :(NSString*)telephone;//获取验证码
+ (ASIFormDataRequest *)createShop:(AddShopsData *)shopData;//上传店铺
+ (ASIFormDataRequest *)userFindCollect:(CollectProperty *)collectProperty;//收藏列表
+ (ASIFormDataRequest *)userAddCollect:(NSString*)userId shopId:(NSString*)shopId; //添加收藏
+ (ASIFormDataRequest *)userDelCollect:(NSString*)userId shopId:(NSString*)shopId; //取消收藏
+ (ASIFormDataRequest *)resetPWDWithTelePhone:(NSString *)telephone password:(NSString*)password checkCode:(NSString*)checkCode;//重置密码
+ (ASIFormDataRequest *)userInfo:(NSString*)userId; //客户信息
+ (ASIFormDataRequest *)getUserCommentList:(NSString*)userId PageIndex:(NSString*)pageIndex;//获取用户点评列表
+ (ASIFormDataRequest *)getUserQAList:(NSString*)userId PageIndex:(NSString*)pageIndex;//获取用户问答列表
+ (ASIFormDataRequest *)shopError:(ShopForErrorData *)data;//店铺报错
+ (ASIFormDataRequest *)shopOtherError:(ShopForErrorData *)data;//其它报错
+ (ASIFormDataRequest *)shopAddQuestion:(NSString *)shopId withUserId:(NSString *)userId withContent:(NSString *)content;//提问
+ (ASIFormDataRequest *)shopAddComment:(NSString *)shopId withUserId:(NSString *)userId withContent:(NSString *)content withStar:num;//添加点评
+ (ASIFormDataRequest *)delMessage:(NSString*)messageId;//删除消息
+ (ASIFormDataRequest *)findMessage:(NSString*)userId pageIndex:(NSString*)pageIndex;//消息列表
+ (ASIFormDataRequest *)editPassword:(NSString*)userId oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword;//修改密码  user/singIn
+ (ASIFormDataRequest *)userSingIn:(NSString*)userId pageIndex:(NSString*)pageIndex;//签到
+ (ASIFormDataRequest *)uploadPicture:(NSArray *)imgArray;//上传图片
+ (ASIFormDataRequest *)shopSingIn:(NSString *)shopId withPageIndex:pageIndex;//商户签名簿
+ (ASIFormDataRequest *)setServiceTag:(NSString*)userId serviceTagId:(NSString*)serviceTagId;//配置服务标签
+ (ASIFormDataRequest *)userBinding:(NSString*)userId telephone:(NSString*)telephone  checkCode:(NSString*)checkCode  referee:(NSString*)referee;//绑定手机
+ (ASIFormDataRequest *)userDelBinding:(NSString*)userId telephone:(NSString*)telephone  checkCode:(NSString*)checkCode;//绑定手机
+ (ASIFormDataRequest *)signIn:(NSString*)userId withShopId:(NSString*)shopId;//签到功能
+ (ASIFormDataRequest *)uploadPicture:(NSString*)userId withShopId:(NSString*)shopId withImageArr:(NSArray *)imgArray;//上传店铺照片
+ (ASIFormDataRequest *)userPhotoList:(NSString*)userId withPageIndex:(NSString *)index; //个人中心 相片列表
+ (ASIFormDataRequest *)shopPhotoList:(NSString*)shopId withType:(NSString *)picType withIndex:(NSString *)pageIndex; //店铺照片列表
+ (ASIFormDataRequest *)userLoginOther:(NSString*)account type:(NSString *)type token:(NSString *)token;//授权登录
+ (ASIFormDataRequest *)userSetNickname:(NSString*)userId nickname :(NSString *)nickname;//设置昵称
+ (ASIFormDataRequest *)userPhotoEdit:(NSString*)shopId withUserId:(NSString *)userId withName:(NSString *)photoName withType:(NSString *)photoType; //照片编辑
+ (ASIFormDataRequest *)userPhotoDelete:(NSString *)userId withId:(NSString *)photoId; //照片删除
+ (ASIFormDataRequest *)shopError:(NSString *)userId withShopId:(NSString *)shopId withErrorType:(NSString *)errorType; //店铺报错


+ (ASIFormDataRequest *)submitOrder:(NSString *)userId withOrderId:(NSString *)orderId withId:(NSString *)groupPurId withshopId:(NSString *)shopId withCount:(NSString *)count withToutalPrice:(NSString *)totalPrice withPhone:(NSString *)phoneNum withPayType:(NSString *)payType; //提交订单
+ (ASIFormDataRequest *)groupPurDetail:(NSString *)groupPurId; //团购详情
+ (ASIFormDataRequest *)examineCheckCode:(NSString *)telephone checkCode:(NSString*)checkCode;//校验验证码

+(ASIFormDataRequest *)getMessageState:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType;
+(ASIFormDataRequest *)getOrdersState:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType withPackets:(NSString *)packets;

+ (ASIFormDataRequest *)findOrder:(NSString *)userId filter:(NSString*)filter pageIndex:(NSString*)pageIndex;//订单列表
+ (ASIFormDataRequest *)orderDetail:(NSString *)orderId; //订单详情

+ (ASIFormDataRequest *)cancelOrder:(NSString *)orderId; //取消订单


+ (ASIFormDataRequest *)submitVouchersRefund:(NSString *)orderId withCount:(NSString *)count withPhone:(NSString *)phoneNum; //申请退款
+ (ASIFormDataRequest *)getPackets:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType ; //获取报文
+ (ASIFormDataRequest *)submitResult:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType withpackets:(NSString *)packets; //通知支付结果
+ (ASIFormDataRequest *)actives_find; //活动列表
+ (ASIFormDataRequest *)actives_findShop:(NSString *)actviesid distance:(NSString *)distance longitude:(NSString *)longitude latitude:(NSString *)latitude; //活动搜索出附近农家乐
+ (ASIFormDataRequest *)actives_detail:(NSString *)actviesid; //活动详情
+ (ASIFormDataRequest *)recommendShop:(NSString *)actviesid; //活动推荐店铺列表
+ (ASIFormDataRequest *)orderVouchersDetail:(NSString *)orderId; //代金券订单详情

@end

//
//  Header.h
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于宏定义*/

#ifndef FlightProject_Header_h
#define FlightProject_Header_h



@class AppDelegate;
   
/***************** 枚举区域 *********************/
/*
 张晓婷  定义航程类型
 */
typedef enum{
    SingleType,    // 单程
    RoundTypeGo,   // 往返去程
    RoundTypeBack,   // 往返去程
    ConnectTypeFirst , // 联程1
    ConnectTypeSecond // 联程2
}FlightType;

/*
 张晓婷  定义往返或者联程时的时间类型
 */
//时间类型
typedef enum
{
    StarDate,
    BackDate
} TypeDate;

/*
 崔立东  定义日期控件上的滑动手势
 */
//滑动手势
typedef enum {
	UITouchUnknown,
	UITouchTap,
	UITouchDoubleTap,
	UITouchDrag,
	UITouchMultitouchTap,
	UITouchMultitouchDoubleTap,
	UITouchSwipeLeft,
	UITouchSwipeRight,
	UITouchSwipeUp,
	UITouchSwipeDown,
	UITouchPinchIn,
	UITouchPinchOut,
} UIDevicePlatform;

//乘机人和地址数据
typedef enum{
	OrderSourceType = 0,
	HomeSourceType
} SourceType;

//酒店类型筛选

typedef enum {
	HotelAdministrativeArea = 0,// 行政区
	HotelBusinessArea, // 热门商圈
	HotelMetro,// 地铁
	HotelTraffic,// 交通枢纽
	HotelCharges,// 酒店房价
	HotelLevel,// 酒店星级
	HotelBrand,// 品牌
} FilterHotelType;


//酒店类型回退POP类型

typedef enum {
	PopHotelHome = 0,// 退回酒店主页
	PopHotelFitler, // 退回酒店筛选
	
} PopType;

//日期的后推天数
typedef enum {
	PushBackNOneDay = -1,// -1天
	PushBackZeroDay = 0,// 0天
	PushBackOneDay = 1,// 1天
	PushBackTwoDay=2, // 2天
	PushBackThreeDay=3, // 2天
	PushBackSixDay=6, // 6天
	PushBackSevenDay=7, // 7天
	PushBackEightDay=8, // 8天
	PushBackTwentyDay=20, // 20天
	PushBackOneHundredAndEightyDay=180, // 180天
	PushBackTwoHundredDay=200, // 200天
	
} PushBackDay;

//允许显示的月份

typedef enum {
	AllowShowThreeMonths = 3,// 3个月
	AllowShowSixMonths = 6,// 6个月
	AllowShowSevenMonths = 7,// 7个月
	AllowShowElevenMonths=12, // 12个月

} AllowShowMonths;

//会员在应用中的全部姓名长度
typedef enum {
	AirUserNameLenght = 50,// 乘机人姓名长度
	AddressUserNameLenght=50, // 邮寄地址姓名长度
	HotelUserNameLenght = 50,// 入住人姓名长度
	CarUserNameLenght=50, // 乘车人姓名长度
	UCenterUserNameLenght=50, // 会员个人信息姓名长度
	

	
} UserNameLenght;

/*********************宏定义*************************/


/*
 崔立东 日历常量定义区域
 */
#define CalendarViewTopBarHeight 60 //日历视图距离TopBar的位置高度
#define CalendarViewWidth 320 //日历视图宽度

#define CalendarViewDayWidth 44  //日历小方格宽度
#define CalendarViewDayHeight 44 //日历小方格高度

#define DX(p1, p2)	(p2.x - p1.x) //x轴
#define DY(p1, p2)	(p2.y - p1.y) //y轴
#define SWIPE_DRAG_MIN 12 //滑动拖拽最小值
#define DRAGLIMIT_MAX 4  // 拖拽限定

#define DATEAFTERMONTH 6 //半年后的月份
/*
 张晓婷 定义日历控件上向后推两天
 */
#define Delay_Days 3

/*
 崔立东 定义UITabelView 加载View 使用
 */

#define kViewTag 1

/*
 崔立东 用户登录常量区域
 */

#define keyLoginUserID @"keyLoginUserID_ThreeDemain"     //存储在UserDefault中的UserID
#define keyLoginUserName @"keyLoginUserName_ThreeDemain"     //存储在UserDefault中的UserName
#define keyLoginTelephone @"keyLoginTelephone_ThreeDemain"  //存储在UserDefault中的电话号码
#define keyLoginPassword @"keyLoginPassword_ThreeDemain" //存储在UserDefault中的Password
#define keyAudioLogin @"keyAudioLogin_ThreeDemain"     //存储在UserDefault中的是否自动登录
#define keyCitylKeyWord @"keyCitylKeyWord_ThreeDemain"     //存储在UserDefault中的城市关键字
#define keyAudioRegister @"keyAudioRegister_ThreeDemain"
#define keyShowGrade @"keyShowGrade_ThreeDemain" //存储在UserDefault中的是否显示评分
#define keyIsFirstGradeMark @"keyIsFirstGradeMark_ThreeDemain" //存储在UserDefault中的显示评分标识
#define keyLoginUserLocation @"keyLoginUserLocation_ThreeDemain"     //存储在UserDefault中的用户定位
#define keyFirstLocation @"keyFirstLocation_ThreeDemain"     //如果定位关闭,第一次进入选择城市时提示开启定位。
/*谢孟月 用户登录方式*/
#define keyLoginISLJY @"keyLoginISLJY_ThreeDemain"// 存储用户登录类型 辣郊游会员账号登录YES；其他NO

/***最新一次使用的信用卡信息***/
#define userID_ThreeDemain @"_userID_ThreeDemain"
#define username_ThreeDemain @"_username_ThreeDemain"
#define bank_ThreeDemain @"_bank_ThreeDemain"
#define bankId_ThreeDemain @"_bankId_ThreeDemain"
#define bankIdCard_ThreeDemain @"_bankIdCard_ThreeDemain"
//#define cVV2Code_ThreeDemain @"_cVV2Code_ThreeDemain"
#define id_ThreeDemain @"_id_ThreeDemain"
#define idCard_ThreeDemain @"_idCard_ThreeDemain"
#define validityDate_ThreeDemain @"_validityDate_ThreeDemain"

/*张晓婷  是否显示引导页*/
#define FIRSTINALERT_ThreeDemain @"__FIRSTINALERT__ThreeDemain"
#define ticketSearchHistory_ThreeDemain @"ticketSearchHistory_ThreeDemain"
#define DidRequestConfiger_ThreeDemain @"DidRequestConfiger_ThreeDemain"
#define RegistCoverView_ThreeDemain @"RegistCoverView_ThreeDemain"
/*
 张晓婷 请求服务器的语言
 */ 
#define LanguageType @"CHS"
#define NetFailMessage @"网络好像不给力哦，请稍候再试"
#define TicketNetFailMessage @"网络好像不给力哦，如需预订机票请拨打热线400-6858-999"
#define HotelNetFailMessage @"网络好像不给力哦，如需预订酒店请拨打热线400-6858-999"
#define CarNetFailMessage @"网络好像不给力哦，如需预订租车请拨打热线400-6858-999"

/*
 张晓婷 判断设备是否为ipad
 */ 
#define IS_IPAD  ([[[UIDevice currentDevice].model substringToIndex:4] isEqualToString:@"iPad"])
#define FIRSTINALERT_UUID  @"FIRSTINALERT_UUID"
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
/*
 张晓婷 获取当前屏幕的宽度和高度
 */

#define ViewStartY  IOS7_OR_LATER?0.0:0.0
#define ViewWidth [[UIScreen mainScreen] bounds].size.width //self.view.frame.size.width
#define ViewHeight [[UIScreen mainScreen] bounds].size.height-20 //self.view.frame.size.height

#define MyVersion @"2.0"   // 版本名称，用于显示
#define MyVersionCode 2 // 版本号，用于和服务器比较 3.5版本是15
#define MySysName @"1" // 客户端类型：1：辣郊游C端  2：辣郊游B端
#define DBVersion @"1"  // 1期软件版本对应数据库版本是1
#define AutoLoginOutTime 30

#define ServiceText @"        系统会在您所关注的航班起飞前，自动查询相同日期、航程、航班上的票价情况，当符合条件的低价票出现时，系统会发送短信提示您，您可以通过致电400-6858-999客服中心由客服人员为您重新购买机票，节约的机票款将以畅达币形式充值到您的会员账户中，用于您再次购买机票时抵扣机票款使用。\n友情提示：\n1）	当您使用自动降价服务后，再次申请退票时，退还的票款将以畅达币形式返回到您的账户\n2）	儿童客票不参与自动降价服务\n3）	客票状态发生过改变后（改签、升舱）自动退出自动降价服务"

//#define NavigationController   [[(AppDelegate *)[UIApplication sharedApplication] delegate] navigationController]//self.navigationController //

#define UMENG_APPKEY @"52980b4a56240b0ce6074580" // 用于友盟统计

/*
 张晓婷  字体  （以下为现有字体的宏定义，以后可直接添加到这些字体后，不可随意修改和删除）
 */
#define FontBlodSize80 [UIFont boldSystemFontOfSize:40]
#define FontSize70 [UIFont systemFontOfSize:35]
#define FontSize60 [UIFont systemFontOfSize:30]
#define FontBlodSize56 [UIFont boldSystemFontOfSize:28]
#define FontSize50 [UIFont systemFontOfSize:20]
#define FontBlodSize48 [UIFont boldSystemFontOfSize:24]
#define FontSize48 [UIFont systemFontOfSize:24]
#define FontBlodSize42 [UIFont boldSystemFontOfSize:21]
#define FontSize42 [UIFont systemFontOfSize:21]
#define FontSize40 [UIFont systemFontOfSize:20]
#define FontBlodSize38 [UIFont boldSystemFontOfSize:19]
#define FontBlodSize36 [UIFont boldSystemFontOfSize:18]
#define FontBlodSize32 [UIFont boldSystemFontOfSize:16]
#define FontBlodSize30 [UIFont boldSystemFontOfSize:15]
#define FontBlodSize26 [UIFont boldSystemFontOfSize:13]
#define FontBlodSize20 [UIFont boldSystemFontOfSize:10]
#define FontSize38 [UIFont systemFontOfSize:19]
#define FontSize36 [UIFont systemFontOfSize:18]
#define FontSize32 [UIFont systemFontOfSize:16]
#define FontSize30 [UIFont systemFontOfSize:15]
#define FontSize28 [UIFont systemFontOfSize:14]
#define FontSize26 [UIFont systemFontOfSize:13]
#define FontSize24 [UIFont systemFontOfSize:12]
#define FontSize22 [UIFont systemFontOfSize:11]
#define FontSize20 [UIFont systemFontOfSize:10]
#define FontSize18 [UIFont systemFontOfSize:9]
#define FontSize16 [UIFont systemFontOfSize:8]
#define FontSize14 [UIFont systemFontOfSize:7]
#define FontSize28 [UIFont systemFontOfSize:14]

#define FontColor2B8DD0 [UIColor colorWithRed:0x2B/255.0 green:0x8D/255.0 blue:0xD0/255.0 alpha:1]
#define FontColor909090 [UIColor colorWithRed:0x90/255.0 green:0x90/255.0 blue:0x90/255.0 alpha:1]
#define FontColorAAAAAA [UIColor colorWithRed:0xAA/255.0 green:0xAA/255.0 blue:0xAA/255.0 alpha:1]
#define FontColor333333 [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1]
#define FontColor454545 [UIColor colorWithRed:0x45/255.0 green:0x45/255.0 blue:0x45/255.0 alpha:1]
#define FontColor565656 [UIColor colorWithRed:0x56/255.0 green:0x56/255.0 blue:0x56/255.0 alpha:1]
#define FontColor959595 [UIColor colorWithRed:0x95/255.0 green:0x95/255.0 blue:0x95/255.0 alpha:1]
#define FontColor979797 [UIColor colorWithRed:0x97/255.0 green:0x97/255.0 blue:0x97/255.0 alpha:1]
#define FontColor2585CF [UIColor colorWithRed:0x25/255.0 green:0x85/255.0 blue:0xCF/255.0 alpha:1]
#define FontColor696969 [UIColor colorWithRed:0x69/255.0 green:0x69/255.0 blue:0x69/255.0 alpha:1]
#define FontColor656565 [UIColor colorWithRed:0x65/255.0 green:0x65/255.0 blue:0x65/255.0 alpha:1]
#define FontColor2F6996 [UIColor colorWithRed:0x2F/255.0 green:0x69/255.0 blue:0x96/255.0 alpha:1]
#define FontColorFFFFFF [UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xFF/255.0 alpha:1]
#define FontColor000000 [UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1]
#define FontColor0066CC [UIColor colorWithRed:0x00/255.0 green:0x66/255.0 blue:0xCC/255.0 alpha:1]
#define FontColorFF6113 [UIColor colorWithRed:0xFF/255.0 green:0x61/255.0 blue:0x13/255.0 alpha:1]
#define FontColorA0A0A0 [UIColor colorWithRed:0xA0/255.0 green:0xA0/255.0 blue:0xA0/255.0 alpha:1]
#define FontColor2685CF [UIColor colorWithRed:0x26/255.0 green:0x85/255.0  blue:0xCF/255.0 alpha:1]
#define FontColor3B3B3B [UIColor colorWithRed:0x3B/255.0 green:0x3B/255.0 blue:0x3B/255.0 alpha:1]
#define FontColor6A6B6B [UIColor colorWithRed:0x6A/255.0 green:0x6B/255.0 blue:0x6B/255.0 alpha:1]
#define FontColor2387CF [UIColor colorWithRed:0x23/255.0 green:0x87/255.0 blue:0xCF/255.0 alpha:1]
#define FontColor636363 [UIColor colorWithRed:0x63/255.0 green:0x63/255.0 blue:0x63/255.0 alpha:1]
#define FontColor707070 [UIColor colorWithRed:0x70/255.0 green:0x70/255.0 blue:0x70/255.0 alpha:1]
#define FontColor767676 [UIColor colorWithRed:0x76/255.0 green:0x76/255.0 blue:0x76/255.0 alpha:1]
#define FontColorFF8813 [UIColor colorWithRed:0xFF/255.0 green:0x88/255.0 blue:0x13/255.0 alpha:1]
#define FontColorFF6113 [UIColor colorWithRed:0xFF/255.0 green:0x61/255.0 blue:0x13/255.0 alpha:1]
#define FontColorD50505 [UIColor colorWithRed:0xD5/255.0 green:0x05/255.0 blue:0x05/255.0 alpha:1]
#define FontColor1C7CBC [UIColor colorWithRed:0x1C/255.0 green:0x7C/255.0 blue:0xBC/255.0 alpha:1]
#define FontColor1B77C3 [UIColor colorWithRed:0x1B/255.0 green:0x77/255.0 blue:0xC3/255.0 alpha:1]
#define FontColor7C7D7F [UIColor colorWithRed:0x7C/255.0 green:0x7D/255.0 blue:0x7F/255.0 alpha:1]
#define FontColorA6A6A6 [UIColor colorWithRed:0xA6/255.0 green:0xA6/255.0 blue:0xA6/255.0 alpha:1]
#define FontColor636363 [UIColor colorWithRed:0x63/255.0 green:0x63/255.0 blue:0x63/255.0 alpha:1]
#define FontColor707070 [UIColor colorWithRed:0x70/255.0 green:0x70/255.0 blue:0x70/255.0 alpha:1]
#define FontColor6DC2E1 [UIColor colorWithRed:0x6D/255.0 green:0xC2/255.0 blue:0xE1/255.0 alpha:1]

#define FontColorRed [UIColor colorWithRed:1 green:0 blue:0 alpha:1]
#define FontColorBlue [UIColor colorWithRed:39/255.0 green:84/255.0 blue:136/255.0 alpha:1]
/*
 崔立东  已下色值在日历控件种使用
 */
#define FontColor89CDFF [UIColor colorWithRed:137/255.0 green:205/255.0 blue:255/255.0 alpha:1]
#define FontColorF2F6F7 [UIColor colorWithRed:242/255.0 green:246/255.0 blue:247/255.0 alpha:1]
#define FontColorDADADA [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1]
#define FontColorE7F6FF [UIColor colorWithRed:231/255.0 green:246/255.0 blue:255/255.0 alpha:1]
#define FontColor1F7EBF [UIColor colorWithRed:31/255.0 green:126/255.0 blue:191/255.0 alpha:1]
#define FontColor2985DF [UIColor colorWithRed:41/255.0 green:133/255.0 blue:233/255.0 alpha:1]
#define FontColorF94C00 [UIColor colorWithRed:249/255.0 green:76/255.0 blue:0/255.0 alpha:1]

#define FontColorDDECF6 [UIColor colorWithRed:221/255.0 green:236/255.0 blue:246/255.0 alpha:1]
#define FontColorABABAB [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1]


#define FontColorC3C3C3 [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1]
#define FontColorFFADAD [UIColor colorWithRed:255/255.0 green:173/255.0 blue:173/255.0 alpha:1]
#define FontColor898989 [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1]
#define FontColor9CBAC6 [UIColor colorWithRed:0/255.0 green:200/255.0 blue:118/255.0 alpha:1]
/*
 张晓婷 定义URL和渠道号
 */
// 银联支付连接环境
#define  UPPayMode @"00" // 00代表生产环境，01代表测试环境
// 三期接口地址 //

////// 测试环境
//@"http://192.168.7.101:9010/stsf/mvc/mobile"//
//#define ThreeStagesOtherUrl @"http://jk3.itkt.com:7070/stsf/mvc/mobile"  // 测试环境用到的激活，注册网址
//#define ThreeStagesUrl @"http://jk3.itkt.com:7070/stsf/mvc/mobile"  //
//#define ThreeStagesHttpsUrl @"http://jk3.itkt.com:7070/stsf/mvc/mobile"  //@"https://jk3.itkt.com:8444/stsf/mvc/mobile"
//#define ThreeStagesHotelUrl @"http://t-hotel.itkt.com.cn:6060/RemoteService_Hotel/mvc/mobile"
//#define ThreeStagesCarUrl  @"http://t-car.itkt.com.cn:7070/RemoteService_Car/mvc/mobile"


//#define ThreeStagesOtherUrl @"http://124.207.105.25/netservice/" //外网环境
#define ThreeStagesOtherUrl @"http://www.lajiaou.com:8089/netservice/"
//#define ThreeStagesOtherUrl @"http://192.168.7.92:8082/netservice/" //最新辣郊游个人端环境 2014 -11 -18

////// 试运行环境
//#define ThreeStagesOtherUrl @"http://192.168.7.122:8080/netservice/"
//#define ThreeStagesOtherUrl @"http://192.168.7.92:8082/netservice/"  //@"http://192.168.7.122:8080/netservice/"  // 试运行环境用到的激活，注册网址
//#define ThreeStagesUrl @"http://jk.itkt.com.cn:9393/stsf/mvc/mobile"
//#define ThreeStagesHttpsUrl @"http://jk.itkt.com.cn:9393/stsf/mvc/mobile" //@"https://jk.itkt.com.cn:9443/stsf/mvc/mobile"
//#define ThreeStagesHotelUrl @"http://192.168.7.122:8080/netservice/"
//#define ThreeStagesCarUrl  @"http://116.213.73.8:8060/RemoteService_Car/mvc/mobile"

////生产环境

//#define ThreeStagesOtherUrl @"http://auth.itkt.com:8080/stsf/mvc/mobile" // 生产环境用到的激活，注册网址
//#define ThreeStagesUrl @"http://phone.itkt.com:30088/stsf/mvc/mobile"
//#define ThreeStagesHttpsUrl  @"http://phone.itkt.com:30088/stsf/mvc/mobile" //
//#define ThreeStagesHotelUrl @"http://hotel.itkt.com:8088/RemoteService_Hotel/mvc/mobile"
//#define ThreeStagesCarUrl  @"http://rentcar.itkt.com:8880/RemoteService_Car/mvc/mobile"

#define ThreeStagesTrainUrl @"http://train.itkt.com:9090/itkt_train/mvc/train"//@"http://124.207.105.28:5500/itkt_train/mvc/train"      // 火车票连接地址  //火车票域名连接地址 //

#define channelNo  @"Iphoneap10" //@"Iphoneap31"     //后六位日期，可变 测试渠道号：Tphone0012012120501

#endif

#define LOGINTYPE   @"LOGINTYPE"   //LJY,QQ,WEIBO 三种登录方式

#define QQAPPID     @"100568633"
#define QQAPPKEY    @"de906ef6a9a7dada54086951420804dd"


#define QQToken  @"QQToken"
#define QQID     @"QQID"
#define QQNAME     @"QQNAME"

#define WiressSDKDemoAppKey     @"801213517"
#define WiressSDKDemoAppSecret  @"9819935c0ad171df934d0ffb340a3c2d"
#define REDIRECTURI             @"http://www.ying7wang7.com"

//
//  GetConfiguration.m
//  FlightProject
//
//  Created by longcd on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetConfiguration.h"
//#import "MobClick.h"

@implementation Version

@synthesize _url,_code,_desc,_name,_mandatoryCode;
-(void)dealloc
{
    self._url = nil;
    self._code = nil;
    self._desc = nil;
    self._name = nil;
    self._mandatoryCode = nil;
    [super dealloc];
}
+(Version *)version:(NSDictionary *)resultDic
{
    Version * ver = [[Version alloc] init];
    ver._code = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"code"]] ;
     ver._url = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"url"]] ;
     ver._name = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"name"]] ;
     ver._desc = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"desc"]] ;
    ver._mandatoryCode = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"coerceVersion"]] ;
    return [ver autorelease];
}

@end

@implementation GetConfiguration

@synthesize _umeng,_isFirst,_unPayOrders,_insurance,_cityVersion,_countryVersion,_serviceTagVersion,_shopTypeVersion;
@synthesize _version;
@synthesize _messageArray;
@synthesize needUpdateAirportInfo,needUpdateAirportCityInfo,needUpdateHotelCityList,needUpdateCarRentalList,needUpdateTrainCitysList;
-(void)dealloc
{
    self._umeng = nil;
    self._isFirst = nil;
    self._unPayOrders = nil;
    self._insurance = nil;
    self._countryVersion = nil;
    self._cityVersion = nil;
    self._shopTypeVersion = nil;
    self._serviceTagVersion = nil;
    self._version = nil;
    self._messageArray = nil;
    
    [super dealloc];
}

+(GetConfiguration *) shareGetConfiguration
{
    static GetConfiguration * configuration = nil;
    if (configuration == nil) {
        configuration = [[GetConfiguration alloc] init];
    }
    return configuration;
}
+(GetConfiguration * )shareGetConfiguration : (NSDictionary *)resultDic
{
    GetConfiguration * configuration = [GetConfiguration shareGetConfiguration];
    if (resultDic == nil || [[resultDic objectForKey:@"statusCode"] intValue] != 0) {
        configuration._umeng = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"umeng"]] ;
        configuration._isFirst = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"first"]] ;
        configuration._unPayOrders = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"unpaidOrders"]] ;
        configuration._insurance = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"insurance"]] ;
        configuration._cityVersion = @"0";
        configuration._countryVersion = @"0";
        configuration._serviceTagVersion = @"0";
        configuration._shopTypeVersion = @"0";
        configuration._version = [Version version:[resultDic objectForKey:@"version"]];
        configuration._messageArray = [NSArray arrayWithObjects:@"请稍等，正在为您加载...", nil];
    }
    else {
        configuration._umeng = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"umeng"]] ;
        configuration._isFirst = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"first"]] ;
        configuration._unPayOrders = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"unpaidOrders"]] ;
        configuration._insurance = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"insurance"]] ;
        NSDictionary * dic = [resultDic objectForKey:@"dataVersion"];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            configuration._cityVersion = [NSString stringWithFormat:@"%@",[dic objectForKey:@"city"]] ;
            configuration._countryVersion = [NSString stringWithFormat:@"%@",[dic objectForKey:@"district"]] ;
            configuration._shopTypeVersion = [NSString stringWithFormat:@"%@",[dic objectForKey:@"shopType"]] ;
            configuration._serviceTagVersion = [NSString stringWithFormat:@"%@",[dic objectForKey:@"serviceTag"]] ;
        }
        configuration._version = [Version version:[resultDic objectForKey:@"version"]];
        NSString * messageStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"news"]?[resultDic objectForKey:@"news"]:@""] ;
        if ([messageStr isEqualToString:@""]) {
            configuration._messageArray = [NSArray arrayWithObjects:@"请稍等，正在为您加载...", nil];
        }
        else {
            configuration._messageArray = [messageStr componentsSeparatedByString:@"&"];
        }

        if ([configuration._umeng boolValue]) {
            // 友盟统计
            // [MobClick setLogEnabled:YES];
//            [MobClick setAppVersion:[NSString stringWithFormat:@"%@",MyVersion]]; 
//            [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:channelNo];
//            [MobClick updateOnlineConfig];
//            [MobClick setCrashReportEnabled:YES];
        }
        else {
        }
    }
    return configuration ;
}

@end

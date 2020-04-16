//
//  GetBasicInfoFromServer.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "GetBasicInfoFromServer.h"
#import "DataClass.h"
#import "GetConfiguration.h"
@implementation GetBasicInfoFromServer
@synthesize delegate, cityDelegate,configerDic;


-(void)dealloc
{
    self.delegate = nil;
    self.cityDelegate = nil;
    self.configerDic = nil;
    [super dealloc];
}

- (NSArray *)getVersionsFromDB
{
    NSArray * array = [DataClass selectFromVersions];
    return array;
}
- (void) getConfiguration
{
    
    NSArray  * array = [self getVersionsFromDB];
    NSLog(@"%@",array);
    NSMutableDictionary * mDic = [NSMutableDictionary dictionary];
    for (NSArray * elem in array) {
        // @"table_name", @"version"
        [mDic setValue:[elem objectAtIndex:1] forKey:[elem objectAtIndex:0]];
    }
    
    //NSLog(@"数据库版本：%@",mDic);
    NSString * dbVersionStr = [NSString stringWithFormat:@"%@",[mDic objectForKey:@"DBVersion"]];
    
    if ([dbVersionStr intValue] < [DBVersion intValue] ){
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *originFilePath = [docPath stringByAppendingPathComponent:@"database.sqlite"];
        NSString *sqlFilePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
        
        NSFileManager *fm = [NSFileManager defaultManager];//文件管理器
        if ([fm fileExistsAtPath:originFilePath] == YES) {
            NSError *error = nil;
            if([fm removeItemAtPath:originFilePath error:&error] == NO)
            {
                NSLog(@"删除数据库的时候出现了错误：%@",[error localizedDescription]);
            }
            
            if([fm copyItemAtPath:sqlFilePath toPath:originFilePath error:&error] == NO)
            {
                NSLog(@"创建数据库的时候出现了错误：%@",[error localizedDescription]);
            }
            else
            {
                [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DBVersion",DBVersion, nil],nil]];
            }
        }
    }
    
    NSArray * _messageArray = [GetConfiguration shareGetConfiguration]._messageArray;
    if (_messageArray == nil) {
        [GetConfiguration shareGetConfiguration]._messageArray = [NSArray arrayWithObjects:@"请稍等，正在为您加载...", nil];
    }
    ASIFormDataRequest * theRequest = [InterfaceClass getConfiguration];
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onConfigurationPaseredResult:) Delegate:self needUserType:Default];
    
}
-(void)onConfigurationPaseredResultFail:(NSDictionary *)resultDic
{
    [DataClass selectServiceTag_BasicInfo];
    [DataClass selectShopType_BasicInfo];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didBasicInfoResult:)]) {  // zxt 1114 移动到最下面
        [self.delegate performSelector:@selector(didBasicInfoResult:) withObject:resultDic];
    }
}
- (void) onConfigurationPaseredResult:(NSDictionary *) resultDic
{
    self.configerDic = resultDic;
    
    if ([GetConfiguration shareGetConfiguration]._version == nil)
    {
        GetConfiguration * configuration = [GetConfiguration shareGetConfiguration:resultDic];
        
        NSArray  * array = [self getVersionsFromDB];
        
        NSMutableDictionary * mDic = [NSMutableDictionary dictionary];
        for (NSArray * elem in array) {
            // @"table_name", @"version"
            [mDic setValue:[elem objectAtIndex:1] forKey:[elem objectAtIndex:0]];
        }
        NSLog(@"%@",mDic);
        if ([(NSString *)[mDic objectForKey:@"City"] compare:configuration._cityVersion] < 0 ){
            configuration.needUpdateAirportInfo = TRUE;
            [self getCity];
        }

        
        if ([(NSString *)[mDic objectForKey:@"Country"] compare:configuration._countryVersion] < 0 ){
            configuration.needUpdateAirportCityInfo = TRUE;
            [self getCountry];
        }

        if ([(NSString *)[mDic objectForKey:@"ServiceTag"] compare:configuration._serviceTagVersion] < 0 ){
            configuration.needUpdateHotelCityList = TRUE;
            needDownServiceTags = YES;
        }
        else
        {
            [DataClass selectServiceTag_BasicInfo];
            if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(showServiceTags)]) {
                [self.cityDelegate performSelector:@selector(showServiceTags)];
            }
        }
        
        if ([(NSString *)[mDic objectForKey:@"ShopType"] compare:configuration._shopTypeVersion] < 0 ){
            configuration.needUpdateCarRentalList = TRUE;
            [self getShopType];
        }
        else
        {
            [DataClass selectShopType_BasicInfo];
            if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(showShopType)]) {
                [self.cityDelegate performSelector:@selector(showShopType)];
            }
            if (needDownServiceTags) {
                [self getServiceTag];
            }
            else
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(didBasicInfoResult:)]) {  // zxt 1114 移动到最下面
                    [self.delegate performSelector:@selector(didBasicInfoResult:) withObject:resultDic];
                }
            }
        }
    }
    else{
        
    }
    
}
- (void)getCity
{
    ASIFormDataRequest * theRequest = [InterfaceClass getCity];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCityPaseredResult:) Delegate:[self retain] needUserType:Default];
}
- (void)getCountry
{
    ASIFormDataRequest * theRequest = [InterfaceClass getCountry];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCountryPaseredResult:) Delegate:[self retain] needUserType:Default];
}

-(void) getServiceTag
{
    ASIFormDataRequest * theRequest = [InterfaceClass serviceTag];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onServiceTagPaseredResult:) Delegate:[self retain] needUserType:Default];
}
-(void) getShopType
{
    ASIFormDataRequest * theRequest = [InterfaceClass getShopType];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onShopTypePaseredResult:) Delegate:[self retain] needUserType:Default];
}

-(void) onCityPaseredResult:(NSDictionary *) resultDic
{
    [self performSelectorInBackground:@selector(CityTread:) withObject:resultDic];
}
- (void)onCountryPaseredResult:(NSDictionary *)resultDic
{
    [self performSelectorInBackground:@selector(CountryTread:) withObject:resultDic];
}
-(void) onServiceTagPaseredResult:(NSDictionary *) resultDic
{
    [self performSelectorInBackground:@selector(ServiceTagTread:) withObject:resultDic];
}
-(void) onShopTypePaseredResult:(NSDictionary *) resultDic
{
    [self performSelectorInBackground:@selector(ShopTypeTread:) withObject:resultDic];
}

-(void) CityTread:(NSDictionary *) resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateAirportInfo = FALSE;
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSDictionary * dic in [resultDic objectForKey:@"citys"]) {
        NSString * firstLetter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]];
        NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        NSString * flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"topFlag"]];
        NSString * jianPin = [NSString stringWithFormat:@"%@",[dic objectForKey:@"initial"]?[dic objectForKey:@"initial"]:@""];
        NSString * ename = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pinyin"]?[dic objectForKey:@"pinyin"]:@""];
//        [[BaseInfo shareBaseInfo]._Citys addObject:[City CityWithElem:[NSArray arrayWithObjects:code, name, firstLetter,jianPin,ename,flag,nil]]];
        [mArray addObject:[NSArray arrayWithObjects: code, name,firstLetter,flag,jianPin,ename,nil]];
    }    
    
    [DataClass insertIntoCityWithArray:mArray];
    [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"City",[GetConfiguration shareGetConfiguration]._cityVersion, nil], nil]];
    
//    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
//        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
//    }
    
}

-(void) CountryTread:(NSDictionary *)resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateAirportCityInfo = FALSE;

    NSMutableArray * mArray = [NSMutableArray array];
    for (NSDictionary * dic in [resultDic objectForKey:@"districts"]) {
        NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        NSString * cityid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cityId"]];
        
        [mArray addObject:[NSArray arrayWithObjects:cityid,code, name,[NSString stringWithFormat:@"%@",[dic objectForKey:@"ename"]],[NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]],[NSString stringWithFormat:@"%@",[dic objectForKey:@"jianPin"]],[NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]],nil]];
        
//        [[BaseInfo shareBaseInfo]._Countrys addObject:[District DistrictWithElem:[NSArray arrayWithObjects:code, name, cityid,nil]]];

    }
    [DataClass insertIntoCountryWithArray:mArray];
    [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"Country",[GetConfiguration shareGetConfiguration]._countryVersion, nil], nil]];
    
//    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
//        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
//    }
    
}

-(void)ServiceTagTread:(NSDictionary *)resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateHotelCityList = FALSE;
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSDictionary * dic in [resultDic objectForKey:@"serviceTags"]) {
        NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        NSString * type = [NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]];
        NSString * picUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picUrl"]];
        NSString * defaultNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isDefault"]];
        NSString * index = [NSString stringWithFormat:@"%@",[dic objectForKey:@"indexNum"]];

        [mArray addObject:[NSArray arrayWithObjects:code,name,type,picUrl,defaultNum,index,nil]];
//        [BaseInfo ServiceTagFromArr:[NSArray arrayWithObjects:code,name,type,picUrl,defaultNum,index,nil]];
    }
    
//    [BaseInfo shareBaseInfo]._ServiceTags = [ServiceTagData getServiceTagData:resultDic];

    [DataClass insertIntoServiceTagWithArray:mArray];
    [DataClass selectServiceTag_BasicInfo];
    [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"ServiceTag",[GetConfiguration shareGetConfiguration]._serviceTagVersion, nil], nil]];
    
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(showServiceTags)]) {
        [self.cityDelegate performSelector:@selector(showServiceTags)];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didBasicInfoResult:)]) {  // zxt 1114 移动到最下面
//        [self.delegate performSelector:@selector(didBasicInfoResult:) withObject:self.configerDic];
        [self.delegate performSelectorOnMainThread:@selector(didBasicInfoResult:) withObject:self.configerDic waitUntilDone:NO];
    }
}

-(void)ShopTypeTread:(NSDictionary *)resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateCarRentalList = FALSE;
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSDictionary * dic in [resultDic objectForKey:@"shopTypes"]) {
        NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        NSString * picUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picUrl"]];
        NSString *flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isDefault"]];
        NSString *index = [NSString stringWithFormat:@"%@",[dic objectForKey:@"indexNum"]];

        [mArray addObject:[NSArray arrayWithObjects:code,name,picUrl,flag,index,nil]];
//        [BaseInfo ShopTypeFromArr:[NSArray arrayWithObjects:code,name,picUrl,flag,index,nil]];
    }
    [DataClass insertIntoShopTypeWithArray:mArray];
    [DataClass selectShopType_BasicInfo];
    [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"ShopType",[GetConfiguration shareGetConfiguration]._shopTypeVersion, nil], nil]];
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(showShopType)]) {
        [self.cityDelegate performSelector:@selector(showShopType)];
    }
    if (needDownServiceTags) {
        [self getServiceTag];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didBasicInfoResult:)]) {  // zxt 1114 移动到最下面
            [self.delegate performSelector:@selector(didBasicInfoResult:) withObject:self.configerDic];
        }
    }
}


@end

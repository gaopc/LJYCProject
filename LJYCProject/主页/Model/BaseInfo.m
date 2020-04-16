//
//  BaseInfo.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "BaseInfo.h"

@implementation BaseInfo
@synthesize _Citys,_Countrys,_ServiceTags,_ShopTypes,_CitysCountrys,_ServiceAllTags,_ServiceShowTags,_ServiceShowTags_login;
- (void)dealloc
{
    self._Citys = nil;
    self._Countrys = nil;
    self._ShopTypes = nil;
    self._ServiceTags = nil;
    self._CitysCountrys = nil;
    self._ServiceShowTags = nil;
    self._ServiceAllTags = nil;
    self._ServiceShowTags_login = nil;
    [super dealloc];
}
+(BaseInfo *)shareBaseInfo
{
    static BaseInfo * baseInfo = nil;
    if (baseInfo == nil) {
        baseInfo = [[BaseInfo alloc] init];
        baseInfo._Citys = [NSMutableArray array];
        baseInfo._Countrys = [NSMutableArray array];
        baseInfo._ShopTypes = [NSMutableArray array];
        baseInfo._ServiceShowTags = [NSMutableArray array];
        baseInfo._ServiceShowTags_login = [NSMutableArray array];
        baseInfo._ServiceAllTags = [NSMutableDictionary dictionary];
    }
    return baseInfo;
}
+(void) ShopTypeFromArr:(NSArray *)array
{
	ShopType * type = [[ShopType alloc] init];
	type._Type_id = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
	type._Type_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    type._Type_picUrl = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    type._Type_defaultNum = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    type._Type_index = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
	[[BaseInfo shareBaseInfo]._ShopTypes addObject:type];
}
+(void)ServiceTagFromArr:(NSArray*)arr
{
    ServiceTag * aTag = [[ServiceTag alloc] init];
    aTag._tag_id = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    aTag._tag_name = [NSString stringWithFormat:@"%@",[arr objectAtIndex:1]];
    aTag._tag_type = [NSString stringWithFormat:@"%@",[arr objectAtIndex:2]];
    aTag._tag_picUrl = [NSString stringWithFormat:@"%@",[arr objectAtIndex:3]];
    aTag._tag_defaultNum = [NSString stringWithFormat:@"%@",[arr objectAtIndex:4]];
    aTag._tag_index = [NSString stringWithFormat:@"%@",[arr objectAtIndex:5]];
    if ([aTag._tag_defaultNum boolValue]) {
        [[BaseInfo shareBaseInfo]._ServiceShowTags addObject:aTag];
    }
    int tagid = [aTag._tag_type integerValue]; //0其他1餐饮2住宿3室内4室外
    NSString * key = tagid==0?@"其他":(tagid==1?@"餐饮":(tagid==2?@"住宿":(tagid==3?@"室内娱乐":(tagid==4?@"室外娱乐":@""))));
    NSMutableArray * value = [[BaseInfo shareBaseInfo]._ServiceAllTags valueForKey:key];
    if (value) {
        [value addObject:aTag];
    }
    else
    {
        NSMutableArray * valueArray = [NSMutableArray arrayWithObject:aTag];
        [[BaseInfo shareBaseInfo]._ServiceAllTags setObject:valueArray forKey:key];
    }

}
+(void)CountryFromArr:(NSArray*)arr
{
    
}
//+(NSDictionary*)getServiceTagData:(NSDictionary*)dic
//{
//    NSArray *serviceTagList = [dic objectForKey:@"serviceTags"];
//    NSMutableDictionary * mDic = [NSMutableDictionary dictionary];
//    for (NSDictionary * elemDic in serviceTagList) {
//        if ([elemDic isKindOfClass:[NSDictionary class]]) {//0其他1餐饮2住宿3室内4室外
//            ServiceTag * aTag = [[ServiceTag alloc] init];
//            aTag._tag_id = [NSString stringWithFormat:@"%@",[elemDic objectForKey:@"id"]];
//            aTag._tag_name = [NSString stringWithFormat:@"%@",[elemDic objectForKey:@"name"]];
//            aTag._tag_type = [NSString stringWithFormat:@"%@",[elemDic objectForKey:@"type"]];
//            aTag._tag_picUrl = [NSString stringWithFormat:@"%@",[elemDic objectForKey:@"picUrl"]];
//            aTag._tag_defaultNum = [NSString stringWithFormat:@"%@",[elemDic objectForKey:@"defaultNum"]];
//            if ([aTag._tag_defaultNum integerValue]>0) {
//                [[BaseInfo shareBaseInfo]._ServiceShowTags addObject:aTag];
//            }
//            int tagid = [aTag._tag_id integerValue];
//            NSString * key = tagid==0?@"其他":(tagid==1?@"餐饮":(tagid==2?@"住宿":(tagid==3?@"室内":(tagid==4?@"室外":@""))));
//            NSMutableArray * value = [mDic valueForKey:key];
//            if (value) {
//                [value addObject:aTag];
//            }
//            else
//            {
//                NSMutableArray * valueArray = [NSMutableArray arrayWithObject:aTag];
//                [mDic setObject:valueArray forKey:key];
//            }
//        }
//    }
//    return mDic;
//}

//+(NSDictionary*)getCitysCountrys:(NSArray*)array
//{
////    NSArray * elem = [NSArray arrayWithObjects:@"City.city_id", @"City.city_name",@"City.first_letter", @"City.jian_pin",@"City.e_name",@"City.hot_flag",@"Country.city_id",@"Country.country_id",@"Country.country_name",nil];
//    NSMutableArray * keys = [NSMutableArray array];
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    for (NSArray * elem in array) {
//        City * city = [keys lastObject];
//        if (![[elem objectAtIndex:0] isEqualToString:city._id]) {
//            city = [City CityWithElem:elem];
//            [keys addObject:city];
//        }
//        District * dis = [District DistrictWithElem:[NSArray arrayWithObjects:[elem objectAtIndex:6], [elem objectAtIndex:7],[elem objectAtIndex:8],nil]];
//        [dic setObject:dis forKey:city];
//    }
//}
@end

//
//  ShopForSignInData.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-15.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForSignInData.h"

@implementation ShopForSignInData
@synthesize _time, _userName;

- (void)dealloc
{
    self._time = nil;
    self._userName = nil;
    [super dealloc];
}

+ (ShopForSignInData *)getShopSignInData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSString* timeDate = [self compareCurrentTime:[dic objectForKey:@"time"]];
    
    ShopForSignInData *aSignInInfo = [[ShopForSignInData alloc] init];
    aSignInInfo._userName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    aSignInInfo._time = [NSString stringWithFormat:@"%@",timeDate];

    return [aSignInInfo autorelease];
}

+ (NSString *) compareCurrentTime:(NSString*)timeStr
{
    long long dataLong = [timeStr longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString* signTime = [formatter stringFromDate:date];
    NSString* nowTime = [formatter stringFromDate:[NSDate date]];
    
    long temp = [nowTime intValue] - [signTime intValue];
    NSString *result = @"";
    
    NSDateFormatter* formatter1 = [[[NSDateFormatter alloc] init] autorelease];
    [formatter1 setDateFormat:@"MM-dd HH:mm:ss"];
    NSString* str = [formatter1 stringFromDate:date];
    
    switch (temp) {
        case 0:
            result = [NSString stringWithFormat:@"%@", [str substringFromIndex:6]];
            break;
        case 1:
            result = [NSString stringWithFormat:@"昨天 %@", [str substringFromIndex:6]];
            break;
        case 2:
            result = [NSString stringWithFormat:@"前天 %@", [str substringFromIndex:6]];
            break;
        default:
            result = str;
            break;
    }
    
    return  result;
}
@end


@implementation ShopForSignData
@synthesize _signDataArr;
@synthesize _count, _totalPage;

- (void)dealloc
{
    self._totalPage = nil;
    self._count = nil;
    self._signDataArr = nil;
    [super dealloc];
}

+ (ShopForSignData *)setShopForSignData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    ShopForSignData *dataInfo = [[ShopForSignData alloc] init];
    
    dataInfo._count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]];
    dataInfo._totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]];
    dataInfo._signDataArr = [self setShopForSign:dic];
    return dataInfo;
}

+ (NSMutableArray *)setShopForSign:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"signInUsers"];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[ShopForSignInData getShopSignInData:elem]];
    }
    return marray;
}
@end

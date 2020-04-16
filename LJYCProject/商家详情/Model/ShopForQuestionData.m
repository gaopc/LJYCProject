//
//  ShopForQuestionData.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-8.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForQuestionData.h"

@implementation ShopForQuestionData
@synthesize _questionArr;
@synthesize _count, _totalPage;

- (void)dealloc
{
    self._totalPage = nil;
    self._count = nil;
    self._questionArr = nil;
    [super dealloc];
}

+ (ShopForQuestionData *)setShopForQuestionData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    ShopForQuestionData *dataInfo = [[ShopForQuestionData alloc] init];
    
    dataInfo._count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]];
    dataInfo._totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]];
    dataInfo._questionArr = [self setShopForComment:dic];
    return dataInfo;
}

+ (NSMutableArray *)setShopForComment:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"qas"];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[ShopForQuestionInfo setShopForQuestionInfo:elem]];
    }
    return marray;
}
@end


@implementation ShopForQuestionInfo
@synthesize _comContent, _comId, _comName, _comReplyContent, _comReplyTime, _comTime;

- (void)dealloc
{
    self._comContent = nil;
    self._comId = nil;
    self._comName = nil;
    self._comReplyContent = nil;
    self._comReplyTime = nil;
    self._comTime = nil;
    [super dealloc];
}

+ (ShopForQuestionInfo *)setShopForQuestionInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    ShopForQuestionInfo *dataInfo = [[ShopForQuestionInfo alloc] init];
    
    long long dataLong = [[dic objectForKey:@"time"] longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* str = [formatter stringFromDate:date];
    
    dataInfo._comId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    dataInfo._comName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    dataInfo._comTime = [NSString stringWithFormat:@"%@", str];
    dataInfo._comContent = [NSString stringWithFormat:@"%@", [dic objectForKey:@"content"]];
    dataInfo._comReplyTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyTime"]];
    dataInfo._comReplyContent = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyContent"]];
    return dataInfo;
}
@end

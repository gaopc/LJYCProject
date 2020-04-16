//
//  ShopForCommentData.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-8.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForCommentData.h"

@implementation ShopForCommentData
@synthesize _commentArr;
@synthesize _count, _totalPage;

- (void)dealloc
{
    self._totalPage = nil;
    self._count = nil;
    self._commentArr = nil;
    [super dealloc];
}

+ (ShopForCommentData *)setShopForCommentData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    ShopForCommentData *dataInfo = [[ShopForCommentData alloc] init];
    
    dataInfo._count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]];
    dataInfo._totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]];
    dataInfo._commentArr = [self setShopForComment:dic];
    return dataInfo;
}

+ (NSMutableArray *)setShopForComment:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"comments"];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[ShopForCommentInfo setShopForCommentInfo:elem]];
    }
    return marray;
}
@end


@implementation ShopForCommentInfo
@synthesize _comContent, _comId, _comLevel, _comName, _comReplyContent, _comReplyTime, _comStar, _comTime;

- (void)dealloc
{
    self._comContent = nil;
    self._comId = nil;
    self._comLevel = nil;
    self._comName = nil;
    self._comReplyContent = nil;
    self._comReplyTime = nil;
    self._comStar = nil;
    self._comTime = nil;
    [super dealloc];
}

+ (ShopForCommentInfo *)setShopForCommentInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    long long dataLong = [[dic objectForKey:@"time"] longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* str = [formatter stringFromDate:date];
    
    ShopForCommentInfo *dataInfo = [[ShopForCommentInfo alloc] init];
    
    dataInfo._comId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    dataInfo._comName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    dataInfo._comLevel = [NSString stringWithFormat:@"%@", [dic objectForKey:@"level"]];
    dataInfo._comStar = [NSString stringWithFormat:@"%@", [dic objectForKey:@"star"]];
    dataInfo._comTime = [NSString stringWithFormat:@"%@", str];
    dataInfo._comContent = [NSString stringWithFormat:@"%@", [dic objectForKey:@"content"]];
    dataInfo._comReplyTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyTime"]];
    dataInfo._comReplyContent = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyContent"]];
    return dataInfo;
}
@end
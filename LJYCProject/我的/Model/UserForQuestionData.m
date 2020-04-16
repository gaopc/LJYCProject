//
//  UserForQuestionData.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "UserForQuestionData.h"

@implementation UserForQuestionData
@synthesize _questionArr;
@synthesize _count, _totalPage;

- (void)dealloc
{
    self._totalPage = nil;
    self._count = nil;
    self._questionArr = nil;
    [super dealloc];
}

+ (UserForQuestionData *)setUserForQuestionData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UserForQuestionData *dataInfo = [[UserForQuestionData alloc] init];
    
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
        [marray addObject:[UserForQuestionInfo setUserForQuestionInfo:elem]];
    }
    return marray;
}

@end



@implementation UserForQuestionInfo
@synthesize _shopId,_shopName,_shopStar,_id,_time,_content,_replyTime,_replyContent;

- (void)dealloc
{
    self._shopId = nil;
    self._shopName= nil;
    self._shopStar= nil;
    self._id= nil;
    self._time= nil;
    self._content= nil;
    self._replyTime= nil;
    self._replyContent= nil;
    [super dealloc];
}

+ (UserForQuestionInfo *)setUserForQuestionInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UserForQuestionInfo *dataInfo = [[UserForQuestionInfo alloc] init];
    
    dataInfo._shopId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopId"]];
    dataInfo._shopName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopName"]];
    dataInfo._shopStar = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopStar"]];
    dataInfo._id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    dataInfo._time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"time"]];
    dataInfo._content = [NSString stringWithFormat:@"%@", [dic objectForKey:@"content"]];
    dataInfo._replyTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyTime"]];
    dataInfo._replyContent = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyContent"]];
    return dataInfo;
}

@end

//
//  UserForCommentData.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "UserForCommentData.h"

@implementation UserForCommentData
@synthesize _commentArr;
@synthesize _count, _totalPage;

- (void)dealloc
{
    self._totalPage = nil;
    self._count = nil;
    self._commentArr = nil;
    [super dealloc];
}

+ (UserForCommentData *)setUserForCommentData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UserForCommentData *dataInfo = [[UserForCommentData alloc] init];
    
    dataInfo._count = [NSString stringWithFormat:@"%@", [dic objectForKey:@"count"]];
    dataInfo._totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]];
    dataInfo._commentArr = [self setUserForComment:dic];
    return dataInfo;
}

+ (NSMutableArray *)setUserForComment:(NSDictionary *)dic
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
        [marray addObject:[UserForCommentInfo setUserForCommentInfo:elem]];
    }
    return marray;
}

@end


@implementation UserForCommentInfo
@synthesize _shopId,_shopName,_shopStar,_id,_star,_time,_content,_replyTime,_replyContent;

- (void)dealloc
{
    self._shopId = nil;
    self._shopName = nil;
    self._shopStar = nil;
    self._id = nil;
    self._star = nil;
    self._time = nil;
    self._content = nil;
    self._replyTime = nil;
    self._replyContent = nil;
    [super dealloc];
}

+ (UserForCommentInfo *)setUserForCommentInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UserForCommentInfo *dataInfo = [[UserForCommentInfo alloc] init];
    
    dataInfo._shopId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopId"]];
    dataInfo._shopName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopName"]];
    dataInfo._shopStar = [NSString stringWithFormat:@"%@", [dic objectForKey:@"shopStar"]];
    dataInfo._id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    dataInfo._star = [NSString stringWithFormat:@"%@", [dic objectForKey:@"star"]];
    dataInfo._time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"time"]];
    dataInfo._content = [NSString stringWithFormat:@"%@", [dic objectForKey:@"content"]];
    dataInfo._replyTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyTime"]];
    dataInfo._replyContent = [NSString stringWithFormat:@"%@", [dic objectForKey:@"replyContent"]];
    return dataInfo;
}
@end

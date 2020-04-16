//
//  ActivetyModel.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-21.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "ActivetyModel.h"

@implementation ActivetyItem

@synthesize _activetyId,_picUrl,_shops;
@synthesize _url;
@synthesize _distance, _latitude, _longitude, _title;

- (void)dealloc
{
    self._title = nil;
    self._longitude = nil;
    self._latitude = nil;
    self._distance = nil;
    self._activetyId = nil;
    self._picUrl = nil;
    self._shops = nil;
    self._url = nil;
    [super dealloc];
}
+(ActivetyItem *) ActivetyItemWithDic:(NSDictionary *)dic
{
    ActivetyItem *sender = [[ActivetyItem alloc] init];
    sender._activetyId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]] ;
    sender._picUrl =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"picUrl"]] ;
    sender._latitude =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"lat"]];
    sender._longitude =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"lon"]];
    sender._distance =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"distance"]];
    sender._title =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"title"]];
    sender._shops =   nil ;
    sender._url = nil;
    return [sender autorelease];
}
-(void)getShopsWithDic:(NSDictionary *)dic
{
    NSArray * array = [dic objectForKey:@"shops"];
    if ([array isKindOfClass:[NSArray class]]) {
        self._shops = [NSMutableArray array];
        for (NSDictionary * elem in array) {
            [self._shops addObject:[Shops activetyShopsWithDic:elem]];
        }
    }

}

+ (NSMutableArray *)getShopsArrayWithDic:(NSDictionary *)dic
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    NSArray * array = [dic objectForKey:@"shops"];
    if ([array isKindOfClass:[NSArray class]]) {
        for (NSDictionary * elem in array) {
            [returnArray addObject:[Shops activetyShopsWithDic:elem]];
        }
    }
    return [returnArray autorelease];
}
@end

@implementation ActivetyModel
@synthesize _hotList,_topList;
- (void)dealloc
{
    self._hotList = nil;
    self._topList = nil;
    [super dealloc];
}
+(ActivetyModel *) ActivetyModelWithDic:(NSDictionary *)dic
{
    ActivetyModel *sender = [[ActivetyModel alloc] init];
    sender._hotList = [NSMutableArray array];
    sender._topList = [NSMutableArray array];

    NSArray * array = [dic objectForKey:@"actives"];
    if ([array isKindOfClass:[NSArray class]]) {
        for (NSDictionary * elem in array) {
            NSString * type = [NSString stringWithFormat:@"%@" ,[elem objectForKey:@"type"]];
            if ([type intValue]==1) {
                [sender._topList addObject:[ActivetyItem ActivetyItemWithDic:elem]];
            }
            else if ([type intValue]==2)
            {
                [sender._hotList addObject:[ActivetyItem ActivetyItemWithDic:elem]];
            }
        }
    }
    return [sender autorelease];
}
@end

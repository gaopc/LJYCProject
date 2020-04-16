//
//  UserSignInData.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "UserSignInData.h"

@implementation UserSignInData
@synthesize totalPage,count,integral,level,signIns;

- (void)dealloc
{
    self.totalPage = nil;
    self.count = nil;
    self.integral = nil;
    self.level = nil;
    self.signIns = nil;
    
    [super dealloc];
}

+(UserSignInData*)getUserSignInData:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}

    UserSignInData *userSignInData = [[[UserSignInData alloc] init] autorelease];
    userSignInData.totalPage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPage"]];
    userSignInData.count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
    userSignInData.integral = [NSString stringWithFormat:@"%@",[dic objectForKey:@"integral"]];
    userSignInData.level = [NSString stringWithFormat:@"%@",[dic objectForKey:@"level"]];
    
    NSArray *aSignins = [dic objectForKey:@"signIns"];
    if([aSignins isKindOfClass:[NSArray class]] && ![aSignins isEqual:@""])
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary *aDic in aSignins)
        {
            SignInInfo *aSignInInfo = [[SignInInfo alloc] init];
            aSignInInfo._shopId = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"shopId"]];
            aSignInInfo._shopName = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"shopName"]];
            aSignInInfo._time = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"time"]];
            aSignInInfo._star = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"shopStar"]];
            [array addObject:aSignInInfo];
            [aSignInInfo release];
        }
        userSignInData.signIns = array;
        
    
    }
    if([userSignInData.signIns count] == 0)
    {
        userSignInData.signIns = nil;
    }
    return userSignInData;
}

@end


@implementation SignInInfo
@synthesize _shopId,_shopName, _star, _time;

- (void)dealloc
{
    self._shopId = nil;
    self._shopName = nil;
    self._time = nil;
    self._star = nil;
    
    [super dealloc];
}


@end
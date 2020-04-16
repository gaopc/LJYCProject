//
//  UserLogin.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "UserLogin.h"
#import "ServiceTag.h"
@implementation UserLogin

@synthesize userID,passWord,tags,deviceToken,_telephone,_userName,_userType;
@synthesize showMapInfo;
@synthesize _latitude, _longitude;
-(void)dealloc
{
    self.userID = nil;
    self.passWord = nil;
    self.tags = nil;
    self.deviceToken = Nil;
    self._telephone = nil;
    self._userName = nil;
    self._userType = nil;
    self.showMapInfo = FALSE;
    self._longitude = nil;
    self._latitude = nil;
    [super dealloc];
}
+(UserLogin *)sharedUserInfo
{
    static UserLogin * info = nil;
    if (info == nil) {
        info = [[UserLogin alloc] init];
        info._telephone = nil;
        info._userName = nil;
        info.userID = nil;
        info.passWord = nil;
        info._userType = nil;
        info.tags = nil;
	info.showMapInfo = FALSE;
        info._latitude = nil;
        info._longitude = nil;
     
	    
        //        info.userID = @"69743";
        //        info.userID = @"69659";
        //        info.telePhone = @"13531375946";
        //        info.email = @"";
    }
    return info;
}

+(UserLogin*)GetUserLogin:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
    
    UserLogin *aUserLogin = [UserLogin sharedUserInfo];
    
    aUserLogin.userID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]];
    aUserLogin._telephone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"telephone"]];

    NSMutableArray *aTags = [[NSMutableArray alloc]init];
    NSArray *tagsList = [dic objectForKey:@"serviceTag"];
    
    if([tagsList isKindOfClass:[NSArray class]] && ![tagsList isEqual:nil])
    {
        [[BaseInfo shareBaseInfo]._ServiceShowTags_login removeAllObjects];
        for(NSDictionary *dicList in tagsList)
        {
            ServiceTag *aTag = [[ServiceTag alloc] init];
            aTag._tag_id = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"id"]];
            aTag._tag_name = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"name"]];
            aTag._tag_type = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"type"]];
            aTag._tag_picUrl = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"picUrl"]];
            [[BaseInfo shareBaseInfo]._ServiceShowTags_login addObject:aTag];
            [aTags addObject:aTag];
            [aTag release];
        }
        aUserLogin.tags = aTags;
        [aTags release];
    }
    
    if ([aUserLogin.tags count] == 0) {
		aUserLogin.tags = nil;
	}
    return aUserLogin;
}
@end

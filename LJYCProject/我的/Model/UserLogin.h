//
//  UserLogin.h
//  LJYCProject
//
//  Created by xiemengyue on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseInfo.h"

@interface UserLogin : NSObject
@property(nonatomic,retain)NSString *userID;
@property(nonatomic,retain)NSString *passWord;
@property(nonatomic,retain)NSString *_userName;
@property(nonatomic,retain)NSString *_telephone;
@property(nonatomic,retain)NSString *_userType;
@property (nonatomic, retain) NSString *_longitude;
@property (nonatomic, retain) NSString *_latitude;
@property(nonatomic,assign)BOOL showMapInfo;


@property(nonatomic,retain)NSArray *tags;
@property (nonatomic,retain) NSString * deviceToken;
+(UserLogin *)sharedUserInfo;
+(UserLogin*)GetUserLogin:(NSDictionary*)dic;
@end

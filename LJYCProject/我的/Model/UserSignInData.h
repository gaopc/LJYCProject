//
//  UserSignInData.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSignInData : NSObject
@property(nonatomic,retain)NSString *totalPage;
@property(nonatomic,retain)NSString *count;
@property(nonatomic,retain)NSString *integral;
@property(nonatomic,retain)NSString *level;

@property(nonatomic,retain)NSMutableArray *signIns;

+(UserSignInData*)getUserSignInData:(NSDictionary*)dic;
@end


@interface SignInInfo : NSObject
@property(nonatomic,retain)NSString *_shopId;
@property(nonatomic,retain)NSString *_shopName;
@property(nonatomic,retain)NSString *_time;
@property(nonatomic,retain)NSString *_star;
@end



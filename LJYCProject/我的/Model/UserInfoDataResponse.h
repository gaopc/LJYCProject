//
//  UserInfoDataResponse.h
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  UserInfo;
@interface UserInfoDataResponse : NSObject
@property (nonatomic,retain) UserInfo * _userInfo; //
+ (UserInfo *)userInfo:(NSDictionary *)dic;
@end


@interface UserInfo : NSObject

@property (nonatomic,retain)NSString * _integral; //  int积分
@property (nonatomic,retain)NSString * _lcdCurrency; //int可用币总数
@property (nonatomic,retain)NSString * _level; //double等级
@property (nonatomic,retain)NSString * _commentCount; //int点评数
@property (nonatomic,retain)NSString * _signInCount; // int签到数
@property (nonatomic,retain)NSString * _pictureCount; // int照片数
@property (nonatomic,retain)NSString * _qACount; //int问答数
@property (nonatomic,retain)NSString * _telephone; //绑定手机号

@end
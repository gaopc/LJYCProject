//
//  ShopForSignInData.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-15.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopForSignInData : NSObject
@property(nonatomic,retain)NSString *_userName;
@property(nonatomic,retain)NSString *_time;

+ (NSMutableArray *)getShopSignInData:(NSDictionary *)dic;
@end

@interface ShopForSignData : NSObject
@property (nonatomic, retain) NSString *_totalPage;
@property (nonatomic, retain) NSString *_count;
@property (nonatomic, retain) NSMutableArray *_signDataArr;

+ (ShopForSignData *)setShopForSignData:(NSDictionary *)dic;
@end

//
//  ShopFindDataResponse.h
//  SystemArchitecture
//
//  Created by z1 on 13-10-21.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopFindProperty.h"
@interface ShopFindDataResponse : NSObject

@property (nonatomic,retain) NSString *totalPage;
@property (nonatomic,retain) NSString *count;
@property (nonatomic,retain) NSMutableArray *shops;

+ (ShopFindDataResponse *)findShop:(NSDictionary *)dic;

@end

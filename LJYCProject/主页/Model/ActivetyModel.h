//
//  ActivetyModel.h
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-21.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopFindProperty.h"

@interface ActivetyItem : NSObject
@property (nonatomic, retain) NSString *_picUrl;
@property (nonatomic, retain) NSString *_activetyId;
@property (nonatomic, retain) NSString *_url;
@property (nonatomic, retain) NSString *_latitude;
@property (nonatomic, retain) NSString *_longitude;
@property (nonatomic, retain) NSString *_distance;
@property (nonatomic, retain) NSString *_title;

@property (nonatomic,retain) NSMutableArray *_shops;

+(ActivetyItem *) ActivetyItemWithDic:(NSDictionary *)dic;
+ (NSMutableArray *)getShopsArrayWithDic:(NSDictionary *)dic;
-(void)getShopsWithDic:(NSDictionary *)dic;
@end

@interface ActivetyModel : NSObject
@property (nonatomic, retain) NSMutableArray *_topList;
@property (nonatomic, retain) NSMutableArray *_hotList;

+(ActivetyModel *) ActivetyModelWithDic:(NSDictionary *)dic;

@end

//
//  ServiceTag.h
//  LJYCProject
//
//  Created by z1 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShopType;
@interface ServiceTag : NSObject
@property (nonatomic,retain)NSString * _tag_id;
@property (nonatomic,retain)NSString * _tag_name;
@property (nonatomic,retain)NSString * _tag_type;
@property (nonatomic,retain)NSString * _tag_picUrl;
@property (nonatomic,retain)NSString * _tag_defaultNum;
@property (nonatomic,retain)NSString * _tag_index;


+(ServiceTag *) serviceTagFromElem:(NSArray *)array;
+(ShopType *) shopTypeFromElem:(NSArray *)array;
+ (ServiceTag *)serviceNewTagFromElem:(NSArray *)array;

@end

@interface ShopType : NSObject
@property (nonatomic,retain)NSString * _Type_id;
@property (nonatomic,retain)NSString * _Type_name;
@property (nonatomic,retain)NSString * _Type_picUrl;
@property (nonatomic,retain)NSString * _Type_defaultNum;
@property (nonatomic,retain)NSString * _Type_index;

+(ShopType *)ShopTypeFromElem:(NSArray *)array;


@end
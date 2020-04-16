//
//  GetBasicInfoFromServer.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseInfo.h"

@protocol CityListDelegate <NSObject>
@optional
- (void)didCityInfoResult:(NSArray *)cityArray;
- (void)didBasicInfoResult:(NSDictionary *)dic;
@end


@interface GetBasicInfoFromServer : NSObject
{
    BOOL needDownServiceTags;
}
@property (nonatomic,assign) id delegate;
@property (nonatomic, assign) id <CityListDelegate>cityDelegate;
@property (nonatomic,retain) NSDictionary *configerDic;

-(void) getConfiguration;

- (void)getCity;
- (void)getCountry;
- (void)getServiceTag;
- (void)getShopType;

@end

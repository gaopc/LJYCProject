//
//  WelecomViewContrller.h
//  FlightProject
//
//  Created by longcd on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBasicInfoFromServer.h"
#import "VersionView.h"


@protocol WelecomViewContrllerDelegate <NSObject>

-(void) showShopType;

@end

@interface WelecomViewContrller : RootViewController<CityListDelegate,UIActionSheetDelegate,UIAlertViewDelegate,VersionViewDelegate>
{
    UIActivityIndicatorView * activityIV;
    
}

@property (nonatomic,retain)GetBasicInfoFromServer * basicInfo ;
@property (nonatomic,retain) UIImageView * _backgroundImage;
@property (nonatomic,assign) BOOL _hasFirstImages;
@property (nonatomic,assign) id delegate;
@end

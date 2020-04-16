//
//  ShopMapViewController.h
//  LJYCProject
//
//  Created by z1 on 13-11-8.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduMKMapView.h"
#import "ShopFindProperty.h"
#import "ShopForDataInfo.h"
@interface ShopMapViewController : RootViewController<BaiduMKMapViewShopDelegate>
{
    double gcj02_lat;
    double gcj02_lng;
}

@property (nonatomic,retain) BaiduMKMapView *bMKMapView;
@property (nonatomic, retain) Shops *shops;
@property (nonatomic, retain) NSMutableArray *mapArray;
@property (nonatomic, retain) UIBarButtonItem * rightBar;
@property (nonatomic, retain) UIButton* mapButton;
@property (nonatomic, retain) NSMutableArray *availableMaps;
@end

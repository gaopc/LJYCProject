//
//  ShopFindViewController.h
//  SystemArchitecture
//
//  Created by z1 on 13-10-23.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ShopFindProperty.h"
#import "OrderMenuView.h"
#import "TagMenuView.h"
#import "DistanceMenuView.h"
#import "TypeMenuView.h"
#import "ShopFindCell.h"
#import "CustomMKAnnotationView.h"
#import "CustomAnnotation.h"
#import "CustomAnnotationCell.h"
#import "BaiduMKMapView.h"

//#import "BMapKit.h"
@class ShopFindDataResponse;
#define SHOP_NUMBER_PAGE 10

@interface ShopFindViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,ShopFindDelegate,UIAlertViewDelegate,BaiduMKMapViewShopDelegate,OrderMenuDelegate,TypeMenuDelegate,DistancMenuDelegate,TagMenuDelegate,CityMenuViewDelegate>
{
	
	ShopFindDataResponse *shopFindDataResponse;
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL isSelectMap;
	BOOL reloading;
}

@property (nonatomic,retain) UIView *inputView;
@property (nonatomic,retain)UISubLabel * titleLabel;
@property (nonatomic,retain) NSString *titleName;
@property (nonatomic,retain) NSString *tagName;
@property (nonatomic,retain) BaiduMKMapView *bMKMapView;
@property (nonatomic,assign)  int pageIndex;
@property (nonatomic, retain) UIBarButtonItem * rightBar;
@property (nonatomic, retain) OrderMenuView *orderMenu;
@property (nonatomic, retain) TagMenuView *tagMenu;
@property (nonatomic, retain) TypeMenuView *typeMenu;
@property (nonatomic, retain) DistanceMenuView *distanceMenu;
@property (nonatomic, retain) CityMenuView *cityMenuView;
@property (nonatomic, retain) UITableView *h_tableView;
@property (nonatomic, retain) NSMutableArray *shopListArray;


@property (nonatomic, retain) Shops *shops;
@property (nonatomic, retain) ShopFindProperty *shopFindProperty;
@property (nonatomic,assign) BOOL isfromRecomend;
@property (nonatomic, retain) UIView *tempView;

@property (nonatomic, retain) UIView *listView;

@property (nonatomic,assign) BOOL isLastPage;
@property (nonatomic,assign) int totalPage;
@property (nonatomic,assign) int number;

@property (nonatomic, retain) UIButton* mapButton;
@property (nonatomic, retain) UIButton* listButton;


@property (nonatomic,assign)  BOOL arrow1;
@property (nonatomic,assign)  BOOL arrow2;
@property (nonatomic,assign)  BOOL arrow3;


@property (nonatomic, retain) UIImageView *arrowUp;
@property (nonatomic, retain) UIImageView *arrowDown;

@property (nonatomic, retain) UIButton* orderButton;
@property (nonatomic, retain) UIButton* distanceButton;
@property (nonatomic, retain) UIButton* serviceButton;
@property (nonatomic, retain) UIButton* typeButton;
@property (nonatomic, retain) UIImageView * serviceBView;
@property (nonatomic, retain) UIImageView * typeBView;
@property (nonatomic,retain) UISubLabel* orderLabel;
@property (nonatomic,retain) UISubLabel* serviceLabel;
@property (nonatomic,retain) UISubLabel* distanceLabel;

@property (nonatomic, retain) District* district;
@property (nonatomic, retain) NSString* selectCity;
@property (assign) id _delegate;


-(void) reloadTableViewDataSource;
-(void) doneLoadingTableViewData;
- (void)loadFitstDataSource;
//传递数据请求
-(void)mapClick:(id)sender;//点击地图按钮
-(void)isrefreshHeaderView;

@end

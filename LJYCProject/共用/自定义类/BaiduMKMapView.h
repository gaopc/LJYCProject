//
//  BaiduMKMapView.h
//  LJYCProject
//
//  Created by z1 on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BMapKit.h"
#import "CustomMKAnnotationView.h"
#import "CustomAnnotation.h"
#import "CustomAnnotationCell.h"

@protocol BaiduMKMapViewDelegate
@optional

- (void)infoClick:(NSArray*)info;
//- (void)addShopClick:(NSArray*)info;

@end

@protocol BaiduMKMapViewAddShopDelegate
@optional

//- (void)infoClick:(NSArray*)info;
- (void)addShopClick:(NSArray*)info;

@end

@protocol BaiduMKMapViewShopDelegate
@optional

- (void)showDetails:(UIButton *)sender;

@end

@interface BaiduMKMapView : UIView <BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKLocationServiceDelegate>
{
	BMKMapView *_mapView;
	BMKGeoCodeSearch* _geocodesearch;
    BMKLocationService* _locService;
	NSString *info;//详细地址
	NSString *province;//省份
	NSString *city;//城市
	NSString *title;
	BOOL flag;
	
	//CustomAnnotationCell *cell;
	//NSTimer *_timer;
	
}
@property (nonatomic, assign) id <BaiduMKMapViewAddShopDelegate> addshopdelegate;
@property (nonatomic, assign) id <BaiduMKMapViewDelegate> delegate;
@property (nonatomic, assign) id <BaiduMKMapViewShopDelegate> shopdelegate;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) int tag;
@property (nonatomic,assign) int times;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, assign) int pinTag;
@property (nonatomic, assign) int pinInfo;
@property (nonatomic, assign) BOOL isLoadView; //是否显示地图 TRUE 显示地图 FALSE 定位
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

@property (nonatomic, assign) float ptlatitude;
@property (nonatomic, assign) float ptlongitude;

//@property (nonatomic, retain) BMKSearch* search;
//@property (nonatomic, retain) BMKMapView* mapView;
@property (nonatomic, retain) NSArray *infoArray;
@property (nonatomic,retain)CustomMKAnnotationView* popMKAnnotation;


- (void)infoClick;
- (void)addShopClick;
-(void)viewWillAppear;
-(void)viewWillDisappear;
- (void)setAnnotation;

- (void)onClickDriveSearch;
- (void)onClickBaiduMap;
- (void)onClickIosaMap;

@end

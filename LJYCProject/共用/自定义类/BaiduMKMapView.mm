//
//  BaiduMKMapView.m
//  LJYCProject
//
//  Created by z1 on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "BaiduMKMapView.h"
#import "ShopFindProperty.h"
#import "CustomMKAnnotationView.h"
#import "CustomAnnotation.h"
#import "CustomAnnotationCell.h"
#import "BMKAnnotationView.h"
#import "BMKPinAnnotationView.h"
#import "BMKAnnotation.h"
#import "ShopForDataInfo.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
	
	CGFloat width = CGImageGetWidth(self.CGImage);
	CGFloat height = CGImageGetHeight(self.CGImage);
	
	CGSize rotatedSize;
	
	rotatedSize.width = width;
	rotatedSize.height = height;
	
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
@interface BaiduMKMapView ()
{
	CustomAnnotation* _popAnnotation;
	
}
@end

@implementation BaiduMKMapView
@synthesize tag,delegate,isLoadView,dataArray,popMKAnnotation,shopdelegate,pinTag,infoArray,addshopdelegate;
@synthesize latitude,longitude,ptlongitude,ptlatitude,pinInfo,flag,times,timer;
//@synthesize mapView = _mapView;

-(void)dealloc
{
	
	self.delegate = nil;
	self.dataArray = nil;
	if (_geocodesearch != nil) {
		[_geocodesearch release];
		_geocodesearch = nil;
	}
	if (_mapView) {
		[_mapView release];
		_mapView = nil;
	}
//    self.search.delegate = nil;
//    self.mapView.delegate = nil;
//    
//	self.mapView = nil;
//	self.search = nil;
	self.popMKAnnotation =nil;
	self.shopdelegate = nil;
	self.infoArray = nil;
	self.latitude = 0.0;
	self.longitude = 0.0;
	self.ptlatitude = 0.0;
	self.ptlongitude = 0.0;
	self.flag = FALSE;
	self.addshopdelegate = nil;
	self.timer = nil;
//	if (cell) {
//		[cell release];
//		cell = nil;
//	}
	
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width,  self.frame.size.height)];
        _mapView.zoomLevel = 13;
        [self addSubview:_mapView];
        
        _locService = [[BMKLocationService alloc]init];
        _geocodesearch = [[BMKGeoCodeSearch alloc]init];
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
            //由于IOS8中定位的授权机制改变 需要进行手动授权
            CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
            //获取授权认证
            [locationManager requestAlwaysAuthorization];
            [locationManager requestWhenInUseAuthorization];
        }
        
//		    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width,  self.frame.size.height)];
//		    _mapView.delegate = self; //
//		    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//		   _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//		    _mapView.showsUserLocation = YES;//显示定位图层
//		     _mapView.zoomLevel = 13;
//		    [self addSubview:_mapView];
        


	    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
	    
	    if (_locService.userLocation.location != nil)
	    {
		    pt = (CLLocationCoordinate2D){_locService.userLocation.location.coordinate.latitude, _locService.userLocation.location.coordinate.longitude};
		    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(pt, BMKCoordinateSpanMake(0.02f,0.02f));
		    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
		    [_mapView setRegion:adjustedRegion animated:YES];
	    }
	    
    }
    return self;
}


-(void)viewWillAppear {
	[_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self;
    _locService.delegate = self;
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
	self.times= 5;
	
}

-(void)viewWillDisappear {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
    _locService.delegate = nil;
	
}

#pragma mark - 定位
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    info = @"北京市";
    city = @"北京市";
    province = @"北京";
    switch (self.tag) {
        case 1:
            [self infoClick];
            break;
        case 2:
            [self addShopClick];
            break;
        default:
            break;
    }
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];//39.9870071  116.42984
    
    
	if (userLocation != nil)
	{
		//反向解析地理位置
        
        self.latitude = userLocation.location.coordinate.latitude;
        self.longitude = userLocation.location.coordinate.longitude;
		        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        pt = (CLLocationCoordinate2D){self.latitude, self.longitude};
        
        if (!self.isLoadView && self.latitude) {
            _mapView.showsUserLocation = NO;
            
            _geocodesearch.delegate = self;
            BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
            reverseGeocodeSearchOption.reverseGeoPoint = pt;
            BOOL success = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
            [reverseGeocodeSearchOption release];
            
            if(success)
            {
                NSLog(@"反geo检索发送成功");
                [_locService stopUserLocationService];
                if ([self.timer isValid]) {
                    [self.timer invalidate];
                    self.timer = nil;
                }
            }
            else
            {
                NSLog(@"反geo检索发送失败");
                [self startTimer];
            }
        }
        else {
            _mapView.showsUserLocation = YES;
            [_locService stopUserLocationService];
        }
	}
}

//-(void)reverseGeocode:(BMKUserLocation *)userLocation
//{
//    
//    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
//    if (userLocation.location != nil) {
//        pt = (CLLocationCoordinate2D){(float)userLocation.location.coordinate.latitude, (float)userLocation.location.coordinate.longitude};
//    }
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;
//    BOOL success = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
//    [reverseGeocodeSearchOption release];
//    if(success)
//    {
//        NSLog(@"反geo检索发送成功");
//        [_locService stopUserLocationService];
//        if ([self.timer isValid]) {
//            [self.timer invalidate];
//            self.timer = nil;
//        }
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//        [_locService stopUserLocationService];
//        [self startTimer];
//    }
//}

//启动定时器
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(onTimer) userInfo:nil repeats:NO] ;
}

//执行自定义逻辑
- (void)onTimer
{
	_mapView.showsUserLocation = YES;
	
	self.times--;
	if (self.times <=0) {
		_mapView.showsUserLocation = NO;
        [_locService stopUserLocationService];
		info = @"北京市";
		city = @"北京市";
		province = @"北京";
		if (self.tag ==1 )
            [self infoClick];
		[self.timer invalidate];
	}
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
	if (error == 0) {
		//NSLog(@"完整的位置信息:%@\n街道号:%@\n街道名称:%@\n区域:%@\n城市:%@\n省份:%@",result.strAddr,result.addressComponent.streetNumber,result.addressComponent.streetName,result.addressComponent.district,result.addressComponent.city,result.addressComponent.province);
        
        info = [NSString stringWithFormat:@"%@%@%@", result.addressDetail.district, result.addressDetail.streetName, result.addressDetail.streetNumber];
		city = result.addressDetail.city;
		province = result.addressDetail.district;
		
		switch (self.tag) {
			case 1:
				[self infoClick];
				break;
			case 2:
				[self addShopClick];
				break;
			default:
				break;
		}
		self.tag = 0;
	}
}

- (void)setAnnotation
{
	CLLocationCoordinate2D center;
	
	double subLongitude = 0;
	double subLatitude = 0;
	
	double _latitude = 0;
	double _longitude = 0;
	
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
	if (annotationView) {
		annotationView = nil;
	}
	for (int i = 0; i < self.dataArray.count; i++)
	{
		if (self.pinInfo == 1){
			ShopForDataInfo * detailData = [self.dataArray objectAtIndex:i];
			center.longitude = [detailData._longitude doubleValue];
			center.latitude = [detailData._latitude doubleValue];
			_latitude = [detailData._latitude doubleValue];
			_longitude = [detailData._longitude doubleValue];
			self.ptlatitude = _latitude;
			self.ptlongitude = _longitude;
			title = detailData._address;
			

		}else{
			Shops *shop = [self.dataArray objectAtIndex:i];
			center.longitude = [shop._longitude doubleValue];
			center.latitude = [shop._latitude doubleValue];
			_latitude = [shop._latitude doubleValue];
			_longitude = [shop._longitude doubleValue];
			title = shop._name;
		}
		
		
		CustomAnnotation* item = [[[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(_latitude, _longitude)] autorelease];
		item.title = title;
		item.tag = i;
		[_mapView addAnnotation:item];
		
		subLongitude += center.longitude;
		subLatitude += center.latitude;
	}
	
    if  (self.latitude != 0 && self.longitude != 0) {
        CLLocationCoordinate2D centerOff = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        BMKCoordinateSpan span = BMKCoordinateSpanMake(0.2, 0.2);
        
        BMKCoordinateRegion regin = BMKCoordinateRegionMake(centerOff, span);
        [_mapView setRegion:[_mapView regionThatFits:regin] animated:YES];
    }
    else if (self.dataArray.count == 1)
    {
        CLLocationCoordinate2D centerOff = CLLocationCoordinate2DMake(_latitude, _longitude);
        BMKCoordinateSpan span = BMKCoordinateSpanMake(0.5, 0.5);
        
        BMKCoordinateRegion regin = BMKCoordinateRegionMake(centerOff, span);
        [_mapView setRegion:[_mapView regionThatFits:regin] animated:YES];
    }
}


- (BMKAnnotationView *)mapView:(BMKMapView *)amapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
	
	if (self.pinInfo == 1) {
		
		if ([annotation isKindOfClass:[RouteAnnotation class]]) {
			return [self getRouteAnnotationView:amapView viewForAnnotation:(RouteAnnotation*)annotation];
		}
		
		static NSString *AnnotationViewID = @"annotationViewID";
		BMKAnnotationView *pinView = (BMKAnnotationView *)[amapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
		if (pinView == nil) {
			pinView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title] autorelease];
		}
		else {
			pinView.annotation = annotation;
		}
		pinView.image = [UIImage imageNamed:@"地图定位标.png"];
		pinView.selected = YES;
		pinView.canShowCallout  = TRUE;
		return pinView;

	}
	CustomAnnotation *senderAnnotation = (CustomAnnotation *)annotation;
	
	if (senderAnnotation.type == 1 ){
//		NSString *popReusableIdentifier =@"customMKAnnotation";
//		CustomMKAnnotationView *annotationView = (CustomMKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:popReusableIdentifier];
//		
		CustomMKAnnotationView *annotationView = (CustomMKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
		if (annotationView == nil){
			annotationView = [[[CustomMKAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 293, 98) Annotation:annotation reuseIdentifier:@"CalloutView"] autorelease];
			//annotationView = [[[CustomMKAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 293, 98) Annotation:annotation reuseIdentifier:popReusableIdentifier] autorelease];
//			CustomAnnotationCell  *cell = [[CustomAnnotationCell alloc] initWithFrame:CGRectMake(0, 0, 293, 98-15)];
//			[annotationView.contentView addSubview:cell];

		}
		Shops *shops =  [self.dataArray objectAtIndex:self.pinTag];
		annotationView.cell.tag = self.pinTag;
		annotationView.cell.titleLabel.text = shops._name;
		[annotationView.cell.imgeView setUrlString:shops._picUrl];
		[annotationView.cell drawStarCodeView:[shops._star floatValue]];
		
		annotationView.cell.shopButton = [UIButton buttonWithType:UIButtonTypeCustom tag:self.pinTag title:@"" frame:CGRectMake(225.0f, 10.0f,  50.0f,  65.0f) backImage:nil target:self action:@selector(showDetails:)];
		annotationView.cell.shopButton.backgroundColor = [UIColor clearColor];
		[annotationView.cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(245.0f, 30.0f,  15.5f,  25.0f) image:[UIImage imageNamed:@"MapArrow.png"]]];
		[annotationView.cell addSubview:annotationView.cell.shopButton];
		//[annotationView.contentView addSubview:cell];
		annotationView.cell.userInteractionEnabled = YES;
		return annotationView;
	} else {
		
		BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
		if (annotationView==nil) {
			annotationView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation
								       reuseIdentifier:@"CustomAnnotation"] autorelease];
			annotationView.canShowCallout = NO;//始发弹出气泡
			annotationView.animatesDrop = YES; //动画效果
			annotationView.draggable = NO; //大头针是否移动
			annotationView.image = [UIImage imageNamed:@"地图定位标.png"];
		}
		
		return annotationView;
	}

	
	
//	BMKAnnotationView *result = nil;
//	if ([annotation isKindOfClass:[CustomAnnotation class]] == NO){
//		return result;
//	}
//	if ([amapView isEqual:_mapView] == NO){
//		
//		return result;
//		
//	}
//	CustomAnnotation *senderAnnotation = (CustomAnnotation *)annotation;
//	if (senderAnnotation.type == 0 ) {
//		NSString *pinReusableIdentifier =
//		
//		[CustomAnnotation reusableIdentifierforPinColor:senderAnnotation.pinColor];
//		
//		BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
//		if (annotationView == nil){
//			annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinReusableIdentifier];
//			[annotationView setCanShowCallout:NO];
//			annotationView.draggable = NO;
//			//annotationView.enabled = YES;
//		}
//		
//		annotationView.pinColor = senderAnnotation.pinColor;
//		
//		//自定义图片时，不能用drop
//		annotationView.animatesDrop = YES;
//		annotationView.image = [UIImage imageNamed:@"地图定位标.png"];
//		result = annotationView;
//		
//	} else {//popView
//		
//		
//		NSString *popReusableIdentifier =@"customMKAnnotation";
//		CustomMKAnnotationView *annotationView = (CustomMKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:popReusableIdentifier];
//		
//		if (annotationView == nil){
//			[annotationView.contentView removeFromSuperview];
//			annotationView = [[CustomMKAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 293, 98) Annotation:annotation reuseIdentifier:popReusableIdentifier];
//		}
//		if (cell) {
//			[cell removeFromSuperview];
//		}
//		
//		cell = [[CustomAnnotationCell alloc] initWithFrame:CGRectMake(0, 0, annotationView.frame.size.width, annotationView.frame.size.height - 15)];
//		
//		Shops *shops =  [self.dataArray objectAtIndex:self.pinTag];
//	
//		
//		cell.tag = self.pinTag;
//		cell.titleLabel.text = shops._name;
//		[cell.imgeView setUrlString:shops._picUrl];
//		[cell drawStarCodeView:[shops._star intValue]];
//		
//		cell.shopButton = [UIButton buttonWithType:UIButtonTypeCustom tag:self.pinTag title:@"" frame:CGRectMake(225.0f, 10.0f,  50.0f,  65.0f) backImage:nil target:self action:@selector(showDetails:)];
//		cell.shopButton.backgroundColor = [UIColor clearColor];
//		[cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(245.0f, 30.0f,  15.5f,  25.0f) image:[UIImage imageNamed:@"MapArrow.png"]]];
//		[cell addSubview:cell.shopButton];
//		[annotationView.contentView addSubview:cell];
//		cell.userInteractionEnabled = YES;
//		
//		result = annotationView;
//		
//		
//	}
	
	return nil;
}

#pragma mark --

#pragma mark --mapView delegate

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
	
	if (self.pinInfo == 1) return;
		
	
	if ([view.annotation isKindOfClass:[CustomAnnotation class]]) {
		CustomAnnotation* annotation = view.annotation;
		self.pinTag = annotation.tag;
		if (annotation.type == 0){
			if (_popAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
			    _popAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
				return;
			}
			if (_popAnnotation) {
				[mapView removeAnnotation:_popAnnotation];
				_popAnnotation = nil;
				
			}
			_popAnnotation =  [[[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(view.annotation.coordinate.latitude,view.annotation.coordinate.longitude)] autorelease];
			_popAnnotation.type = 1;
			[mapView addAnnotation:_popAnnotation];
			
			[mapView setCenterCoordinate:_popAnnotation.coordinate animated:YES];
			_mapView.showsUserLocation = NO;

		}
		
		
		
	}
//	else if ([view isKindOfClass:[CustomMKAnnotationView class]]){
//		
//		
//		
//		
//		
//	}
	
}

- (void)mapView:(BMKMapView *)amapView didDeselectAnnotationView:(BMKAnnotationView *)view
{

	if (self.pinInfo == 1) return;
	
	if (_popAnnotation && ![view isKindOfClass:[CustomMKAnnotationView class]]) {
		if (_popAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
		    _popAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
			[_mapView removeAnnotation:_popAnnotation];
			_popAnnotation = nil;
		}
	}
	
//	if ([view isKindOfClass:[CustomMKAnnotationView class]]) {
//		
//		if (_popAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
//		   _popAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
//			[_mapView removeAnnotation:_popAnnotation];
//			_popAnnotation = nil;
//			
//		}
//		
//	}
//	else if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
//		
//		if (_popAnnotation &&  _popAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
//		    _popAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
//			[_mapView removeAnnotation:_popAnnotation];
//			_popAnnotation = nil;
//		}
//		
//	}
	_mapView.showsUserLocation = YES;
}


- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	_mapView.showsUserLocation = NO;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"] autorelease];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
		case 5:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"] autorelease];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
		}
			break;
		default:
			break;
	}
	
	return view;
}

//- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
//		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
//	}
//	return nil;
//}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
		BMKPolylineView* polylineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
		polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
		polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
		polylineView.lineWidth = 3.0;
		return polylineView;
	}
	return nil;
}



//- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error
//{
//	if (result != nil) {
//		NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//		[_mapView removeAnnotations:array];
//		array = [NSArray arrayWithArray:_mapView.overlays];
//		[_mapView removeOverlays:array];
//		
//		// error 值的意义请参考BMKErrorCode
//		if (error == BMKErrorOk) {
//			BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
//			
//			// 添加起点
//			RouteAnnotation* item = [[RouteAnnotation alloc]init];
//			item.coordinate = result.startNode.pt;
//			item.title = @"我的位置";
//			item.type = 0;
//			[_mapView addAnnotation:item];
//			[item release];
//			
//			
//			// 下面开始计算路线，并添加驾车提示点
//			int index = 0;
//			int size = [plan.routes count];
//			for (int i = 0; i < 1; i++) {
//				BMKRoute* route = [plan.routes objectAtIndex:i];
//				for (int j = 0; j < route.pointsCount; j++) {
//					int len = [route getPointsNum:j];
//					index += len;
//				}
//			}
//			
//			BMKMapPoint* points = new BMKMapPoint[index];
//			index = 0;
//			for (int i = 0; i < 1; i++) {
//				BMKRoute* route = [plan.routes objectAtIndex:i];
//				for (int j = 0; j < route.pointsCount; j++) {
//					int len = [route getPointsNum:j];
//					BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
//					memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
//					index += len;
//				}
//				size = route.steps.count;
//				for (int j = 0; j < size; j++) {
//					// 添加驾车关键点
//					BMKStep* step = [route.steps objectAtIndex:j];
//					item = [[RouteAnnotation alloc]init];
//					item.coordinate = step.pt;
//					item.title = step.content;
//					item.degree = step.degree * 30;
//					item.type = 4;
//					[_mapView addAnnotation:item];
//					[item release];
//				}
//				
//			}
//			
//			// 添加终点
//			item = [[RouteAnnotation alloc]init];
//			item.coordinate = result.endNode.pt;
//			item.type = 1;
//			item.title = title;
//			[_mapView addAnnotation:item];
//			[item release];
//			
//			// 添加途经点
//			if (result.wayNodes) {
//				for (BMKPlanNode* tempNode in result.wayNodes) {
//					item = [[RouteAnnotation alloc]init];
//					item.coordinate = tempNode.pt;
//					item.type = 5;
//					item.title = tempNode.name;
//					[_mapView addAnnotation:item];
//					[item release];
//				}
//			}
//			
//			// 根究计算的点，构造并添加路线覆盖物
//			BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
//			[_mapView addOverlay:polyLine];
//			delete []points;
//			
//			[_mapView setCenterCoordinate:result.startNode.pt animated:YES];
//		}
//	}
//}


- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

- (void)infoClick
{
	//_mapView.userLocation.coordinate.latitude,_mapView.userLocation.coordinate.longitude
	NSString *_lat = @"";
	NSString *_lon = @"";
	if (self.latitude>0 && self.longitude>0) {
		_lat = [NSString stringWithFormat:@"%f",self.latitude];
		_lon = [NSString stringWithFormat:@"%f",self.longitude];
	}
	self.infoArray = [NSArray arrayWithObjects:_lat,_lon,info,province,city,nil];
	if (self.delegate && ![UserLogin sharedUserInfo].showMapInfo)
	{
		[self.delegate infoClick:self.infoArray];
	}
}


- (void)addShopClick
{
	self.infoArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.latitude],[NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.longitude],info,province,city,nil];
	if (self.addshopdelegate)
	{
		[self.addshopdelegate addShopClick:self.infoArray];
	}
}

- (void)showDetails:(UIButton *)sender
{
	if (self.shopdelegate)
	{
		[self.shopdelegate showDetails:sender];
	}
}

- (void)onClickIosaMap
{
    CLLocationCoordinate2D coor2;
    coor2.latitude = self.ptlatitude;
    coor2.longitude = self.ptlongitude;
    
    NSLog(@"农家乐位置2：%f, %f", coor2.latitude, coor2.longitude);
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coor2 addressDictionary:nil];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
    toLocation.name = title;
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

- (void)onClickBaiduMap
{
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //指定导航类型
    para.naviType = BMK_NAVI_TYPE_NATIVE;

    //初始化终点节点
    BMKPlanNode* end = [[[BMKPlanNode alloc]init] autorelease];
    //指定终点经纬度
    CLLocationCoordinate2D coor2;
    coor2.latitude = self.ptlatitude;
    coor2.longitude = self.ptlongitude;
    end.pt = coor2;
    //指定终点名称
    end.name = title;
    //指定终点
    para.endPoint = end;

    //指定返回自定义scheme
    para.appScheme = @"baidumapsdk://mapsdk.baidu.com";

    //调启百度地图客户端导航
    [BMKNavigation openBaiduMapNavigation:para];
    [para release];
}

-(void)onClickDriveSearch
{
    CLLocationCoordinate2D coor2;
    coor2.latitude = self.ptlatitude;
    coor2.longitude = self.ptlongitude;
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coor2 addressDictionary:nil];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
    toLocation.name = title;
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}
@end

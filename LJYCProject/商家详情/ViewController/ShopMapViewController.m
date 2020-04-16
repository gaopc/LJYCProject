//
//  ShopMapViewController.m
//  LJYCProject
//
//  Created by z1 on 13-11-8.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopMapViewController.h"
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ShopMapViewController ()

@end

@implementation ShopMapViewController
@synthesize bMKMapView,shops,mapArray,rightBar,mapButton;
@synthesize availableMaps;

-(void)viewWillAppear:(BOOL)animated {
	//[super viewWillAppear:animated];
	[self.bMKMapView viewWillAppear];
	
	
}

-(void)viewWillDisappear:(BOOL)animated {
	//[super viewWillDisappear:animated];
	[self.bMKMapView viewWillDisappear];
}


- (void) dealloc {
	
	//self.bMKMapView = nil;
	//self.bMKMapView.mapView = nil;
	self.mapButton = nil;
	self.rightBar = nil;
	self.shops = nil;
	self.mapArray = nil;
    [availableMaps release];
	[super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.availableMaps = [[NSMutableArray alloc] init];
	
	self.mapButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(onClick) title:@"导航"];
	self.mapButton.tag = 100;
	
	self.rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.mapButton];
	self.navigationItem.rightBarButtonItem = self.rightBar;
	
	
		
	self.bMKMapView = [[[BaiduMKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, ViewHeight-44)] autorelease];
	self.bMKMapView.dataArray = self.mapArray;
        self.bMKMapView.isLoadView = TRUE;
	self.bMKMapView.pinInfo = 1;

	[self.view_IOS7 addSubview:self.bMKMapView];
	
	[self.bMKMapView setAnnotation];
	
	// Do any additional setup after loading the view.
}

-(void)onClick
{
	if(![CLLocationManager locationServicesEnabled])
	{
		[UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
		
	}else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied  ||  [CLLocationManager authorizationStatus] ==  kCLAuthorizationStatusRestricted ) {
		
		[UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
	}else
	{
//		[self.bMKMapView onClickDriveSearch];
        
//        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"导航选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度地图导航", @"高德地图导航", @"手机自带地图导航", nil];
//        actionSheet.tag = 0;
//        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//        [actionSheet showInView:self.view];
//        [actionSheet release];
    
        [self availableMapsApps];
        if (self.availableMaps.count == 0) {
            [self selectIosMap];
        }
        else {
            UIActionSheet *action = [[UIActionSheet alloc] init];
            
            [action addButtonWithTitle:@"使用手机自带地图导航"];
            for (NSDictionary *dic in self.availableMaps) {
                [action addButtonWithTitle:[NSString stringWithFormat:@"使用%@导航", dic[@"name"]]];
            }
            [action addButtonWithTitle:@"取消"];
            action.cancelButtonIndex = self.availableMaps.count + 1;
            action.delegate = self;
            [action showInView:self.view];
            [action release];
        }
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self selectIosMap];
    }else if (buttonIndex < self.availableMaps.count+1) {
        NSDictionary *mapDic = self.availableMaps[buttonIndex-1];
        NSString *urlString = mapDic[@"url"];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)availableMapsApps {
    [self.availableMaps removeAllObjects];
    
    ShopForDataInfo * detailData = [self.mapArray objectAtIndex:0];
    float shopLongitude = [detailData._longitude doubleValue];
    float shopLatitude = [detailData._latitude doubleValue];
    NSString *shopName = detailData._address;
    
    [self convert_BD09_To_GCJ02:shopLongitude :shopLatitude];
    
    CLLocationCoordinate2D startCoor;
    startCoor.latitude = shopLatitude;
    startCoor.longitude = shopLongitude;
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(startCoor.latitude, startCoor.longitude);
    
    CLLocationCoordinate2D startCoor_google;
    startCoor_google.latitude = gcj02_lng;
    startCoor_google.longitude = gcj02_lat;
    CLLocationCoordinate2D endCoor_google = CLLocationCoordinate2DMake(startCoor_google.latitude, startCoor_google.longitude);
    
    NSString *toName = shopName;
    NSLog(@"农家乐位置0：%f, %f", endCoor.latitude, endCoor.longitude);
    NSLog(@"农家乐位置1：%f, %f", endCoor_google.latitude, endCoor_google.longitude);
//    baidumap://map/direction?origin=中关村&destination=五道口&mode=driving&region=北京
//    baidumap://map/marker?location=40.047669,116.313082&title=我的位置&content=百度奎科大厦&src=yourCompanyName|yourAppName
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=transit",
                               startCoor.latitude, startCoor.longitude, endCoor.latitude, endCoor.longitude, toName];
        
        NSDictionary *dic = @{@"name": @"百度地图",
                              @"url": urlString};
        [self.availableMaps addObject:dic];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",
                               @"云华时代", endCoor_google.latitude, endCoor_google.longitude];
        
        NSDictionary *dic = @{@"name": @"高德地图",
                              @"url": urlString};
        [self.availableMaps addObject:dic];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%f,%f¢er=%f,%f&directionsmode=transit", endCoor_google.latitude, endCoor_google.longitude, startCoor_google.latitude, startCoor_google.longitude];
        
        NSDictionary *dic = @{@"name": @"Google Maps",
                              @"url": urlString};
        [self.availableMaps addObject:dic];
    }
}

- (void)selectIosMap
{
    ShopForDataInfo * detailData = [self.mapArray objectAtIndex:0];
    double shopLongitude = [detailData._longitude doubleValue];
    double shopLatitude = [detailData._latitude doubleValue];
    NSString *shopName = detailData._address;
    
    [self convert_BD09_To_GCJ02:shopLongitude :shopLatitude];
    
    CLLocationCoordinate2D startCoor;
//    startCoor.latitude = shopLatitude;
//    startCoor.longitude = shopLongitude;
    startCoor.latitude = gcj02_lng;
    startCoor.longitude = gcj02_lat;
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(startCoor.latitude, startCoor.longitude);
    NSString *toName = shopName;
    
    NSLog(@"农家乐位置1：%f, %f", endCoor.latitude, endCoor.longitude);
    
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) { // ios6以下，调用google map
        
        NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude];
        urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *aURL = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:aURL];
    } else{// 直接调用ios自己带的apple map
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
        toLocation.name = toName;
        
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }
}

/// 百度地图对应的 BD09 协议坐标，转到 中国正常坐标系GCJ02协议的坐标
//public static void Convert_BD09_To_GCJ02(ref double lat, ref double lng)
//{
//    double x = lng - 0.0065, y = lat - 0.006;
//    double z = Math.Sqrt(x * x + y * y) - 0.00002 * Math.Sin(y * x_pi);
//    double theta = Math.Atan2(y, x) - 0.000003 * Math.Cos(x * x_pi);
//    lng = z * Math.Cos(theta);
//    lat = z * Math.Sin(theta);
//}

- (void)convert_BD09_To_GCJ02:(double)lat :(double)lng
{
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = lng - 0.0065, y = lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    gcj02_lng = z * cos(theta);
    gcj02_lat = z * sin(theta);
}
@end

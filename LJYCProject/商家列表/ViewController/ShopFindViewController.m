//
//  ShopFindViewController.m
//  SystemArchitecture
//
//  Created by z1 on 13-10-23.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopFindViewController.h"

#import "InterfaceClass.h"
#import "ASIFormDataRequest.h"
#import "ShopFindDataResponse.h"
#import "CustomAnnotation.h"
#import "ShopForDetailsViewController.h"
#import "DataClass.h"
#import "ShopForDataInfo.h"
#import "MemberLoginViewController.h"

@interface ShopFindViewController ()

- (void)loadShopInfoSource;
- (void)loadDataSource;
- (void)loadFitstDataSource;
- (void)loadShopFindProperty;

@end

@implementation ShopFindViewController


@synthesize h_tableView = _h_tableView;
@synthesize listView = _listView;
@synthesize shopFindProperty = _shopFindProperty;
@synthesize shops,shopListArray;
@synthesize isfromRecomend,tempView,totalPage,number,isLastPage;
@synthesize orderMenu,tagMenu,distanceMenu,typeMenu,cityMenuView,mapButton,listButton,rightBar;
@synthesize orderButton,distanceButton,serviceButton,typeButton;
@synthesize bMKMapView,arrowUp,arrowDown,titleName,titleLabel,tagName,serviceBView,typeBView;
@synthesize inputView,district,distanceLabel ,orderLabel ,serviceLabel,arrow1,arrow2,arrow3,pageIndex;
@synthesize selectCity, _delegate;

- (void) dealloc {
	
    self._delegate = nil;
	self.h_tableView = nil;
	
	self.h_tableView.delegate = nil;
	self.h_tableView.dataSource = nil;
	self.listView = nil;
	[_listView release];
	self.tempView = nil;
	self.shopListArray = nil;
	[_h_tableView release];
	self.district = nil;
	self.shops = nil;
	self.isfromRecomend = FALSE;
	self.rightBar = nil;
	self.mapButton = nil;
	self.orderButton = nil;
	self.distanceButton = nil;
	self.serviceButton = nil;
	self.listButton = nil;
	self.orderMenu =nil;
	self.tagMenu=nil;
	self.distanceMenu=nil;
	self.typeButton = nil;
	self.arrowDown = nil;
	self.arrowUp = nil;
	self.titleName = nil;
	self.typeMenu = nil;
	self.cityMenuView = nil;
	self.inputView = nil;
	self.distanceLabel = nil;
	self.orderLabel = nil;
	self.serviceLabel =nil;
	self.tagName = nil;
	self.serviceBView =nil;
	self.typeBView = nil;
    self.selectCity = nil;
	[super dealloc];
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.bMKMapView viewWillAppear];
	if (isSelectMap) {
		[self.bMKMapView setAnnotation];
	}

	self.serviceLabel.text = self.tagName;
	self.titleLabel.text = self.titleName;
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self loadShopFindProperty];
	
    [self.bMKMapView viewWillDisappear];
}


- (void) loadShopFindProperty
{
	if (self.shopFindProperty) {
		self.shopFindProperty._type =@"";
		self.shopFindProperty._orderBy =@"0";
		self.shopFindProperty._serviceTagId = @"";
		self.shopFindProperty._distance = @"0";
		self.shopFindProperty._pageIndex = @"1";
		self.shopFindProperty._keyword = @"";
		self.shopFindProperty._filter = @"0";

	}
}

- (void)loadView{
	
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.mapButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(mapClick:) title:@"地图"];
	self.mapButton.tag = 100;
	//[UIButton buttonWithType:UIButtonTypeRoundedRect tag:100 title:@"地图" frame:CGRectMake(260.0f, 16.0f, 60.0f,  40.0f) backImage:nil target:self action:@selector(mapClick:)];
	self.listButton =  [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(mapClick:) title:@"列表"];
        self.listButton.tag = 101;
	//[UIButton buttonWithType:UIButtonTypeRoundedRect tag:101 title:@"列表" frame:CGRectMake(260.0f, 16.0f,  60.0f,  40.0f) backImage:nil target:self action:@selector(mapClick:)];
	
	self.rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.mapButton];
	self.navigationItem.rightBarButtonItem = self.rightBar;
	
	
//	UIButton  * rightButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(goHome) title:@"登录"];
//	//[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"backHome.png"] target:self action:@selector(goHome)];
//	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//	self.navigationItem.rightBarButtonItem = rightBar;
//	[rightBar release];
	
	_listView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
	UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	headView.backgroundColor = [UIColor whiteColor];
	//星级
		
	self.orderButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(10, 7, 94, 25.5) backImage:[UIImage imageNamed:@"OButton.png"] target:self  action:@selector(order:)];
	//[self.orderButton setImage:[UIImage imageNamed:@"OButtonClick.png"] forState:UIControlStateHighlighted];
	[headView addSubview:self.orderButton];

	self.orderLabel  = [UISubLabel labelWithTitle:@"排序" frame:CGRectMake(20, 7, 94, 25.5) font:FontBlodSize20 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
	self.orderLabel.backgroundColor = [UIColor clearColor];
	[headView addSubview:self.orderLabel];
	
	self.arrow1 = YES;
	
	
	self.serviceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(113, 7, 94, 25.5) backImage:[UIImage imageNamed:@"OButton.png"] target:self   action:@selector(tag:)];
	[self.serviceButton setImage:[UIImage imageNamed:@"OButtonClick.png"] forState:UIControlStateHighlighted];
	[headView addSubview:self.serviceButton];
	
	self.serviceBView = [UIImageView ImageViewWithFrame:CGRectMake(113, 7, 94, 25.5) image:[UIImage imageNamed:@"OButtonA.png"]];
	self.serviceBView.hidden = YES;
	[headView addSubview:self.serviceBView];
	
	self.serviceLabel  = [UISubLabel labelWithTitle:@"" frame:CGRectMake(123, 7, 94, 25.5) font:FontBlodSize20 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
	self.serviceLabel.backgroundColor = [UIColor clearColor];
	self.serviceLabel.text = self.tagName;
	[headView addSubview:self.serviceLabel];
	
	
	
	self.arrow2 = YES;
	
	self.distanceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"" frame:CGRectMake(215, 7, 94, 25.5) backImage:[UIImage imageNamed:@"OButton.png"] target:self   action:@selector(dis:)];
	[self.distanceButton setImage:[UIImage imageNamed:@"OButtonClick.png"] forState:UIControlStateHighlighted];
	[headView addSubview:self.distanceButton];
	
	self.distanceLabel  = [UISubLabel labelWithTitle:@"距离" frame:CGRectMake(225, 7, 94, 25.5) font:FontBlodSize20 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
	self.distanceLabel.backgroundColor = [UIColor clearColor];
	[headView addSubview:self.distanceLabel];

	self.arrow3 = YES;
	
	[self.listView addSubview:headView];
	[headView release];
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,44.0f,ViewWidth,ViewHeight-86.0f) style:UITableViewStylePlain];
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
	self.h_tableView.separatorStyle = UITableViewCellAccessoryNone;
 
	[self.listView addSubview:self.h_tableView];
	
	self.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ViewWidth, ViewHeight)];
	self.inputView.backgroundColor = [UIColor blackColor];
	self.inputView.alpha = 0.5;
	self.inputView.hidden = YES;
	[self.listView addSubview:self.inputView];
	
	[self.inputView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(0.0f, 0.0f, self.inputView.frame.size.width, self.inputView.frame.size.height) backImage:nil target:self action:@selector(inputClick:)]];
	
	
	self.orderMenu = [[OrderMenuView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 130.0f)];
	self.orderMenu.backgroundColor = [UIColor whiteColor];
	self.orderMenu.delegate = self;
	self.orderMenu.hidden = YES;
	[self.listView addSubview:self.orderMenu];
	
	self.tagMenu = [[TagMenuView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 300.0f)];
	self.tagMenu.backgroundColor = [UIColor whiteColor];
	self.tagMenu.tagArray = [DataClass selectServiceTag];
	self.tagMenu.hidden = YES;
	self.tagMenu.delegate= self;
	[self.listView addSubview:self.tagMenu];
	
	if ( self.district !=nil || self.selectCity != nil) {
		
        if (self.selectCity) {
            self.distanceLabel.text = self.selectCity;
        }
        else {
            self.distanceLabel.text = self.district._name;
        }
		
		self.cityMenuView = [[CityMenuView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 240.0f)];
		self.cityMenuView.backgroundColor = [UIColor whiteColor];
		self.cityMenuView.hidden = YES;
		self.cityMenuView.delegate = self;
		[self.cityMenuView getMyCityDistrict:self.district._id];
		[self.listView addSubview:self.cityMenuView];
	}else{
		self.distanceMenu = [[DistanceMenuView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 115.0f)];
		self.distanceMenu.backgroundColor = [UIColor whiteColor];
		self.distanceMenu.hidden = YES;
		self.distanceMenu.delegate = self;
		[self.listView addSubview:self.distanceMenu];
	}
	
	
	
	
	[self isrefreshHeaderView];
	
	
	if (!self.bMKMapView) {
		self.bMKMapView = [[[BaiduMKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, ViewHeight-44)] autorelease];
		
	}
	self.bMKMapView.dataArray = self.shopListArray;

	self.bMKMapView.shopdelegate = self;
	self.bMKMapView.isLoadView = TRUE;
	self.tempView = self.listView;
	[self.view_IOS7 insertSubview:self.tempView atIndex:100];
	

	//[self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 42, ViewWidth-20, 0.5) image:[UIImage imageNamed:@"横向分割线.png"]]];
	
}



- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		if (_refreshHeaderView) {
			if(self.pageIndex == self.totalPage && self.totalPage != 1)
			self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
			[_refreshHeaderView removeFromSuperview];
			_refreshHeaderView = nil;
		}
		
	}
	else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[self.h_tableView addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//self.title =  @"全部商家";
		
	UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(105, 0, 119, 30.5)];//allocate titleView
	titleView.backgroundColor = [UIColor clearColor];

	self.typeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(0.0f, 0.0f, 119, 30.5) backImage:[UIImage imageNamed:@"TitleButtonBg.png"] target:self   action:@selector(type:)];
	[titleView addSubview:self.typeButton];
	
	self.arrowDown =  [UIImageView ImageViewWithFrame:CGRectMake(100.0f, 8.0f, 8.7f, 7.0f) image:[UIImage imageNamed:@"BlueArrowDown.png"]];
	self.arrowDown.hidden = NO;
	[titleView addSubview:self.arrowDown];
	
	self.arrowUp =  [UIImageView ImageViewWithFrame:CGRectMake(100.0f, 8.0f, 8.7f, 7.0f) image:[UIImage imageNamed:@"BlueArrowUp.png"]];
	self.arrowUp.hidden = YES;
	[titleView addSubview:self.arrowUp];
	
	self.typeBView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, 119, 30.5) image:[UIImage imageNamed:@"TitleButtonBg.png"]];
	self.typeBView.hidden = YES;
	[titleView addSubview:self.typeBView];
	
	if (![self.shopFindProperty._keyword isEqualToString:@""]) {
		self.serviceBView.hidden = NO;
		self.typeBView.hidden = NO;
		self.serviceButton.enabled = NO;
		self.typeButton.enabled = NO;
		
	}else{
		self.serviceBView.hidden = YES;
		self.typeBView.hidden = YES;
		self.serviceButton.enabled = YES;
		self.typeButton.enabled = YES;
	}
	
	self.titleLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0.0f, 0.0f, 100.0f, 25.0f) font:FontSize36 color:FontColor000000 alignment:NSTextAlignmentCenter];
	//title.text = @"全部商家";
	self.titleLabel.text = self.titleName;
	[titleView addSubview:self.titleLabel];
	
	
	
	
	
	self.navigationItem.titleView =titleView;
	[titleView release];
	
	

	UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 24, 19) backImage:[UIImage imageNamed:@"返回.png"] target:self action:@selector(backHome)];
	leftButton.tag = 101;
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
	self.navigationItem.leftBarButtonItem = leftBar;
	[leftBar release];
	
	ShopType *shopType = [[ShopType alloc] init];
	shopType._Type_id = @"";
	shopType._Type_name = @"全部商家";
	NSMutableArray *array = [NSMutableArray arrayWithArray:[DataClass selectShopType]];
	[array insertObject:shopType atIndex:0];
	[shopType release];
	
	self.typeMenu = [[TypeMenuView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 240.0f)];
	self.typeMenu.backgroundColor = [UIColor whiteColor];
	self.typeMenu.hidden = YES;
	self.typeMenu.typeArray = array;
	self.typeMenu.delegate = self;
	[self.listView addSubview:self.typeMenu];
	
	self.pageIndex = 1;
	
	if (!self.shopFindProperty) {
		
		self.shopFindProperty = [[ShopFindProperty alloc]init];
		self.shopFindProperty._type =@"";
		self.shopFindProperty._orderBy =@"0";
		self.shopFindProperty._serviceTagId = @"";
		self.shopFindProperty._distance = @"0";
		self.shopFindProperty._latitude = @"";
		self.shopFindProperty._longitude = @"";
		self.shopFindProperty._pageIndex = @"1";
		self.shopFindProperty._keyword = @"";
		self.shopFindProperty._filter = @"0";
		self.shopFindProperty._cityId = @"";
		self.shopFindProperty._districtId = @"";
	}
		

	//[self.h_tableView reloadData];
	[self loadFitstDataSource];
}

-(void)addShopClick:(NSArray*)infoArray
{}
-(void)inputClick:(UIButton *)sender
{
	self.inputView.hidden = YES;
	self.orderMenu.hidden = YES;
	
	[self.orderButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow1 = YES;
	
	self.typeMenu.hidden = YES;
	self.arrowDown.hidden = NO;
	self.arrowUp.hidden = YES;
	
	
	self.tagMenu.hidden = YES;
	[self.serviceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow2 = YES;

	self.cityMenuView.hidden = YES;
	self.distanceMenu.hidden = YES;
	[self.distanceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow3 = YES;


}

-(void)type:(UIButton *)sender
{
	
	self.orderMenu.hidden = YES;
	self.tagMenu.hidden = YES;
	self.distanceMenu.hidden = YES;
	self.cityMenuView.hidden = YES;
	
	self.arrow1  = YES;
	self.arrow2  = YES;
	self.arrow3  = YES;
	
	[self.orderButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	[self.distanceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	[self.serviceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];

	if (self.arrowUp.hidden) {
		
		self.typeMenu.hidden = NO;
		self.inputView.hidden = NO;
		self.typeMenu.alpha = 0.0;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.typeMenu.alpha = 1.0f;
		[UIView commitAnimations];
		
	
		
		self.arrowDown.hidden = YES;
		self.arrowUp.hidden = NO;
		
		
		
		
	}else {
		self.typeMenu.alpha = 1.0f;
		self.inputView.hidden = YES;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.typeMenu.alpha = 0.0;
		[UIView commitAnimations];
		self.typeMenu.hidden = NO;
		
		
		
		self.arrowDown.hidden = NO;
		self.arrowUp.hidden = YES;

		
	}
	
}

-(void)typeMenu:(ShopType*) type
{
	
	self.pageIndex = 1;
	titleLabel.text = type._Type_name;
	self.titleName = type._Type_name;
	self.shopFindProperty._pageIndex = [NSString stringWithFormat:@"%d",self.pageIndex];
	self.shopFindProperty._type = type._Type_id;
//	self.shopFindProperty._keyword = @"";
//	self.shopFindProperty._orderBy =@"0";
//	self.shopFindProperty._serviceTagId = @"";
//	self.shopFindProperty._distance = @"0";
	
	
	self.typeMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	self.typeMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.typeMenu.hidden = NO;
	
	self.inputView.hidden = YES;
	self.arrowDown.hidden = NO;
	self.arrowUp.hidden = YES;

	[self loadDataSource];
}


-(void) order:(UIButton *)sender
{

	
	self.tagMenu.hidden = YES;
	self.distanceMenu.hidden = YES;
	self.cityMenuView.hidden = YES;
	
	self.arrow2 = YES;
	[self.serviceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow3 = YES;
	[self.distanceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];

	if (self.arrow1) {
	
		self.inputView.hidden = NO;
		self.orderMenu.hidden = NO;
		
		self.orderMenu.alpha = 0.0;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.orderMenu.alpha = 1.0f;
		[UIView commitAnimations];
		
		[self.orderButton setImage:[UIImage imageNamed:@"OButtonClick.png"] forState:UIControlStateNormal];
		self.arrow1 = NO;

		
		
	}else {
		self.orderMenu.alpha = 1.0f;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.orderMenu.alpha = 0.0;
		[UIView commitAnimations];
		self.orderMenu.hidden = NO;
		[self.orderButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
		self.arrow1 = YES;
		self.inputView.hidden = YES;

	}
	
	
	
}


-(void)orderMenu:(int) orderBy
{
	self.pageIndex = 1;
	
	self.shopFindProperty._pageIndex = [NSString stringWithFormat:@"%d",self.pageIndex];
	self.shopFindProperty._orderBy = [NSString stringWithFormat:@"%d",orderBy];
//	self.shopFindProperty._type =@"";
//	self.shopFindProperty._keyword = @"";
//	self.shopFindProperty._serviceTagId = @"";
//	self.shopFindProperty._distance = @"0";
	self.orderMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	self.orderMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.orderMenu.hidden = NO;
	
	[self.orderButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
        self.arrow1 = YES;
	self.inputView.hidden = YES;
	
	[self loadDataSource];
}

-(void) tag:(UIButton *)sender
{
	
//	static BOOL tagDese = FALSE;
//	tagDese = !tagDese;
	
	[self.orderButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow1  = YES;
	[self.distanceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow3  = YES;
	//[self.serviceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.orderMenu.hidden = YES;
	self.distanceMenu.hidden = YES;
	self.cityMenuView.hidden = YES;
	if (self.arrow2) {
		
		self.tagMenu.hidden = NO;
		self.inputView.hidden = NO;
		self.tagMenu.alpha = 0.0;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.tagMenu.alpha = 1.0f;
		[UIView commitAnimations];
		[self.serviceButton setImage:[UIImage imageNamed:@"OButtonClick.png"] forState:UIControlStateNormal];
		self.arrow2 = NO;
		
		
	}else {
		self.tagMenu.alpha = 1.0f;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.tagMenu.alpha = 0.0;
		[UIView commitAnimations];
		self.tagMenu.hidden = NO;
		self.inputView.hidden = YES;
		[self.serviceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
		
		self.arrow2 = YES;
		
	}
	
	
	
}

-(void)tagMenu:(ServiceTag*) tag
{
	self.pageIndex = 1;
	self.shopFindProperty._pageIndex = [NSString stringWithFormat:@"%d",self.pageIndex];
	if (tag!=nil) {
		self.shopFindProperty._serviceTagId = tag._tag_id;
		self.serviceLabel.text = tag._tag_name;
		self.tagName = tag._tag_name;
	}else{
		self.shopFindProperty._serviceTagId = @"";
		self.serviceLabel.text = @"服务标签";
		self.tagName = @"服务标签";
	}
	
//	self.shopFindProperty._type =@"";
//	self.shopFindProperty._orderBy =@"0";
//	self.shopFindProperty._distance = @"0";
//	self.shopFindProperty._keyword = @"";
	
	self.tagMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	self.tagMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.tagMenu.hidden = NO;
	self.inputView.hidden = YES;
	[self.serviceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow2 = YES;
	
	
	
	[self loadDataSource];
}


-(void) dis:(UIButton *)sender
{
	
	[self.orderButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow1  = YES;
	[self.serviceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow2  = YES;
	self.orderMenu.hidden = YES;
	self.tagMenu.hidden = YES;
	if (self.arrow3) {
		if (self.district !=nil) {
			self.cityMenuView.hidden = NO;
		}else{
			self.distanceMenu.hidden = NO;
		}
		
		
		self.inputView.hidden = NO;
		if (self.district !=nil) {
			self.cityMenuView.alpha = 0.0;
		}else{
			self.distanceMenu.alpha = 0.0;
		}
		//self.distanceMenu.alpha = 0.0;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		if (self.district !=nil) {
			self.cityMenuView.alpha = 1.0;
		}else{
			self.distanceMenu.alpha = 1.0;
		}
		//self.distanceMenu.alpha = 1.0f;
		[UIView commitAnimations];
		[self.distanceButton setImage:[UIImage imageNamed:@"OButtonClick.png"] forState:UIControlStateNormal];
		self.arrow3 = NO;
		
				
	}else {
		if (self.district !=nil) {
			self.cityMenuView.alpha = 1.0;
		}else{
			self.distanceMenu.alpha = 1.0;
		}
		//self.distanceMenu.alpha = 1.0f;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		if (self.district !=nil) {
			self.cityMenuView.alpha = 0.0;
		}else{
			self.distanceMenu.alpha = 0.0;
		}
		//self.distanceMenu.alpha = 0.0;
		[UIView commitAnimations];
		self.cityMenuView.hidden = NO;
		self.distanceMenu.hidden = NO;
		self.inputView.hidden = YES;
		[self.distanceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
		self.arrow3 = YES;
		
	}
	
	
}

-(void)distancMenu:(int) distanc
{
	self.pageIndex = 1;
	
	self.shopFindProperty._pageIndex = [NSString stringWithFormat:@"%d",self.pageIndex];
	self.shopFindProperty._distance = [NSString stringWithFormat:@"%d",distanc];
//	self.shopFindProperty._type =@"";
//	self.shopFindProperty._orderBy =@"0";
//	self.shopFindProperty._serviceTagId = @"";
//	self.shopFindProperty._keyword = @"";
	if (self.district !=nil) {
		self.cityMenuView.alpha = 1.0;
	}else{
		self.distanceMenu.alpha = 1.0;
	}
	//self.distanceMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	if (self.district !=nil) {
		self.cityMenuView.alpha = 0.0;
	}else{
		self.distanceMenu.alpha = 0.0;
	}
	//self.distanceMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.cityMenuView.hidden = NO;
	self.distanceMenu.hidden = NO;
	
	self.inputView.hidden = YES;
	[self.distanceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	self.arrow3 = YES;
	
	
	
	[self loadDataSource];
}

-(void)cityMenu:(NSString*) cityId cityName:(NSString*)cityName district:(District*)adistrict{
	self.pageIndex = 1;
	if (adistrict!=nil) {
		self.distanceLabel.text = adistrict._name;
		self.shopFindProperty._districtId = adistrict._id;

        if (self._delegate && [self._delegate respondsToSelector:@selector(changeDistrictAddress::)]) {
            [self._delegate performSelector:@selector(changeDistrictAddress::) withObject:[NSString stringWithFormat:@"选择位置:%@%@", cityName, adistrict._name] withObject:adistrict];
        }
	}else{
		self.distanceLabel.text = cityName;
		self.shopFindProperty._districtId = @"";
        if (self._delegate && [self._delegate respondsToSelector:@selector(changeCityAddress:)]) {
            [self._delegate performSelector:@selector(changeCityAddress:) withObject:cityName];
        }
	}
	
	self.shopFindProperty._pageIndex = [NSString stringWithFormat:@"%d",self.pageIndex];
	self.shopFindProperty._cityId = cityId;
//	self.shopFindProperty._type =@"";
//	self.shopFindProperty._orderBy =@"0";
//	self.shopFindProperty._serviceTagId = @"";
//	self.shopFindProperty._keyword = @"";
	if (self.district !=nil) {
		self.cityMenuView.alpha = 1.0;
	}else{
		self.distanceMenu.alpha = 1.0;
	}
	//self.distanceMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	if (self.district !=nil) {
		self.cityMenuView.alpha = 0.0;
	}else{
		self.distanceMenu.alpha = 0.0;
	}
	//self.distanceMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.cityMenuView.hidden = NO;
	self.distanceMenu.hidden = NO;
	
	self.inputView.hidden = YES;
	[self.distanceButton setImage:[UIImage imageNamed:@"OButton.png"] forState:UIControlStateNormal];
	
	self.arrow3 = YES;
	[self loadDataSource];
}

-(void) backHome:(UIButton *)sender
{
	if (isSelectMap) {
		
		[self mapClick:sender];
		
	}else {
		[self.navigationController popViewControllerAnimated:YES];
	}
	
}


//加载酒店详情数据
- (void)loadShopInfoSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:self.shops._id withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
		
}

//加载数据
- (void)loadDataSource
{
	
	
	ASIFormDataRequest * theRequest = [InterfaceClass getShopList:self.shopFindProperty];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryHotelPaseredResult:) Delegate:self needUserType:Default];
	
}



//加载数据
- (void)loadFitstDataSource
{
	[self.h_tableView reloadData];
	_refreshHeaderView.frame=CGRectMake(0.0f, self.h_tableView.contentSize.height, self.h_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}


//加载成功
- (void)onqueryHotelPaseredResult:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return;
	}
	shopFindDataResponse = [ShopFindDataResponse findShop:dic];
	if (self.pageIndex==1)
		self.shopListArray =shopFindDataResponse.shops;
	else
		[self.shopListArray addObjectsFromArray:shopFindDataResponse.shops];
	
	if (self.shopListArray.count <=0)
		[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
	
	self.bMKMapView.dataArray = self.shopListArray;
	
	[self.h_tableView reloadData];
	
	
	self.number = (int)[shopFindDataResponse.count intValue];
	self.totalPage =(int)[shopFindDataResponse.totalPage intValue];
	
	if (self.number <= SHOP_NUMBER_PAGE ) {
		
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		
		if (self.isLastPage) {
			self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
			
		}
		return;
	}else{
		if(self.isfromRecomend)
		{
			self.isfromRecomend = FALSE;
			[self isrefreshHeaderView];
			self.isLastPage = FALSE;
		}
	}
	
	
	if(self.pageIndex == self.totalPage && self.totalPage != 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		self.isLastPage = YES;
		return;
	}
	
	_refreshHeaderView.frame=CGRectMake(0.0f, self.h_tableView.contentSize.height, self.h_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}


////加载成功
- (void)onPaseredShopDetailResult:(NSDictionary *)dic
{
	
	if ([ShopForDataInfo setShopForDataInfo:dic]) {
		
		ShopForDetailsViewController *shopForDetailsVC = [[ShopForDetailsViewController alloc]init];
		shopForDetailsVC.shops = self.shops;
		shopForDetailsVC.shopListVC = self;
		shopForDetailsVC.shopFindProperty = self.shopFindProperty;
		shopForDetailsVC._detailData = [ShopForDataInfo setShopForDataInfo:dic];
		[self.navigationController pushViewController:shopForDetailsVC animated:YES];
		[shopForDetailsVC release];
	}

	
}







-(void)mapClick:(id)sender//点击地图按钮
{
        UIButton *button = (UIButton *)sender;
	[UIView beginAnimations:@"flipping view" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	if (self.tempView) {
		[self.tempView removeFromSuperview];
	}
	self.orderMenu.hidden = YES;
	self.tagMenu.hidden = YES;
	self.distanceMenu.hidden = YES;
	self.typeMenu.hidden = YES;

	
	
	
	switch (button.tag) {
		case 100:
		
			self.arrowDown.hidden = YES;
			self.arrowUp.hidden = YES;
			self.typeButton.hidden = YES;
			
			self.rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.listButton];
			self.navigationItem.rightBarButtonItem = self.rightBar;
			
//			[self.bottomView viewWithTag:100].hidden=YES;
//			[self.bottomView viewWithTag:101].hidden=NO;
			
			[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft
					       forView:self.view_IOS7 cache:YES];
			
			UIView *_maptempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
			_maptempView.backgroundColor = [UIColor whiteColor];
			[_maptempView addSubview:bMKMapView];
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(250, ViewHeight-100, 40.5, 40.5) backImage:[UIImage imageNamed:@"Locate.png"] target:self action:@selector(map:)];
			[button setImage:[UIImage imageNamed:@"LocateClick.png"] forState:UIControlStateHighlighted];
			[_maptempView addSubview:button];
			
			self.tempView = _maptempView;
//			[self.view_IOS7 insertSubview:self.tempView atIndex:100];
            [self.view_IOS7 addSubview:self.tempView];

			[_maptempView release];
			isSelectMap = TRUE;
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(map:)];
			
			[UIView commitAnimations];
			
			break;
		case 101:
			self.arrowDown.hidden = NO;
			self.arrowUp.hidden = YES;
	                self.typeButton.hidden = NO;
			
			self.rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.mapButton];
			self.navigationItem.rightBarButtonItem = self.rightBar;
			
			[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight
					       forView:self.view_IOS7 cache:YES];
			
			UIView *_listempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
			[_listempView addSubview:self.listView];
			
			self.tempView = _listempView;
//			[self.view_IOS7 insertSubview:self.tempView atIndex:100];
			[self.view_IOS7 addSubview:self.tempView];
			[_listempView release];
			isSelectMap = FALSE;
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(list:)];
			
			[UIView commitAnimations];
			
			
			break;
		default:
			break;
	}
	
	
	
	
}

-(void)map:(id)sender
{
	[bMKMapView setAnnotation];
}

-(void)list:(id)sender
{
	[self.h_tableView reloadData];
	
	if(self.isLastPage)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
		return;
	}
}



-(void)infoClick:(NSArray*)location{
	

}



- (void)showDetails:(UIButton *)sender
{
	self.shops = (Shops *)[self.shopListArray objectAtIndex:sender.tag];
	sender.tag = 101;
	if (isSelectMap) {
	    [self mapClick:sender];
	}
	[self loadShopInfoSource];
	
}


- (void)phoneClick:(UIButton *)sender
{
	self.shops = (Shops *)[self.shopListArray objectAtIndex:sender.tag];
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"拨打电话：%@", self.shops._telephone] delegate:self cancelButtonTitle:@"确认"
					    otherButtonTitles:@"取消", nil];
	

	[alert show];
	[alert release];
}

- (void)bgClick:(UIButton *)sender
{
	
	self.shops = (Shops *)[self.shopListArray objectAtIndex:sender.tag];
	[self loadShopInfoSource];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self callTel:self.shops._telephone];
	}
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	
	return [self.shopListArray count];
	
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 96.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

		Shops *shop = nil;
	        shop = (Shops *)[self.shopListArray objectAtIndex:indexPath.row];
	        static NSString *flightDetailsCellIdentifier = @"orderMenuCellIdentifier";
	        ShopFindCell *cell = [tableView dequeueReusableCellWithIdentifier:flightDetailsCellIdentifier];
		if (cell == nil) {
			cell = [[[ShopFindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flightDetailsCellIdentifier] autorelease];
			cell.backgroundColor = [UIColor clearColor];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.delegate = self;
			
			if ([shop._distance isEqualToString:@"0m"]) {
				cell.distance.hidden = YES;
			}else{
				cell.distance.hidden = NO;
			}
			
		}
    
	
		cell.name.text = shop._name;
	        cell.bgButton.tag = indexPath.row;
	        cell.phoneButton.tag = indexPath.row;
		cell.serviceTags.text = shop._serviceTags;
	        cell.area.text = shop._district;
		
	        cell.distance.text =shop._distance;
	
		if ([shop._state intValue] == 0) {
			cell.phoneButton.hidden = NO;
			cell.shopRest.hidden = YES;
			
		}if ([shop._state intValue] == 1) {
			
			cell.phoneButton.hidden = YES;
			cell.shopRest.hidden = YES;
		}if ([shop._state intValue] == 2) {
			
			cell.phoneButton.hidden = NO;
			cell.shopRest.hidden = NO;
		}
    
        cell.isVouchers.hidden = ![shop._isVouchers boolValue];

    
		if ([shop._isNotice boolValue]==NO)
			cell.notice.hidden = YES;
		else
			cell.notice.hidden = NO;
        shop._picUrl = shop._picUrl;
		[cell.shopImageView setUrlString:shop._picUrl];
		[cell drawStarCodeView:[shop._star floatValue]];
		
				
		return cell;
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (![cell selectionStyle] == UITableViewCellSelectionStyleNone) {
		
	}
//	self.shops = (Shops *)[self.shopListArray objectAtIndex:indexPath.row];
//	[self loadShopInfoSource];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate －－上拉涮新委托方法

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}




#pragma mark -
#pragma mark Data Source Loading / Reloading －－上拉涮新相关

//实现上拖的方法
- (void)reloadTableViewDataSource
{
	if (self.shopListArray.count%SHOP_NUMBER_PAGE==0) {
		self.pageIndex++;
		self.shopFindProperty._pageIndex = [NSString stringWithFormat:@"%d",self.pageIndex];
		[self loadDataSource];
		
		reloading = YES;
	}
	
}



//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.h_tableView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}



@end

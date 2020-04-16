//
//  SelectCityViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "SelectCityViewController.h"
#import "DataClass.h"
#import "City.h"
@interface SelectCityViewController ()

@end

@implementation SelectCityViewController
@synthesize searchCityTF,citysTableView,cityDistrict,selectSection,homeVC,textFieldArray,keyboardbar,bMKMapView,activityIV;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.homeVC.bMKMapView.delegate = self;
	//开启应用判断是否进行定位提示(第一次进入城市选择出现定位提示)
	if(![CLLocationManager locationServicesEnabled])
	{
		NSString *firstLocation =  [[NSUserDefaults standardUserDefaults] objectForKey:keyFirstLocation];
		if(![firstLocation isEqualToString:@"1"]){
			[UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:keyFirstLocation];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
	if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied  ||  [CLLocationManager authorizationStatus] ==  kCLAuthorizationStatusRestricted ) {
		NSString *firstLocation =  [[NSUserDefaults standardUserDefaults] objectForKey:keyFirstLocation];
		if(![firstLocation isEqualToString:@"1"]){
			[UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:keyFirstLocation];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		
		
	}
//	if([CLLocationManager locationServicesEnabled])
//	  [self.bMKMapView viewWillAppear];
	
}

-(void)viewWillDisappear:(BOOL)animated {
	self.homeVC.bMKMapView.delegate = self.homeVC;
	[super viewWillDisappear:animated];
//	if([CLLocationManager locationServicesEnabled])
//		[self.bMKMapView viewWillDisappear];
}




- (void)dealloc
{
    self.searchCityTF = nil;
    self.citysTableView = nil;
    self.cityDistrict = nil;
    self.homeVC = nil;
    self.textFieldArray = nil;
    self.keyboardbar = nil;
	//self.bMKMapView = nil;
	self.activityIV = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"选择您的位置";
    [self getMyCityDistrict];
	
	
    
    
//    if (!self.bMKMapView)
//    self.bMKMapView = [[[BaiduMKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, ViewHeight-44)] autorelease];
//    self.bMKMapView.delegate = self;
      self.bMKMapView.isLoadView = FALSE;
    
	//self.bMKMapView.pinTag = 0;
	
//    self.searchCityTF = [UISubTextField TextFieldWithFrame:CGRectMake(5, 20, ViewWidth-10, 30) borderStyle:UITextBorderStyleRoundedRect textAlignment:NSTextAlignmentLeft placeholder:@"请输入搜索城市"];
//    self.searchCityTF.delegate = self;
//    [self.view_IOS7 addSubview:self.searchCityTF];
//    [self.view_IOS7 addSubview:[UIButton customButtonTitle:nil tag:0 image:[UIImage imageNamed:@"搜索.png"] frame:CGRectMake(ViewWidth-60, 25, 20, 20) target:self action:@selector(searchCity:)]];
//    self.textFieldArray = [NSArray arrayWithObjects:self.searchCityTF, nil];
    
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"我的位置" backImage:nil frame:CGRectMake(5, 20, 90, 30) font:FontSize36 color:FontColor000000 target:self action:@selector(getMyAddress:)]];
    
//    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"我的位置" frame:CGRectMake(5, 60, 90, 30) font:FontSize36 color:FontColor000000 alignment:NSTextAlignmentRight]];
//    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(100, 20, 17, 27) image:[UIImage imageNamed:@"定位.png"]]];
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"定位.png"] frame:CGRectMake(100, 25, 15, 20) font:nil color:nil target:self action:@selector(getMyAddress:)]];
	
    self.selectSection = 0;
	
    self.activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIV.frame = CGRectMake(140, 28,15, 15);
    [self.view_IOS7 addSubview:self.activityIV];

    
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 60, ViewWidth-30, ViewHeight-80) style:UITableViewStylePlain];
    aTableView.tag =0;
    self.citysTableView = aTableView;
    self.citysTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.citysTableView.backgroundColor = [UIColor clearColor];
    self.citysTableView.delegate = self;
    self.citysTableView.dataSource = self;
    [self.view_IOS7 addSubview:self.citysTableView];
    [aTableView release];
}

-(void)getMyAddress:(UIButton*)sender
{
	
	    if(![CLLocationManager locationServicesEnabled])
	    {
		[UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
		    
	    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied  ||  [CLLocationManager authorizationStatus] ==  kCLAuthorizationStatusRestricted ) {
		    
		    [UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
	    }else
	    {
		    [self.activityIV startAnimating];
		    [self.bMKMapView viewWillAppear];
		    //[self.bMKMapView showsUserLocationYes];
		    self.bMKMapView.tag =1;
		    self.bMKMapView.flag = FALSE;
		    [UserLogin sharedUserInfo].showMapInfo = FALSE;

	    }
    
}


//-(void)searchCity:(UIButton*)sender
//{
//    
//}

-(void)getMyCityDistrict
{
    NSArray *citys = [DataClass selectFromCity];
    NSArray *countrys = [DataClass selectFromCountry];
    NSMutableArray *allArray = [NSMutableArray array];
    
    for(int i=0;i<[citys count];i++)
    {
        City *aCity = [citys objectAtIndex:i];
        NSString *cityID = aCity._id;
        NSLog(@"%@",aCity._id);
        
        NSMutableArray *array = [NSMutableArray array];
        for(int j=0;j<[countrys count];j++)
        {
            District *district = [countrys objectAtIndex:j];
            NSLog(@"%@",district._cityId);
            if([district._cityId isEqualToString:cityID])
                [array addObject:district];
        }
        [array insertObject:aCity atIndex:0];
        [allArray addObject:array];
    }
    self.cityDistrict = allArray;

    NSLog(@"%@",cityDistrict);
}

#pragma mark-地图定位delegate
-(void)infoClick:(NSArray*)infoArray{
	
	[self.activityIV stopAnimating];
	if (infoArray == nil) {
		return;
	}
	if ([[infoArray objectAtIndex:2] isEqualToString:@"北京市" ]) {
		[UIAlertView alertViewWithMessage:@"定位失败！"];
		return;
	}
	
        [self.bMKMapView viewWillDisappear];
	self.homeVC.isCityLoad = TRUE;
	[UserLogin sharedUserInfo]._longitude = [infoArray objectAtIndex:1];
	[UserLogin sharedUserInfo]._latitude = [infoArray objectAtIndex:0];
	self.homeVC.address = @"";
	[self.homeVC.activityIV startAnimating];
	self.homeVC.addressLabel.text = [NSString stringWithFormat:@"当前位置：%@",[infoArray objectAtIndex:2]];
	self.homeVC.shopFindProperty._cityId = @"";
	self.homeVC.shopFindProperty._latitude =  [UserLogin sharedUserInfo]._latitude;
	self.homeVC.shopFindProperty._longitude = [UserLogin sharedUserInfo]._longitude;
	self.homeVC.shopFindProperty._districtId = @"";
	self.homeVC.bMKMapView.tag = 1;
	self.homeVC.district = nil;
    self.homeVC.selectCity = nil;

	[[NSUserDefaults standardUserDefaults] setObject:[infoArray objectAtIndex:4] forKey:keyLoginUserLocation];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self.activityIV stopAnimating];
	[self.homeVC.activityIV stopAnimating];
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)addShopClick:(NSArray*)infoArray
{
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7 ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
		
	}
	[keyboardbar showBar:textField];  //显示工具条
	return  YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [cityDistrict count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [(NSArray*)[cityDistrict objectAtIndex:section] count]-1;

    if(selectSection == section)
        return ((count%4 == 0)?(count/4):(count/4+1))+1;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        NSString *cityIdentifier = [NSString stringWithFormat:@"cityIdentifier%d",indexPath.section];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityIdentifier];
        
        // Configure the cell...
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cityIdentifier] autorelease];
            
           NSArray *array = [cityDistrict objectAtIndex:indexPath.section];
            City *aCity =[array objectAtIndex:0];
            [cell.contentView addSubview:[UISubLabel labelWithTitle:aCity._name frame:CGRectMake(5, 0, 150, 20)  font:FontSize36 color:FontColor000000 alignment:NSTextAlignmentLeft]];
            [cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 25, ViewWidth, 0.5) image:[UIImage imageNamed:@"横向分割线.png"]]];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        NSString *tagIdentifier = [NSString stringWithFormat:@"tagIdentifier%d%d",indexPath.section,indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagIdentifier];
        
      
        NSArray *array = [cityDistrict objectAtIndex:indexPath.section];
         int  count = [array count]-1 - (indexPath.row-1)*4;//还未显示的地区数
        
        // Configure the cell...
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tagIdentifier] autorelease];
            int tags = (count > 4)?(4):(count);
            
            for(int i=0; i<tags; i++)
            {
                District *district = [array objectAtIndex:([array count] - count + i)];
             
                NSInteger tag = (indexPath.row-1)*4+i+1;
                NSString *title = district._name;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom tag:tag title:title backImage:nil frame:CGRectMake(5+72*i, 0, 65, 20) font:FontSize32 color:FontColor000000 target:self action:@selector(click:)];
                [cell.contentView addSubview:button];
                
                [cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 25, ViewWidth, 0.5) image:[UIImage imageNamed:@"横向分割线.png"]]];
            }
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        selectSection = indexPath.section;
//        if([(NSArray*)[self.cityDistrict objectAtIndex:indexPath.section] count] > 1)
//        {
//            [citysTableView reloadData];
//        }
//        else
//        {
//            City *aCity = [[self.cityDistrict objectAtIndex:indexPath.section] objectAtIndex:0];
//            self.homeVC.address = aCity._name;
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
        
        City *aCity = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:0];
        District *aDistrict = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:1];
        [self.homeVC.activityIV stopAnimating];
        self.homeVC.address = aCity._name;
        self.homeVC.selectCity = aCity._name;
        self.homeVC.district = aDistrict;
        self.homeVC.shopFindProperty._latitude =@"";
        self.homeVC.shopFindProperty._longitude = @"";
        
        [UserLogin sharedUserInfo]._longitude =@"";
        [UserLogin sharedUserInfo]._latitude=@"";
        
        self.homeVC.shopFindProperty._cityId = aCity._id;
        self.homeVC.shopFindProperty._districtId = @"";
        [UserLogin sharedUserInfo].showMapInfo = TRUE;
        [self.homeVC.addressLabel setText:[NSString stringWithFormat:@"选择位置:%@",aCity._name]];
        [self.navigationController popToRootViewControllerAnimated:YES];
            
    }
}
-(void)click:(UIButton*)sender
{
	City *aCity = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:0];
	District *aDistrict = [[self.cityDistrict objectAtIndex:selectSection] objectAtIndex:sender.tag];
	[self.homeVC.activityIV stopAnimating];
	self.homeVC.address = aDistrict._name;
	self.homeVC.district = aDistrict;
    self.homeVC.selectCity = nil;
	self.homeVC.shopFindProperty._latitude =@"";
	self.homeVC.shopFindProperty._longitude = @"";
	
	[UserLogin sharedUserInfo]._longitude =@"";
	[UserLogin sharedUserInfo]._latitude=@"";

	self.homeVC.shopFindProperty._cityId = aDistrict._cityId;
	self.homeVC.shopFindProperty._districtId = aDistrict._id;
	[UserLogin sharedUserInfo].showMapInfo = TRUE;
	[self.homeVC.addressLabel setText:[NSString stringWithFormat:@"选择位置:%@%@",aCity._name,aDistrict._name]];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

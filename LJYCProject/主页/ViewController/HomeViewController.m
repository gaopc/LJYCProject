//
//  HomeViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "HomeViewController.h"
#import "MemberRegisterViewController.h"
#import "ShopFindViewController.h"
#import "CoustomObject.h"
#import "AddShopsViewController.h"
#import "TagButton.h"
#import "AddTagsViewController.h"
#import "SelectCityViewController.h"
#import "SideBarViewController.h"
#import "Header.h"
#import "WelecomViewContrller.h"
#import "ShopFindProperty.h"
#import "ShopFindDataResponse.h"
#import "ASIFormDataRequest.h"
#import "DataClass.h"
#import "UserLogin.h"
#import "MemberHomeViewController.h"
#import "ServiceTag.h"
#import "MemberLoginViewController.h"
#import "MyQuestionListViewController.h"
#import "FrameMenuViewController.h"



@interface ActivetyListCell : UIControl
@property (nonatomic,retain) AsyncImageView * _imageV;
@property (nonatomic,retain) UILabel * _nameLab;
@property (nonatomic,retain) UILabel * _subLab;

@end

@implementation ActivetyListCell

@synthesize _imageV,_nameLab,_subLab;
- (void)dealloc
{
    self._subLab = nil;
    self._nameLab = nil;
    self._imageV = nil;
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self._imageV = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 50)];
        self._imageV.defaultImage = 3;
        self._nameLab = [UILabel labelWithTitle:@"平谷大桃节热门推荐" frame:CGRectMake(10,self._imageV.frame.size.height,frame.size.width-20,30) font:[UIFont systemFontOfSize:16] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
        self._subLab = [UILabel labelWithTitle:@"采摘园吐血推荐，去享受新鲜水果盛宴吧！" frame:CGRectMake(10,self._nameLab.frame.size.height+self._nameLab.frame.origin.y - 2,frame.size.width-20,20) font:[UIFont systemFontOfSize:14] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:NO];
        
        [self addSubview:self._nameLab];
        [self addSubview:self._imageV];
        [self addSubview:self._subLab];

    }
    return self;
}

@end


@interface HomeViewController ()
{
    UIScrollView * topBarnerView;
    UIPageControl * pageC;
}
@property(nonatomic,retain)NSArray *_barnerList;//顶层活动数组
@property(nonatomic,retain)NSArray *_activetyList;//列表活动数组
@property(nonatomic,retain)ActivetyItem * _activety;
- (void)loadShopListDataSource;
@end

@implementation HomeViewController

@synthesize _activetyList,_barnerList;

@synthesize myScrollView,tagScrollView,tagControl;
@synthesize projectView1,projectView2,addressLabel;
@synthesize searchView,searchTF,cancelSearchBtn,historySearchTB,grayBackGroundView;
@synthesize tagsArray,address,historySearchAry,bMKMapView,shopFindProperty,activityIV,district,titleName,tagName;
@synthesize pushIntoMember,inputView,isCityLoad;
@synthesize keyboardbar, textFieldArray;
@synthesize selectCity;

@synthesize _activety;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    
    [_barnerList release];
    [_activetyList release];
    _barnerList = nil;
    _activetyList = nil;
    
    self.selectCity = nil;
    self.myScrollView = nil;
    self.tagControl = nil;
    self.tagScrollView = nil;
    
    self.projectView1 = nil;
    self.projectView2 = nil;
    self.addressLabel = nil;
    self.titleName = nil;
    self.searchView = nil;
    self.searchTF = nil;
    self.cancelSearchBtn = nil;
    self.historySearchTB = nil;
    self.grayBackGroundView = nil;
	self.tagName = nil;
	self.district = nil;
    self.tagsArray = nil;
    self.address = nil;
    self.historySearchAry = nil;
	//self.bMKMapView = nil;
	self.shopFindProperty = nil;
    self.activityIV = nil;
	self.inputView = nil;
    
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.bMKMapView.delegate = self;
    if(![self.shopFindProperty._districtId isEqualToString:@""])
	    self.inputView.hidden = YES;
	if (!self.isCityLoad) {
		if ([self.address isEqualToString:@""] || [self.address isEqualToString:@"北京市"] || !self.address) {
			if([CLLocationManager locationServicesEnabled])
			{
				self.bMKMapView.tag = 1;
				[self.bMKMapView viewWillAppear];
			}
		}
	}else{
		self.isCityLoad = FALSE;
	}
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if([CLLocationManager locationServicesEnabled])
	[self.bMKMapView viewWillDisappear];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"辣郊游";
    self.view_IOS7.backgroundColor = [UIColor whiteColor];
    self.pushIntoMember = YES;

    //导航
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 25, 23) backImage:[UIImage imageNamed:@"侧栏1.png"] target:self action:@selector(sideBar:)];
    [leftButton setImage:[UIImage imageNamed:@"侧栏2.png"] forState:UIControlStateHighlighted];
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    [rightButtonView setBackgroundColor:[UIColor clearColor]];
    
    UIButton  * rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(0, 0, 44, 44) backImage: Nil target:self action:@selector(searchServe:)]; //[UIImage imageNamed:@"搜索1.png"]
    [rightButton1 setImage:[UIImage imageNamed:@"搜索2.png"] forState:UIControlStateHighlighted];
    [rightButton1 setImage:[UIImage imageNamed:@"搜索1.png"] forState:UIControlStateNormal];

//    rightButton1.backgroundColor = [UIColor redColor];
    
    UIButton  * rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil frame:CGRectMake(44, 0, 44, 44) backImage:nil target:self action:@selector(userLogin:)]; //[UIImage imageNamed:@"登录头像1.png"]
    [rightButton2 setImage:[UIImage imageNamed:@"登录头像2.png"] forState:UIControlStateHighlighted];
    [rightButton2 setImage:[UIImage imageNamed:@"登录头像1.png"] forState:UIControlStateNormal];

//	rightButton2.backgroundColor = [UIColor greenColor];
    [rightButtonView addSubview:rightButton1];
    [rightButtonView addSubview:rightButton2];
    
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    [rightButtonView release];
    
    
    //MyScrollView
    UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-35)];
    self.myScrollView = aScrollView;
    [aScrollView release];
    self.myScrollView.backgroundColor = [UIColor clearColor];
    self.myScrollView.alpha = 1.0;
    self.myScrollView.tag = 1;
    self.myScrollView.alwaysBounceVertical = NO;
    [self.view_IOS7 addSubview:self.myScrollView];
    
    NSLog(@"%@",NSStringFromCGRect(self.myScrollView.frame));
    
    //专题文章
    topBarnerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 125)];
    topBarnerView.delegate = self;
    topBarnerView.pagingEnabled = YES;
    [self.myScrollView addSubview:topBarnerView];
    [topBarnerView release];
    pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(topBarnerView.frame.origin.x,topBarnerView.frame.origin.y + topBarnerView.frame.size.height - 30, topBarnerView.frame.size.width, 30)];
    [self.myScrollView addSubview:pageC];
    [pageC release];

    //4大店铺
    
    shopTypeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 125, ViewWidth, 126)];
    shopTypeView.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:shopTypeView];
    [shopTypeView release];
    [self showShopType];
    //开启应用判断是否进行定位提示(第一次进入城市选择出现定位提示)
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:keyFirstLocation];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.myScrollView addSubview:[UILabel labelWithTitle:@"主题活动" frame:CGRectMake(20, shopTypeView.frame.origin.y +shopTypeView.frame.size.height + 2, self.myScrollView.frame.size.width, 30) font:[UIFont systemFontOfSize:14] color:[UIColor blackColor] alignment:NSTextAlignmentLeft]];
    
//    [self setBarnerWithArr:[NSArray arrayWithObjects:@"", @"", @"", @"", @"", nil]];
//    [self setHotActivetyListWithArr:[NSArray arrayWithObjects:@"", @"", @"", @"", @"", nil]];

    [self searchActives_find];
	
    //获取所在城市
	if(![CLLocationManager locationServicesEnabled])
		self.address = @"北京市";
	else
		self.address = @"";
	
    
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-44-35, ViewWidth, 35) image:[UIImage imageNamed:@"地址栏.png"]]];
    self.addressLabel = [UISubLabel labelWithTitle:[NSString stringWithFormat:@"当前位置：%@",self.address] frame:CGRectMake(3, ViewHeight-44-32.5,ViewWidth-40, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft autoSize:NO];
    
    [self.view_IOS7 addSubview:self.addressLabel];
    UIButton *addressButton = [UIButton customButtonTitle:nil tag:100 image:[UIImage imageNamed:@"选择城市.png"] frame:CGRectMake(ViewWidth-40, ViewHeight-44-35, 40, 35) target:self action:@selector(getMoreLocation:)];
    [self.view_IOS7 addSubview:addressButton];
    
    //风火轮
	self.activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIV startAnimating];
	activityIV.frame = CGRectMake(100, 8,15, 15);
    [self.addressLabel addSubview:activityIV];
    [activityIV release];
	
    //搜索关键字时 遮挡蒙层
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    self.grayBackGroundView = grayView;
    [grayView release];
    [self.grayBackGroundView setBackgroundColor:[UIColor blackColor]];
    self.grayBackGroundView.alpha = 0.4;
    [self.view_IOS7 addSubview:self.grayBackGroundView];
    self.grayBackGroundView.hidden = YES;
    
    //搜索输入框
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-300)];
    self.searchView = view2;
    [view2 release];
    [self.searchView setBackgroundColor:[UIColor whiteColor]];
    
    [self.searchView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 5, ViewWidth-70, 30) image:[UIImage imageNamed:@"下拉搜索输入框.png"]]];
    
    self.searchTF = [UISubTextField TextFieldWithFrame:CGRectMake(15, 5, ViewWidth-70, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"搜你喜欢的" font:FontSize32];
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.delegate = self;
    self.searchTF.returnKeyType = UIReturnKeySearch;
    [self.searchView addSubview:self.searchTF];
    
    
    self.cancelSearchBtn = [UIButton customButtonTitle:nil tag:101 image:[UIImage imageNamed:@"下拉搜索取消.png"] frame:CGRectMake(ViewWidth-53, 5, 50, 30) target:self action:@selector(cancelSearch:)];
    [self.cancelSearchBtn setBackgroundImage:[UIImage imageNamed:@"下拉搜索取消灰.png"] forState:UIControlStateHighlighted];
    [self.searchView addSubview:self.cancelSearchBtn];
    

    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 36, ViewWidth, ViewHeight-300-36) style:UITableViewStylePlain];
    self.historySearchTB = aTableView;
    [aTableView release];
    self.historySearchTB.delegate = self;
    self.historySearchTB.dataSource = self;
    self.historySearchTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.historySearchTB setBackgroundColor:[UIColor clearColor]];
    [self.searchView addSubview:self.historySearchTB];
    
    [self.view_IOS7 addSubview:self.searchView];
     self.searchView.hidden = YES;
    
     self.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, ViewWidth, 260)];
     self.inputView.backgroundColor = [UIColor clearColor];
     [self.view_IOS7 addSubview:self.inputView];
	
	
    
    //欢迎页
    WelecomViewContrller* welecomVC = [[WelecomViewContrller alloc]init];
    welecomVC.delegate = self;
	[self.navigationController pushViewController:welecomVC animated:NO];
	[welecomVC release];
	
	if (!self.shopFindProperty) {
		
		self.shopFindProperty = [[ShopFindProperty alloc]init];
		self.shopFindProperty._type =@"";
		self.shopFindProperty._orderBy =@"0";
		self.shopFindProperty._serviceTagId = @"";
		self.shopFindProperty._distance = @"0";
		self.shopFindProperty._latitude = @"";
		self.shopFindProperty._longitude = @"";
		self.shopFindProperty._pageIndex = @"0";
		self.shopFindProperty._keyword = @"";
		self.shopFindProperty._filter = @"0";
		self.shopFindProperty._cityId = @"";
		self.shopFindProperty._districtId = @"";
	}
    
	//获取所在城市
	if(![CLLocationManager locationServicesEnabled]){
		NSArray *citys = [DataClass selectFromCity];
		City *aCity = [citys objectAtIndex:0];
		NSLog(@"aCity._id %@" ,aCity._id);
		self.shopFindProperty._cityId = aCity._id;
		self.inputView.hidden = YES;
		[activityIV stopAnimating];
	}
    
    self.textFieldArray = [NSArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBroard) name:@"closeKeyBoard" object:nil];
}

-(void)searchActives_find
{
    ASIFormDataRequest * theRequest = [InterfaceClass actives_find];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSearchActives_find:) Delegate:self needUserType:Default];
}

-(void) onSearchActives_find:(NSDictionary *) dic
{
    ActivetyModel * model = [ActivetyModel ActivetyModelWithDic:dic];
    [self setBarnerWithArr:model._topList];
    [self setHotActivetyListWithArr:model._hotList];
}

-(void) setBarnerWithArr:(NSArray *) topActivetyArr
{
    self._barnerList = topActivetyArr;
    pageC.numberOfPages = [topActivetyArr count];
    for (int i=0; i<[topActivetyArr count]; i++) {
        
        ActivetyItem *activetyDic = [self._barnerList objectAtIndex:i];
        
        AsyncImageView * imageV = [[AsyncImageView alloc] initWithFrame:CGRectMake(i * topBarnerView.frame.size.width, 0, topBarnerView.frame.size.width, topBarnerView.frame.size.height)];
        imageV.defaultImage = 4;
        imageV.urlString = activetyDic._picUrl;
        imageV.tag = i;
        [imageV addTarget:self action:@selector(showBarnerAcitvetyDetail:) forControlEvents:UIControlEventTouchUpInside];
        [topBarnerView addSubview:imageV];
        [imageV release];
    }
    topBarnerView.contentSize = CGSizeMake([topActivetyArr count] * topBarnerView.frame.size.width, topBarnerView.frame.size.height);
}
-(void)showBarnerAcitvetyDetail:(AsyncImageView *)sender
{
    self._activety = [self._barnerList objectAtIndex:sender.tag];
    
    ASIFormDataRequest * theRequest = [InterfaceClass recommendShop:self._activety._activetyId ];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onactives_findShop:) Delegate:self needUserType:Default];
}
-(void) onactives_findShop:(NSDictionary *) dic
{
    [self._activety getShopsWithDic:dic];
    ActivetyShopListViewController * activetyShopListVC = [[ActivetyShopListViewController alloc] init];
    activetyShopListVC._activety = self._activety;
    [self.navigationController pushViewController:activetyShopListVC animated:YES];
    [activetyShopListVC release];
}

-(void) setHotActivetyListWithArr:(NSArray *) topActivetyArr
{
    CGFloat startY = 125 +126 + 30;
    self._activetyList = topActivetyArr;
    pageC.numberOfPages = [topActivetyArr count];
    for (int i=0; i<[topActivetyArr count]; i++) {
        
        ActivetyItem *activetyDic = [self._activetyList objectAtIndex:i];
        
        ActivetyListCell * cell = [[ActivetyListCell alloc] initWithFrame:CGRectMake(0, startY , self.myScrollView.frame.size.width, 150)];
        [cell._imageV addTarget:self action:@selector(showHotAcitvetyDetail:) forControlEvents:UIControlEventTouchUpInside];
        [cell._imageV setUrlString:activetyDic._picUrl];
        [cell addTarget:self action:@selector(showHotAcitvetyDetail:) forControlEvents:UIControlEventTouchUpInside];
        cell.tag = i;
        [self.myScrollView addSubview:cell];
        [cell release];
        startY += 150;
    }
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width, startY);
}
-(void)showHotAcitvetyDetail:(ActivetyListCell *)sender
{
    self._activety = [self._activetyList objectAtIndex:sender.tag];
    ASIFormDataRequest * theRequest = [InterfaceClass recommendShop:self._activety._activetyId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onactives_findShop:) Delegate:self needUserType:Default];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageC.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}

- (void)setNewScrollViewContent
{
    UIView *addView = [self.myScrollView viewWithTag:55];
    [addView removeFromSuperview];
    
    int tagCount = [self.tagsArray count];//tagsArray包含选择的标签及选择标签
    
    UIView *tagView = [[UIView alloc] initWithFrame:CGRectMake(0, 210 + 45, ViewWidth, ((tagCount - 1)/4 + 1) * 80)];
    tagView.tag = 55;
    float offx = 0.0f;
    float offy = 0.0f;
    float width = (ViewWidth-10.f)/4;
    float height = 80.f;
    
    for (int i = 0; i < tagCount; i ++) {
        
        offx = (i%4) * width + 5;
        offy = i/4 * 80;
        
        BOOL showRight;
        if ((i+1)%4 == 0 )
            showRight = NO;
        else
            showRight = YES;
        
        ServiceTag *serviceTag = (ServiceTag*)[tagsArray objectAtIndex:i];
        if(i == tagCount-1)
        {
            
            TagButton *tagButton = [TagButton setTagButton:@"" frame:CGRectMake(offx, offy, width, height) tag:i showImageView:NO title:serviceTag._tag_name isShowRightLine:showRight isShowBelowLine:YES isAddButton:YES];
            tagButton.shopType = @"";
            tagButton.serviceTag = serviceTag._tag_id;
            tagButton.titleName = @"选择标签";
            tagButton.delegate =self;
            [tagView addSubview:tagButton];
        }
        else
        {
            
            TagButton *tagButton = [TagButton setTagButton:serviceTag._tag_picUrl frame:CGRectMake(offx, offy, width, height) tag:i showImageView:NO title:serviceTag._tag_name isShowRightLine:showRight isShowBelowLine:YES isAddButton:NO];
            tagButton.shopType = @"";
            tagButton.serviceTag = serviceTag._tag_id;
            tagButton.titleName = @"全部商家";
            tagButton.tagName = serviceTag._tag_name;
            tagButton.delegate =self;
            [tagView addSubview:tagButton];
        }
    }
    [self.myScrollView addSubview: tagView];
    self.myScrollView.contentSize = CGSizeMake(0, 260 + tagView.frame.size.height);
    NSLog(@"%@",NSStringFromCGSize(self.myScrollView.contentSize));
}

-(void)setMyScrollViewContent
{
    [self setNewScrollViewContent];
//    [self.tagScrollView removeFromSuperview];
//    [self.tagControl removeFromSuperview];
//    
//    int tagCount = [self.tagsArray count];//tagsArray包含选择的标签及选择标签
//    int pageCount = 1;
////    if(tagCount%8)
////        pageCount =tagCount/8+1;
////    else
////        pageCount =tagCount/8;
//    
//    UIScrollView *scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 210, ViewWidth, 180)];
//    self.tagScrollView = scrollView2;
//    self.tagScrollView.tag = 2;
//    [scrollView2 release];
//    self.tagScrollView.contentSize = CGSizeMake(ViewWidth*pageCount, self.tagScrollView.frame.size.height);
//    self.tagScrollView.pagingEnabled = YES;
//    self.tagScrollView.backgroundColor = [UIColor clearColor];
//    self.tagScrollView.delegate = self;
//    self.tagScrollView.alpha = 1.0;
//    self.tagScrollView.showsHorizontalScrollIndicator = NO;
//    
//    for(int i =1;i <= pageCount;i++)
//    {
//        UIView *tagView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth*(i-1), 0, ViewWidth, self.tagScrollView.frame.size.height)];
//        
////        int min = (tagCount > 8*i) ? 8:(tagCount-8*(i-1));//当前页有几个标签
//        int min = tagCount;
//        for(int j=0 ;j< min; j++)
//        {
//            float x = 0.0f;
//            float y = 0.0f;
//            float w = (ViewWidth-10.f)/4;
//            float h = 80.f;
//            if(j<4)
//            {
//                x= 5+w*j;
//                y= 0;
//            }
//            else
//            {
//                x= 5+w*(j%4);
//                y= 80;
//            }
//
//            BOOL showRight;
//            if ((j+1)%4 == 0 )
//                showRight = NO;
//            else
//                showRight = YES;
//            
//            ServiceTag *serviceTag = (ServiceTag*)[tagsArray objectAtIndex:(i-1)*8+j];
//            if((i-1)*8+j == [tagsArray count]-1)
//            {
//                
//                TagButton *tagButton = [TagButton setTagButton:@"" frame:CGRectMake(x, y, w, h) tag:(i-1)*8+j showImageView:NO title:serviceTag._tag_name isShowRightLine:showRight isShowBelowLine:YES isAddButton:YES];
//                tagButton.shopType = @"";
//                tagButton.serviceTag = serviceTag._tag_id;
//                tagButton.titleName = @"选择标签";
//                tagButton.delegate =self;
//                [tagView addSubview:tagButton];
//            }
//            else
//            {
//                
//                TagButton *tagButton = [TagButton setTagButton:serviceTag._tag_picUrl frame:CGRectMake(x, y, w, h) tag:(i-1)*8+j showImageView:NO title:serviceTag._tag_name isShowRightLine:showRight isShowBelowLine:YES isAddButton:NO];
//                tagButton.shopType = @"";
//                tagButton.serviceTag = serviceTag._tag_id;
//                tagButton.titleName = @"全部商家";
//                tagButton.tagName = serviceTag._tag_name;
//                tagButton.delegate =self;
//                [tagView addSubview:tagButton];
//                
//            }
//            
//        }
//        [self.tagScrollView addSubview:tagView];
//        [tagView release];
//    }
//    [self.myScrollView addSubview: self.tagScrollView];
//
//    UIPageControl *aTagControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.tagScrollView.frame.origin.y+self.tagScrollView.frame.size.height-18, ViewWidth,5)];
//    self.tagControl = aTagControl;
//    [aTagControl release];
//    self.tagControl.numberOfPages = pageCount;
//    self.tagControl.currentPage = 0;
//    self.tagControl.hidesForSinglePage = YES;
//    self.tagControl.backgroundColor = [UIColor clearColor];
//    self.tagControl.alpha = 1.0;
//    [self.myScrollView addSubview:self.tagControl];
//    [self scrollViewDidScroll:self.tagScrollView];
//
}

-(void)getMySearchHistory
{
    [self.historySearchAry removeAllObjects];
    self.historySearchAry = (NSMutableArray*)[DataClass selectSearch_History];
    
    if([self.historySearchAry count] > 0)
        [self.historySearchAry insertObject:[NSString stringWithFormat:@"清除搜索记录"] atIndex:[self.historySearchAry count]];
    else
        [self.historySearchAry insertObject:[NSString stringWithFormat:@"暂无搜索记录"] atIndex:[self.historySearchAry count]];
}

-(void)showShopType
{
    UIButton *caizhaiBut = [UIButton buttonWithTag:0 frame:CGRectMake(0, 0, shopTypeView.frame.size.width/2, 63) target:self action:@selector(itemClick:)];
    UIButton *yuleBut = [UIButton buttonWithTag:1 frame:CGRectMake(shopTypeView.frame.size.width/2, 0, shopTypeView.frame.size.width/2, 63) target:self action:@selector(itemClick:)];
    UIButton *nongjialeBut = [UIButton buttonWithTag:2 frame:CGRectMake(0, 63, shopTypeView.frame.size.width/2, 63) target:self action:@selector(itemClick:)];
    UIButton *jingdianBut = [UIButton buttonWithTag:3 frame:CGRectMake(shopTypeView.frame.size.width/2, 63, shopTypeView.frame.size.width/2, 63) target:self action:@selector(itemClick:)];

    [nongjialeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jingdianBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [caizhaiBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuleBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nongjialeBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [jingdianBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [caizhaiBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [yuleBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//
//    [nongjialeBut setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, nongjialeBut.frame.size.width - 10 - 40)];
//    [caizhaiBut setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, caizhaiBut.frame.size.width - 10 - 40)];
//    [yuleBut setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, yuleBut.frame.size.width - 10 - 40)];
//    [jingdianBut setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, jingdianBut.frame.size.width - 10 - 40)];
//    
    [nongjialeBut setImage:[UIImage imageNamed:@"农家乐item.png"] forState:UIControlStateNormal];
    [caizhaiBut setImage:[UIImage imageNamed:@"采摘园item.png"] forState:UIControlStateNormal];
    [yuleBut setImage:[UIImage imageNamed:@"娱乐item.png"] forState:UIControlStateNormal];
    [jingdianBut setImage:[UIImage imageNamed:@"景点item.png"] forState:UIControlStateNormal];

    [shopTypeView addSubview:nongjialeBut];
    [shopTypeView addSubview:caizhaiBut];
    [shopTypeView addSubview:yuleBut];
    [shopTypeView addSubview:jingdianBut];
    
//    [shopTypeView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 1.0f) image:[UIImage imageNamed:@"横向分割线.png"]]];
//    [shopTypeView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, shopTypeView.frame.size.height/2, ViewWidth, 1.0f) image:[UIImage imageNamed:@"横向分割线.png"]]];
//    [shopTypeView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, shopTypeView.frame.size.height - 1, ViewWidth, 1.0f) image:[UIImage imageNamed:@"横向分割线.png"]]];
//    [shopTypeView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth/2, 0, 1.0f, shopTypeView.frame.size.height) image:[UIImage imageNamed:@"分割线.png"]]];
    
    [shopTypeView addSubview:[UILabel labelWithframe:CGRectMake(0, 0, ViewWidth, 1.0f) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    [shopTypeView addSubview:[UILabel labelWithframe:CGRectMake(0, shopTypeView.frame.size.height/2, ViewWidth, 1.0f) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    [shopTypeView addSubview:[UILabel labelWithframe:CGRectMake(0, shopTypeView.frame.size.height - 1, ViewWidth, 1.0f) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    [shopTypeView addSubview:[UILabel labelWithframe:CGRectMake(ViewWidth/2, 0, 1.0f, shopTypeView.frame.size.height) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
//
//    
//    CGRect frame = shopTypeView.bounds;
//    float btnWidth = frame.size.width/4;
//    
//    for (int i=0; i<[[BaseInfo shareBaseInfo]._ShopTypes count]; i++) {
//        ShopType * shop = [[BaseInfo shareBaseInfo]._ShopTypes objectAtIndex:i];
//        TagButton *tagButton = [TagButton setTagButton:shop._Type_picUrl frame:CGRectMake(i * btnWidth, 0, btnWidth, btnWidth) tag:i showImageView:NO title:shop._Type_name isShowRightLine:NO isShowBelowLine:NO isAddButton:NO];
//        tagButton.shopType = shop._Type_id;
//        tagButton.serviceTag = @"";
//        tagButton.titleName = shop._Type_name;
//        tagButton.tagName = @"服务标签";
//        tagButton.delegate =self;
//        [shopTypeView addSubview:tagButton];
//    }
    
//    UIButton *nongjialeBut = [UIButton buttonWithTag:0 frame:CGRectMake(0, 0, 140, 124) target:self action:@selector(itemClick:)];
//    UIButton *caizhaiBut = [UIButton buttonWithTag:1 frame:CGRectMake(141, 0, 165, 60) target:self action:@selector(itemClick:)];
//    UIButton *yuleBut = [UIButton buttonWithTag:2 frame:CGRectMake(141, 61, 85, 60) target:self action:@selector(itemClick:)];
//    UIButton *jingdianBut = [UIButton buttonWithTag:3 frame:CGRectMake(227, 61, 80, 60) target:self action:@selector(itemClick:)];
//    
//    [nongjialeBut setImageEdgeInsets:UIEdgeInsetsMake(7, 24, 6, 23)]; //93 111
//    [caizhaiBut setImageEdgeInsets:UIEdgeInsetsMake(12, 33, 11, 34)];   // 98 37
//    [yuleBut setImageEdgeInsets:UIEdgeInsetsMake(8, 15, 7, 16)];      //54 45
//    [jingdianBut setImageEdgeInsets:UIEdgeInsetsMake(8, 23, 6, 24)];  //33 46
//    
//    [nongjialeBut setImage:[UIImage imageNamed:@"首页item4.png"] forState:UIControlStateNormal];
//    [caizhaiBut setImage:[UIImage imageNamed:@"首页item2.png"] forState:UIControlStateNormal];
//    [yuleBut setImage:[UIImage imageNamed:@"首页item3.png"] forState:UIControlStateNormal];
//    [jingdianBut setImage:[UIImage imageNamed:@"首页item1.png"] forState:UIControlStateNormal];
//    
//    [shopTypeView addSubview:nongjialeBut];
//    [shopTypeView addSubview:caizhaiBut];
//    [shopTypeView addSubview:yuleBut];
//    [shopTypeView addSubview:jingdianBut];
//    
//    [shopTypeView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(140, 0, 1.0f, 124) image:[UIImage imageNamed:@"分割线.png"]]];
//    [shopTypeView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(141, 60, 165, 1.0f) image:[UIImage imageNamed:@"横向分割线.png"]]];
//    [shopTypeView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(227, 61, 1.0f, 63) image:[UIImage imageNamed:@"分割线.png"]]];
}

-(void)showServiceTags
{
//    self.tagsArray = [NSMutableArray array];
//    if (![[UserLogin sharedUserInfo].userID isEqualToString:@""] && [UserLogin sharedUserInfo].userID != NULL)
//    {
//        if([BaseInfo shareBaseInfo]._ServiceShowTags_login.count ==0 )
//            [self.tagsArray addObjectsFromArray:[BaseInfo shareBaseInfo]._ServiceShowTags];
//        else
//            [self.tagsArray addObjectsFromArray:[BaseInfo shareBaseInfo]._ServiceShowTags_login];
//    }
//    else
//    {
//        [self.tagsArray addObjectsFromArray:[BaseInfo shareBaseInfo]._ServiceShowTags];
//    }
//    ServiceTag *shopType = [[ServiceTag alloc] init];
//    shopType._tag_name = @"选择标签";
//    [self.tagsArray insertObject:shopType atIndex:[self.tagsArray count]];
//    [shopType release];
//    [self setMyScrollViewContent];
}
#pragma mark-所有按钮触发事件
- (void)itemClick:(UIButton *)sender
{
    NSArray *itemArr = [NSArray arrayWithObjects:@"采摘园", @"娱乐设施", @"农家乐", @"景点", nil];
    self.titleName =  [itemArr objectAtIndex:sender.tag];
    self.tagName = @"服务标签";
    for (ShopType *shop in [BaseInfo shareBaseInfo]._ShopTypes) {
        
        if ([shop._Type_name isEqualToString:[itemArr objectAtIndex:sender.tag]]) {
            
            self.shopFindProperty._type = shop._Type_id;
            self.shopFindProperty._serviceTagId = @"";
            
            self.shopFindProperty._keyword = @"";
            [self loadShopListDataSource];
        }
    }
}

-(void)click:(TagButton*)sender//点击服务标签
{
    pushIntoMember = NO;
    self.titleName = sender.titleName;
	self.tagName = sender.tagName;
   
     if([self.titleName isEqualToString:@"选择标签"])
    {
    
        if (![UserLogin sharedUserInfo].userID)
        {
            
            MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
            memberLoginVC.delegate = self;
            [self.navigationController pushViewController:memberLoginVC animated:YES];
            [memberLoginVC release];
 
        }
        else
        {
            AddTagsViewController *addTagsVC = [[AddTagsViewController alloc] init];
            addTagsVC.homeVC = self;
            [self.navigationController pushViewController:addTagsVC animated:YES];
            [addTagsVC release];
        }
      
    }
    else
    {
        
        self.shopFindProperty._type = sender.shopType;
        self.shopFindProperty._serviceTagId = sender.serviceTag;
        
	    self.shopFindProperty._keyword = @"";
	    [self loadShopListDataSource];

    }
    
}

- (void)loadShopListDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass getShopList:self.shopFindProperty];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopListResult:) Delegate:self needUserType:Default];
	
}



//加载成功
- (void)onPaseredShopListResult:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return;
	}
	shopFindDataResponse = [ShopFindDataResponse findShop:dic];
	if([shopFindDataResponse.count intValue]<=0)
	{
		[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
		return;
	}
	ShopFindViewController * shopListVC = [[ShopFindViewController alloc] init];
	int totalPage = [shopFindDataResponse.totalPage intValue];
	if (totalPage <= 1) {
		shopListVC.isfromRecomend = TRUE;
	}
    shopListVC._delegate = self;
	shopListVC.shopListArray = shopFindDataResponse.shops;
	shopListVC.shopFindProperty = self.shopFindProperty;
	shopListVC.district = self.district;
    shopListVC.selectCity = self.selectCity;
	shopListVC.titleName = self.titleName;
	shopListVC.bMKMapView = self.bMKMapView;
	if (![self.shopFindProperty._keyword isEqualToString:@""]) {
		shopListVC.tagName = self.shopFindProperty._keyword;
		shopListVC.serviceButton.hidden = YES;
	}else{
		shopListVC.tagName = self.tagName;
	}
	
	
	[self.navigationController pushViewController:shopListVC animated:YES];
	[shopListVC release];
			
	
}

-(void)getMoreLocation:(UIButton*)sender//获取更多位置
{
    [self cancelSearch:nil];
    
    SelectCityViewController *selectCityVC = [[SelectCityViewController alloc] init];
    selectCityVC.homeVC = self;
    selectCityVC.bMKMapView = self.bMKMapView;
    [self.navigationController pushViewController:selectCityVC animated:YES];
    [selectCityVC release];
}



-(void)searchServe:(UIButton*)sender//搜索关键字
{
    [self getMySearchHistory];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.grayBackGroundView.hidden = NO;
    self.searchView.hidden = NO;
    [self.historySearchTB reloadData];
    [self.searchTF becomeFirstResponder];
    [UIView commitAnimations];
    
    [self.historySearchTB scrollToRowAtIndexPath:
     [NSIndexPath indexPathForRow:0 inSection:0]atScrollPosition: UITableViewScrollPositionBottom
                                        animated:NO];
}

-(void)cancelSearch:(UIButton*)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.grayBackGroundView.hidden = YES;
    self.searchView.hidden = YES;
    
    [UIView commitAnimations];
    [searchTF resignFirstResponder];
}

-(void)userLogin:(UIButton*)sender//注册、登录 会员中心
{
    pushIntoMember = YES;
    [self cancelSearch:nil];
    if ([UserLogin sharedUserInfo].userID ) {
        MemberHomeViewController *memberRegisterVC= [[MemberHomeViewController alloc] init];
        [self.navigationController pushViewController:memberRegisterVC animated:YES];
        [memberRegisterVC release];
    }
    else
    {
        MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
        memberLoginVC.delegate = self;
        [self.navigationController pushViewController:memberLoginVC animated:YES];
        [memberLoginVC release];

    }
    
}
-(void) loginSuccessFul:(id)type
{
    if(pushIntoMember)
    {
        [self showServiceTags];
        
        MemberHomeViewController *memberHomeVC = [[MemberHomeViewController alloc] init];
        [self.navigationController pushViewController:memberHomeVC animated:YES];
        [memberHomeVC release];
    }
    else
    {
        [self showServiceTags];
    }
}

#pragma mark-地图定位delegate
-(void)infoClick:(NSArray*)infoArray{
    
    
    [UserLogin sharedUserInfo]._longitude = [infoArray objectAtIndex:1];
    [UserLogin sharedUserInfo]._latitude = [infoArray objectAtIndex:0];

    self.address = [infoArray objectAtIndex:2];
    if ([self.address isEqualToString:@"北京市"]) {
	     NSArray *citys = [DataClass selectFromCity];
	     City *aCity = [citys objectAtIndex:0];
	     self.shopFindProperty._cityId = aCity._id;
    }else{
	     self.shopFindProperty._cityId = @"";
    }
	
    self.shopFindProperty._latitude =  [UserLogin sharedUserInfo]._latitude;
    self.shopFindProperty._longitude = [UserLogin sharedUserInfo]._longitude;
	
    [self.addressLabel setText:[NSString stringWithFormat:@"当前位置：%@",self.address]];
    [[NSUserDefaults standardUserDefaults] setObject:[infoArray objectAtIndex:4] forKey:keyLoginUserLocation];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [activityIV stopAnimating];
    self.inputView.hidden = YES;
	
   
	
	
   
}
-(void)addShopClick:(NSArray*)infoArray
{
}

#pragma mark-分类标签delegate
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = self.tagScrollView.frame.size.width;
//    int page = floor((scrollView.contentOffset.x - pageWidth / 3) / pageWidth) + 1;
//    self.tagControl.currentPage = page;
//    
//}

#pragma mark-输入框delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		self.view_IOS7.tag = 100;
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textField];  //显示工具条
	
	return TRUE;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.text.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"搜索关键字为空！"];
        return NO;
    }
    else
    {
        [self cancelSearch:nil];
        
        NSArray *array = [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",self.searchTF.text], nil], nil];
        [DataClass insertIntoSearch_HistoryWithArray:array];
        
        self.shopFindProperty._keyword =self.searchTF.text;
	 self.shopFindProperty._type = @"";
	 self.titleName = @"全部商家";
        [self loadShopListDataSource];
        textField.text = @"";
        return YES;
    }

}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self cancelSearch:nil];
    return YES;
}
#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row+1 == [self.historySearchAry count])
        return 50;
    else
        return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.historySearchAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    if (indexPath.row+1 == [self.historySearchAry count]) {
        static NSString *historySearchIdentifier = @"historySearchIdentifier";
        NSLog(@"%@",self.historySearchAry );    // Configure the cell...
        cell = [tableView dequeueReusableCellWithIdentifier:historySearchIdentifier];
        
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:historySearchIdentifier] autorelease];
            NSLog(@"%d",indexPath.row);
            NSLog(@"%d",[self.historySearchAry count]);
            UILabel * label =[UILabel labelWithTitle:[self.historySearchAry objectAtIndex:indexPath.row] frame:CGRectMake(0, 5, 320, 40) font:FontBlodSize36 color:FontColor000000 alignment:NSTextAlignmentCenter];
            label.tag = 100;
            [cell.contentView addSubview:label];
        }
        UILabel * label =(UILabel *) [cell viewWithTag:100];
        label.text =[self.historySearchAry objectAtIndex:indexPath.row];

    }
    else
    {
        static NSString *clearSearchIdentifier = @"clearSearchIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:clearSearchIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:clearSearchIdentifier] autorelease];
            [cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 40, ViewWidth, 0.5) image:[UIImage imageNamed:@"横向分割线.png"]]];
            UILabel * label =[UILabel labelWithTitle:[self.historySearchAry objectAtIndex:indexPath.row] frame:CGRectMake(10, 5, 200, 30) font:FontBlodSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
            label.tag = 100;
            [cell.contentView addSubview:label];
        }
        UILabel * label =(UILabel *) [cell viewWithTag:100];
        label.text =[self.historySearchAry objectAtIndex:indexPath.row];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row+1 == [self.historySearchAry count])
    {
        if(![[self.historySearchAry objectAtIndex:0] isEqualToString:@"暂无搜索记录"] && [self.historySearchAry count] == 1)
            return;
        else
        {
            [ self.historySearchAry removeAllObjects];
            [DataClass deleteSearch_History];
            [self getMySearchHistory];
            [self.historySearchTB reloadData];
        }
    }
    else
    {
        [self cancelSearch:nil];
        NSLog(@"%@",[self.historySearchAry objectAtIndex:indexPath.row]);
        self.shopFindProperty._keyword = [self.historySearchAry objectAtIndex:indexPath.row];
	    self.shopFindProperty._type = @"";
	    self.titleName = @"全部商家";
        [self loadShopListDataSource];
    }
}


- (void)getShopDetial:(id)sender
{
    AddShopsViewController *vc = [[AddShopsViewController alloc]init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBaiduMap
{
    self.bMKMapView = [[[BaiduMKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, ViewHeight-44)] autorelease];
	self.bMKMapView.delegate = self;
	self.bMKMapView.tag = 1;
        self.bMKMapView.pinTag = 0;
	self.bMKMapView.isLoadView = FALSE;
}



- (void)closeKeyBroard
{
    [self.keyboardbar HiddenKeyBoard];
}

- (void)changeDistrictAddress:(NSString *)addressName :(District *)adistrict
{
    self.addressLabel.text = addressName;
    self.selectCity = nil;
    self.district = adistrict;
}

- (void)changeCityAddress:(NSString *)addressName
{
    self.addressLabel.text = [NSString stringWithFormat:@"选择位置:%@", addressName];
    self.selectCity = addressName;
}
@end

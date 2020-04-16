//
//  MemberHomeViewController.m
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MemberHomeViewController.h"
#import "ShopCollectViewController.h"
#import "MessageListViewController.h"
#import "BoundPhoneViewController.h"
#import "ModifyPasswordViewController.h"
#import "MemberRegisterViewController.h"
#import "MemberLoginViewController.h"
#import "VerificationViewController.h"
#import "MemberPhotoViewController.h"
#import "MemberPhotoListViewController.h"
#import "MyReviewListViewController.h"
#import "MyQuestionListViewController.h"
#import "UserForCommentData.h"
#import "UserForQuestionData.h"
#import "MyMessageData.h"
#import "MySingInViewController.h"
#import "HomeViewController.h"
#import "PicModel.h"
#import "SinaWeiBoExtend.h"
#import "ShopCollectDataResponse.h"
#import "MyOrderListViewController.h"

@interface MemberHomeViewController ()
-(void)drawHeartCodeView:(int) markValue;
- (void)loadUserInfoSource;
@end

@implementation MemberHomeViewController
@synthesize u_tableView,_dataArray,heartValueView,centerView,integral,pepperCur,review,regist,photo,question;
@synthesize reviewButton,registButton,photoButton,questionButton,userInfo,shopCollectDataResponse,collectProperty;
-(void)dealloc
{
    self.u_tableView = nil;
    self._dataArray = nil;
	self.heartValueView = nil;
	self.centerView = nil;
	self.integral = nil;
	self.pepperCur = nil;
	
	self.review = nil;
	self.regist = nil;
	self.photo = nil;
	self.question = nil;
	
	self.shopCollectDataResponse = nil;
	self.collectProperty = nil;
	self.reviewButton = nil;
	self.registButton= nil;
	self.photoButton= nil;
	self.questionButton= nil;
	self.userInfo = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadUserInfoSource];
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
}

- (void)loadUserInfoSource
{
	
	ASIFormDataRequest * theRequest = [InterfaceClass userInfo:[UserLogin sharedUserInfo].userID];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetUserInfoResult:) Delegate:self needUserType:Member];
	
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"个人中心";
    
     UIButton  * rightButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(logout:) title:@"注销"];
     UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
     self.navigationItem.rightBarButtonItem = rightBar;
      [rightBar release];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginType =  [defaults objectForKey:LOGINTYPE];
    if([loginType isEqualToString:@"LJY"])
        self._dataArray = [NSArray arrayWithObjects:@"我的代金券",@"我的收藏", @"消息中心",@"解除绑定",@"修改密码",nil];
    else
        self._dataArray = [NSArray arrayWithObjects:@"我的代金券",@"我的收藏", @"消息中心",@"解除绑定",nil];
	
	UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
	
	[topView addSubview: [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 133.0f) image:[UIImage imageNamed:@"MHTopViewGg.png"]]];
	
	
	self.userName =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(25.0f, 40.0f, 180, 40.0f) font:FontSize48 color:FontColor000000 alignment:NSTextAlignmentLeft];
	self.userName.backgroundColor = [UIColor clearColor];
	self.userName.text = [UserLogin sharedUserInfo]._userName;
	[topView addSubview:self.userName];
	
	self.address =   [UISubLabel labelWithTitle:@"北京市" frame:CGRectMake(225.0f, 70.0f, 80, 16.0f) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentCenter];
	self.address.backgroundColor = [UIColor clearColor];
	self.address.text = [[NSUserDefaults standardUserDefaults]  objectForKey:keyLoginUserLocation];
	[topView addSubview:self.address];
	
	[self.view_IOS7 addSubview:topView];
	
	self.centerView = [[UIView alloc] initWithFrame:CGRectMake(10, 93.0f, 300.0f, 40.0f)];
	self.centerView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:0.8];
	[self.view_IOS7 addSubview:self.centerView];
	
	
	
	[self.centerView addSubview:[UISubLabel labelWithTitle:@"积分:" frame:CGRectMake(110.0f, 10.0f, 40.0f, 20.0f) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentRight]];
	self.integral =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(150.0f, 12.5f, 50, 16.0f) font:FontSize26 color:[UIColor redColor] alignment:NSTextAlignmentLeft];
	[self.centerView addSubview:self.integral];
	
	[self.centerView addSubview:[UISubLabel labelWithTitle:@"可用辣椒币:" frame:CGRectMake(190.0f, 10.0f, 70.0f, 20.0f) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
	self.pepperCur =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(260.0f, 12.5f, 50, 16.0f) font:FontSize26 color:[UIColor redColor] alignment:NSTextAlignmentLeft];
	[self.centerView addSubview:self.pepperCur];
	
	UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, 133.0f, 300, 37.5)];
	bottomView.backgroundColor = [UIColor whiteColor];
	
	[self.view_IOS7 addSubview:bottomView];
	
	self.review =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(20.0f, 5.0f, 50, 17.0f) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
	[bottomView addSubview:self.review];
	
	self.regist =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(95.0f, 5.0f, 50, 17.0f) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
	[bottomView addSubview:self.regist];
	
	self.photo =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(170.0f, 5.0f, 50, 17.0f) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
	[bottomView addSubview:self.photo];
	
	self.question =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(245.0f, 5.0f, 50, 17.0f) font:FontBlodSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
	[bottomView addSubview:self.question];
	
	[bottomView addSubview:[UISubLabel labelWithTitle:@"点评" frame:CGRectMake(20.0f, 22.0f, 30.0f, 13.0f) font:FontSize16 color:FontColor000000 alignment:NSTextAlignmentLeft]];
	[bottomView addSubview:[UISubLabel labelWithTitle:@"签到" frame:CGRectMake(95.0f, 22.0f, 30.0f, 13.0f) font:FontSize16 color:FontColor000000 alignment:NSTextAlignmentLeft]];
	[bottomView addSubview:[UISubLabel labelWithTitle:@"照片" frame:CGRectMake(170.0f, 22.0f, 30.0f, 13.0f) font:FontSize16 color:FontColor000000 alignment:NSTextAlignmentLeft]];
	[bottomView addSubview:[UISubLabel labelWithTitle:@"问答" frame:CGRectMake(245.0f, 22.0f, 30.0f, 13.0f) font:FontSize16 color:FontColor000000 alignment:NSTextAlignmentLeft]];
	
	self.reviewButton = [UIButton buttonWithType:UIButtonTypeCustom tag:201 title:@"" frame:CGRectMake(0.0f, 0.0f,  75.0f,  37.5) backImage:[UIImage imageNamed:@"MHBReview.png"] target:self action:@selector(homeClick:)];
	self.registButton = [UIButton buttonWithType:UIButtonTypeCustom tag:202 title:@"" frame:CGRectMake(75.0f, 0.0f,  75.0f,  37.5) backImage:[UIImage imageNamed:@"MHBRegist.png"] target:self action:@selector(homeClick:)];
	self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom tag:203 title:@"" frame:CGRectMake(150.0f, 0.0f,  75.0f,  37.5) backImage:[UIImage imageNamed:@"MHBPhoto.png"] target:self action:@selector(homeClick:)];
	self.questionButton = [UIButton buttonWithType:UIButtonTypeCustom tag:204 title:@"" frame:CGRectMake(225.0f, 0.0f,  75.0f,  37.5) backImage:[UIImage imageNamed:@"MHBQa.png"] target:self action:@selector(homeClick:)];
    
    [self.reviewButton setBackgroundImage:[UIImage imageNamed:@"MHBReview2.png"] forState:UIControlStateHighlighted];
    [self.registButton setBackgroundImage:[UIImage imageNamed:@"MHBRegist2.png"] forState:UIControlStateHighlighted];
    [self.photoButton setBackgroundImage:[UIImage imageNamed:@"MHBPhoto2.png"] forState:UIControlStateHighlighted];
    [self.questionButton setBackgroundImage:[UIImage imageNamed:@"MHBQa2.png"] forState:UIControlStateHighlighted];
	
	[bottomView addSubview:self.reviewButton];
	[bottomView addSubview:self.registButton];
	[bottomView addSubview:self.photoButton];
	[bottomView addSubview:self.questionButton];
	
	UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,180,ViewWidth,ViewHeight-44.0f-180) style:UITableViewStylePlain];
	self.u_tableView = tableView;
	[tableView release];
	self.u_tableView.backgroundColor = [UIColor clearColor];
	self.u_tableView.dataSource = self;
	self.u_tableView.delegate = self;
	self.u_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	[self.view_IOS7 addSubview:self.u_tableView];
	
	if (!self.collectProperty) {
		
		self.collectProperty = [[CollectProperty alloc]init];
		self.collectProperty._userId = [UserLogin sharedUserInfo].userID;
		self.collectProperty._pageIndex =@"1";
		self.collectProperty._order = @"0";
		self.collectProperty._shopTypeId = @"";
		self.collectProperty._cityId = @"";
		
	}

	// Do any additional setup after loading the view.
}

-(void)logout:(UIButton*)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您确认注销么？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = 10000;
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 10000)
    {
        if(buttonIndex != 0)
        {
            [UserLogin sharedUserInfo].userID = nil;
            [UserLogin sharedUserInfo]._userName = @"";
            [UserLogin sharedUserInfo].passWord = @"";
            [UserLogin sharedUserInfo].tags = nil;
            [[BaseInfo shareBaseInfo]._ServiceShowTags_login removeAllObjects];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:keyAudioLogin];
            
            NSString *loginType =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGINTYPE];
            if([loginType isEqualToString:@"QQ"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:QQID];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:QQToken];
            }
            else if([loginType isEqualToString:@"WEIBO"])
            {
                
                NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                                          nil, @"AccessTokenKey",
                                          nil, @"ExpirationDateKey",
                                          nil, @"UserIDKey",
                                          nil, @"refresh_token", nil];
                
                [[NSUserDefaults standardUserDefaults] setObject:authData forKey:SinaWeiboAuthData];
            }
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSMutableArray * mArray = [NSMutableArray array];
            for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
                
                if (![[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberHomeViewController class]])
                {
                    [mArray addObject:[self.navigationController.viewControllers objectAtIndex:i]];
                }
            }
            self.navigationController.viewControllers = mArray;
            HomeViewController * homeVC = mArray.lastObject;
            if ([homeVC isKindOfClass:[HomeViewController class]]) {
                [homeVC showServiceTags];
            }
            
            MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
            memberLoginVC.delegate = homeVC;
            [homeVC.navigationController pushViewController:memberLoginVC animated:NO];
            [memberLoginVC release];
        }
        else
        {
        
        }
    }
}
-(void)onGetUserInfoResult:(NSDictionary*)dic
{
	self.userInfo = [UserInfoDataResponse userInfo:dic];
    
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:LOGINTYPE] isEqualToString:@"LJY"])
    {
        self.userName.text = [dic objectForKey:@"nickname"];
    }
    
	self.integral.text =  self.userInfo._integral;
	self.pepperCur.text = self.userInfo._lcdCurrency;
	if ([self.userInfo._level intValue]>0) {
		[self drawHeartCodeView:[self.userInfo._level intValue]];
	}
	
	self.review.text = self.userInfo._commentCount;
	self.regist.text = self.userInfo._signInCount;
	self.photo.text = self.userInfo._pictureCount;
	self.question.text = self.userInfo._qACount;
    
    NSLog(@"--%@--%@--",self.userInfo._commentCount,userInfo._qACount);
    
	[UserLogin sharedUserInfo]._telephone = self.userInfo._telephone;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginType =  [defaults objectForKey:LOGINTYPE];
    if(self.userInfo._telephone.length != 11)
    {
      if([loginType isEqualToString:@"LJY"])
          self._dataArray = [NSArray arrayWithObjects:@"我的代金券",@"我的收藏", @"消息中心",@"绑定手机号",@"修改密码",nil];
        else
            self._dataArray = [NSArray arrayWithObjects:@"我的代金券",@"我的收藏", @"消息中心",@"绑定手机号",nil];
    }
    else
    {
        if([loginType isEqualToString:@"LJY"])
            self._dataArray = [NSArray arrayWithObjects:@"我的代金券",@"我的收藏", @"消息中心",@"解除绑定",@"修改密码",nil];
        else
            self._dataArray = [NSArray arrayWithObjects:@"我的代金券",@"我的收藏", @"消息中心",@"解除绑定",nil];
    }
    
    [self.u_tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
	
	return [self._dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 62;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier =@"identifier";
	UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		UIImageView * cellImageView = [UIImageView ImageViewWithFrame:CGRectMake(10, 3, tableView.frame.size.width-20, 44) image:[UIImage imageNamed:@"个人中心cell.png"]];
		[cell addSubview:cellImageView];
		UIImageView * cellArrowImageView = [UIImageView ImageViewWithFrame:CGRectMake(cellImageView.frame.size.width - 17, 17, 7, 10) image:[UIImage imageNamed:@"CellArrow.png"]];
		[cellImageView addSubview:cellArrowImageView];
		UISubLabel * label = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 3, tableView.frame.size.width - 40, 44) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
		label.tag = 99;
		[cell addSubview:label];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    UISubLabel * label = (UISubLabel *)[cell viewWithTag:99];
    label.text = [self._dataArray objectAtIndex:indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	switch (indexPath.row) {
        case 0://我的代金券
        {
            MyOrderListViewController * orderlistVC = [[MyOrderListViewController alloc] init];
            [self.navigationController pushViewController:orderlistVC animated:YES];
            [orderlistVC release];
        }
            break;
        case 1:
        {
            self.collectProperty._pageIndex =@"1";
            ASIFormDataRequest * theRequest = [InterfaceClass userFindCollect:self.collectProperty];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryHotelPaseredResult:) Delegate:self needUserType:Default];

        }
            break;
        case 2:
        {
            ASIFormDataRequest * theRequest = [InterfaceClass findMessage:[UserLogin sharedUserInfo].userID pageIndex:[NSString stringWithFormat:@"1"]];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFindMessagePaseredResult:) Delegate:self needUserType:Default];
            
        }
            break;
        case 3:
        {
            BoundPhoneViewController * shopC = [[BoundPhoneViewController alloc] init];
            [self.navigationController pushViewController:shopC animated:YES];
            [shopC release];
        }
            break;
        case 4:
        {
            ModifyPasswordViewController * shopC = [[ModifyPasswordViewController alloc] init];
            [self.navigationController pushViewController:shopC animated:YES];
            [shopC release];
        }
            break;
        default:
            break;
    }
	
}

//加载成功
- (void)onqueryHotelPaseredResult:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return;
	}
	self.shopCollectDataResponse = [ShopCollectDataResponse findCollect:dic];
	if([ self.shopCollectDataResponse.count intValue]<=0)
	{
		[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
		return;
	}
	
	
	
	ShopCollectViewController * shopC = [[ShopCollectViewController alloc] init];
	int totalPage = [shopCollectDataResponse.totalPage intValue];
	if (totalPage <= 1) {
		shopC.isfromRecomend = TRUE;
	}
	shopC.shopListArray = self.shopCollectDataResponse.collects;
	shopC._dataIsFull = TRUE;
	[self.navigationController pushViewController:shopC animated:YES];
	[shopC release];
	
	
}

-(void)drawHeartCodeView:(int) markValue{
	
	if (self.heartValueView)
		[self.heartValueView removeFromSuperview];
	
	self.heartValueView= [[UIView alloc] initWithFrame:CGRectMake(15, 15, 120, 20 )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*18, 0, 14.5, 12.5)];
			starGreenImg.image = [UIImage imageNamed:@"Heart_Golden.png"]; //选中
			[self.heartValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*18, 0, 14.5, 12.5)];
			starWhiteImg.image = [UIImage imageNamed:@"Heart_Gray.png"];
			[self.heartValueView addSubview:starWhiteImg];
			[starWhiteImg release];
			
		}
	}
	[self.centerView addSubview:self.heartValueView];
	
	
}


- (void)homeClick:(UIButton *)sender
{
	switch (sender.tag) {
		case 201:
			//点评
        {
            ASIFormDataRequest * theRequest = [InterfaceClass getUserCommentList:[UserLogin sharedUserInfo].userID PageIndex:[NSString stringWithFormat:@"1"]];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserCommentListPaseredResult:) Delegate:self needUserType:Default];
        }
			break;
		case 202:
			//签到
        {
            ASIFormDataRequest * theRequest = [InterfaceClass userSingIn:[UserLogin sharedUserInfo].userID pageIndex:[NSString stringWithFormat:@"1"]];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserSingInPaseredResult:) Delegate:self needUserType:Default];
        }
			break;
		case 203:
        {
			//照片
            ASIFormDataRequest * theRequest = [InterfaceClass userPhotoList:[UserLogin sharedUserInfo].userID withPageIndex:@"1"];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserPhotoListPaseredResult:) Delegate:self needUserType:Default];
			break;
        }
		case 204:
			//问答
        {
            ASIFormDataRequest * theRequest = [InterfaceClass getUserQAList:[UserLogin sharedUserInfo].userID PageIndex:[NSString stringWithFormat:@"1"]];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserQAListPaseredResult:) Delegate:self needUserType:Default];
        
        }
			break;
			
		default:
			break;
	}
}

- (void)onUserPhotoListPaseredResult:(NSDictionary *)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] intValue] == 0)
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
        return;
    }
    PicListModel *memberData = [PicListModel memberPicListData:dic];
    
    MemberPhotoListViewController *mPhotoVC = [[MemberPhotoListViewController alloc] init];
    mPhotoVC._picListData = memberData;
    if ([memberData._totalPage intValue] < 2) {
        
        mPhotoVC.isfromRecomend = YES;
    }
    [self.navigationController pushViewController:mPhotoVC animated:YES];
    [mPhotoVC release];
}

-(void)onUserSingInPaseredResult:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] intValue] == 0)
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
        return;
    }
    
    MySingInViewController *mySingInViewController = [[MySingInViewController alloc] init];
    mySingInViewController.myUserSignInData = [UserSignInData getUserSignInData:dic];
    if ([mySingInViewController.myUserSignInData.totalPage intValue] <= 1 || [mySingInViewController.myUserSignInData.totalPage isEqualToString:@"(null)"])
        mySingInViewController.isfromRecomend = YES;
    [self.navigationController pushViewController:mySingInViewController animated:YES];
    [mySingInViewController release];
}

-(void)onFindMessagePaseredResult:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] intValue] == 0)
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]]];
        return;
    }
    
    MessageListViewController * messageVC = [[MessageListViewController alloc] init];
    messageVC.myMessageData = [MyMessageData getMyMessageData:dic];
    if ([messageVC.myMessageData.totalPage intValue] <= 1 || [messageVC.myMessageData.totalPage isEqualToString:@"(null)"])
		messageVC.isfromRecomend = YES;
    
    [self.navigationController pushViewController:messageVC animated:YES];
    [messageVC release];
}

-(void)onUserCommentListPaseredResult:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] intValue] == 0)
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
        return;
    }
    
    MyReviewListViewController *myReviewListVC = [[MyReviewListViewController alloc] init];
    myReviewListVC.userForCommentData = [UserForCommentData setUserForCommentData:dic];
    if ([myReviewListVC.userForCommentData._totalPage intValue] <= 1 || [myReviewListVC.userForCommentData._totalPage isEqualToString:@"(null)"])
        myReviewListVC.isfromRecomend = YES;
    [self.navigationController pushViewController:myReviewListVC animated:YES];
    [myReviewListVC release];
}

-(void)onUserQAListPaseredResult:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] intValue] == 0)
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
        return;
    }
    
    MyQuestionListViewController *myQuestionListVC = [[MyQuestionListViewController alloc] init];
    myQuestionListVC.userForQuestionData = [UserForQuestionData setUserForQuestionData:dic];
    if ([myQuestionListVC.userForQuestionData._totalPage intValue] <= 1 || [myQuestionListVC.userForQuestionData._totalPage isEqualToString:@"(null)"])
        myQuestionListVC.isfromRecomend = YES;
    [self.navigationController pushViewController:myQuestionListVC animated:YES];
    [myQuestionListVC release];
}
@end

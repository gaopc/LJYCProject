
//
//  WelecomViewContrller.m
//  FlightProject
//
//  Created by longcd on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WelecomViewContrller.h"
#import "GetConfiguration.h"
#import "WelecomImagesView.h"
#import "MemberRegisterViewController.h"
#import "VersionView.h"
#import "SinaWeiBoExtend.h"
@interface WelecomViewContrller ()

@end

@implementation WelecomViewContrller
@synthesize basicInfo,_backgroundImage,_hasFirstImages,delegate;
-(void)dealloc
{
    self.basicInfo.cityDelegate = nil;
    self.basicInfo = nil;
    self._backgroundImage = nil;
    self._hasFirstImages = FALSE;
    self.delegate = nil;
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

//关于新版本的提示
-(BOOL) showFirstInAlert{
	
	if ([WelecomImagesView isFirstShow] == NO) {
		return NO;
	}
    else {
        WelecomImagesView * imagesV = [[WelecomImagesView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
        imagesV.delegate = self;
        [self.view addSubview:imagesV];
        [imagesV release];
        return YES;
    }
}

//关于评分的提示 崔立东 2013年3月5日添加
-(void) showGradeAlert{
	
	if ([WelecomImagesView isShowGrade] == YES) {
	    [self toFirstGrade];
	}
}


-(void)scrollViewFinished 
{
    [self showHome];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIV startAnimating];

    self._hasFirstImages = NO; // [self showFirstInAlert];
    //崔立东 2013年3月5日添加
    [self showGradeAlert];
    if (ViewHeight > 480) {
        self._backgroundImage = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, 568) image:[UIImage imageNamed:@"Default-568h@2x.png"]];
        activityIV.frame = CGRectMake((320-30)/2, ViewHeight - 160, 30, 30);
    }
    else {
        self._backgroundImage = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, 480) image:[UIImage imageNamed:@"Default.png"]];
        activityIV.frame = CGRectMake((320-30)/2, ViewHeight - 130, 30, 30);
    }
    [self.view addSubview:self._backgroundImage];
    [self.view addSubview:activityIV];
    [activityIV release];
    
    
    GetBasicInfoFromServer *_basicInfo = [[GetBasicInfoFromServer alloc] init];
    self.basicInfo = _basicInfo;
    [_basicInfo release];
    self.basicInfo.delegate = self;
    self.basicInfo.cityDelegate = self.delegate;
    [self.basicInfo getConfiguration];
 
}



-(void)didCityInfoResult:(NSArray *)cityArray
{
}
- (void)didBasicInfoResult:(NSDictionary *)dic
{
    NSLog(@"统一配置返回");
    NSString * errorMessage = [dic objectForKey:@"errorMessage"];
    
    if (errorMessage) {
        [self._backgroundImage removeFromSuperview];
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@%@",NetFailMessage,errorMessage] Title:@"提示"];
        if (!self._hasFirstImages) {
            [self showHome];
        }
        else{
            [activityIV removeFromSuperview];
        }
    }
    else {
        NSLog(@"是否注册：%@", [GetConfiguration shareGetConfiguration]._isFirst);
        [[NSUserDefaults standardUserDefaults] setObject:[GetConfiguration shareGetConfiguration]._isFirst forKey:keyAudioRegister];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        if ([[GetConfiguration shareGetConfiguration]._version._mandatoryCode intValue] > MyVersionCode) {
            
            [[VersionView shareVersionView] hideCancelButton];
            [VersionView shareVersionView].versionView.text = [GetConfiguration shareGetConfiguration]._version._desc;
            [[VersionView shareVersionView] showVersionView];
            [activityIV removeFromSuperview];
        }
        else if ([[GetConfiguration shareGetConfiguration]._version._code intValue] > MyVersionCode){
            
            [VersionView shareVersionView].delegate = self;
            [VersionView shareVersionView].versionView.text = [GetConfiguration shareGetConfiguration]._version._desc;
            [[VersionView shareVersionView] showVersionView];
            [activityIV removeFromSuperview];
        }
        else
        {
            [self._backgroundImage removeFromSuperview];
            if (!self._hasFirstImages) {
                [self showHome];
            }
            else{
                [activityIV removeFromSuperview];
            }
        }
    }
}

- (void)removeVersionView
{
    [VersionView shareVersionView].delegate = nil;
//    [activityIV removeFromSuperview];
    [self._backgroundImage removeFromSuperview];
    if (!self._hasFirstImages) {
        [self showHome];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

        if (buttonIndex == 0) {
            NSString *updateurl = @"https://itunes.apple.com/us/app/la-jiao-you-ge-ren-ban/id932263889?l=zh&ls=1&mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateurl]];
            exit(0);
        }
        else {
            [activityIV removeFromSuperview];
            [self._backgroundImage removeFromSuperview];
            if (!self._hasFirstImages) {
                [self showHome];
            }
        }
}

//评分 崔立东 2013年3月5日添加
-(void)toFirstGrade  
{
	[[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:keyShowGrade];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"亲，喜欢辣郊游就给我们的新版本评分吧！" delegate:self cancelButtonTitle:@"不，谢谢！" otherButtonTitles:@"去评分",nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if (buttonIndex == 1)
	{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",433135814 ]]]; 
		
	}
	else
	{
		return;
	}
}

-(void)showHome
{
    NSNumber *audioLogin = [[NSUserDefaults standardUserDefaults]  objectForKey:keyAudioLogin];
    if([audioLogin intValue] == 1)
    {
        NSString *loginType =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGINTYPE];
        if([loginType isEqualToString:@"LJY"])
        {
            NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginUserName];
            NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginPassword];
            
            ASIFormDataRequest * theRequest = [InterfaceClass userLogin:name password:password];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserLoginPaseredResult:) Delegate:self needUserType:Default];
        }
        else
        {
            NSString *account = [NSString string];
            NSString *token = [NSString string];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *loginType =  [defaults objectForKey:LOGINTYPE];
            NSString *type = [NSString string];
            
            if([loginType isEqualToString:@"QQ"])
            {
                account = [defaults objectForKey:QQID];
                token = [defaults objectForKey:QQToken];
                type = [NSString stringWithFormat:@"1"];
            }
            else
            {
                NSDictionary *weiboData = [defaults objectForKey:SinaWeiboAuthData];
                account = [weiboData objectForKey:@"UserIDKey"];
                token = [weiboData objectForKey:@"AccessTokenKey"];
                type = [NSString stringWithFormat:@"2"];
            }
            
            ASIFormDataRequest * theRequest = [InterfaceClass userLoginOther:account type:type token:token];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserLoginOtherResult:) Delegate:self needUserType:Default];
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(showShopType)]) {
            [self.delegate performSelector:@selector(showShopType)];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(showServiceTags)]) {
            [self.delegate performSelector:@selector(showServiceTags)];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(showBaiduMap)]) {
            [self.delegate performSelector:@selector(showBaiduMap)];
        }
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(void)onUserLoginPaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] intValue] == 0)
    {
        [UserLogin sharedUserInfo].tags = [UserLogin GetUserLogin:dic].tags;
        
        [UserLogin sharedUserInfo].userID = [dic objectForKey:@"userId"];
        
        [UserLogin sharedUserInfo]._userName = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginUserName];
        
        [UserLogin sharedUserInfo].passWord = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginPassword];
    }
    else
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];//自动登陆失败后弹出提示
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(showShopType)]) {
        [self.delegate performSelector:@selector(showShopType)];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(showServiceTags)]) {
        [self.delegate performSelector:@selector(showServiceTags)];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(showBaiduMap)]) {
        [self.delegate performSelector:@selector(showBaiduMap)];
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:NO];

}

-(void)onUserLoginOtherResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] intValue] == 0)
    {
        [UserLogin sharedUserInfo].tags = [UserLogin GetUserLogin:dic].tags;
        
        [UserLogin sharedUserInfo].userID = [dic objectForKey:@"userId"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] forKey:keyLoginUserID];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:keyAudioLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];//自动登陆失败后弹出提示
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(showShopType)]) {
        [self.delegate performSelector:@selector(showShopType)];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(showServiceTags)]) {
        [self.delegate performSelector:@selector(showServiceTags)];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(showBaiduMap)]) {
        [self.delegate performSelector:@selector(showBaiduMap)];
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:NO];

}

-(void)showRegister
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    MemberRegisterViewController * vc = [[MemberRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    [self performSelector:@selector(deleteWelecom)];
}
-(void) deleteWelecom
{
    NSMutableArray * mArray = [NSMutableArray array];
    [mArray addObjectsFromArray:self.navigationController.viewControllers];
    [mArray removeObjectAtIndex:[mArray count]-2];
    self.navigationController.viewControllers = mArray;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end

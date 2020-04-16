//
//  MemberRegisterViewController.m
//  LJYCProject
//





//  Created by xiemengyue on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MemberRegisterViewController.h"
#import "MemberLoginViewController.h"
#import "VerificationViewController.h"
#import "VerifyUserNameViewController.h"
#import "MyRegex.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/WeiyunAPI.h>
#import "SinaWeiBoExtend.h"
#import "JSON.h"
#import "ServiceTermViewController.h"
#import "MemberHomeViewController.h"
@interface MemberRegisterViewController ()

@end

@implementation MemberRegisterViewController
@synthesize userNameTF,passWordTF,swichBtn;
@synthesize showPWD,userName,userID,textFieldArray,keyboardbar,delegate;
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
    self.userNameTF = nil;
    self.passWordTF = nil;
    self.swichBtn = nil;
    
    self.userID = nil;
    self.userName = nil;
    
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    
    self.delegate = nil;
    
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"用户注册";
    self.showPWD = NO;

    
    //界面
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, ViewWidth-40, 215) image:[UIImage imageNamed:@"白背景.png"]]];

    self.userNameTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 35, 250, 40) leftImage:[UIImage imageNamed:@"白头像.png"] isMustFillIn:YES placeholder:@"请输入用户名" delegate:self];
    self.userNameTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTF.textFiled.tag = 1;
    [self.view_IOS7 addSubview:self.userNameTF];

    self.passWordTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 80, 250, 40) leftImage:[UIImage imageNamed:@"白锁.png"] isMustFillIn:YES placeholder:@"请输入6-20位字符" delegate:self];
    self.passWordTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordTF.textFiled.secureTextEntry = YES;
    self.passWordTF.textFiled.tag = 2;
    [self.view_IOS7 addSubview:self.passWordTF];
    
    UIButton *button = [UIButton customButtonTitle:nil tag:0 image:[UIImage imageNamed:@"NO.png"] frame:CGRectMake(35, 130, 70, 25) target:self action:@selector(showPWD:)];
    self.swichBtn = button;
    [self.view_IOS7 addSubview:self.swichBtn];

    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"显示密码" frame:CGRectMake(110, 132, 80, 20) font:FontSize24 color:FontColor1B77C3 alignment:NSTextAlignmentLeft]];
    
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"注册" backImage:[UIImage imageNamed:@"登录.png"] frame:CGRectMake(35, 165, 250, 45) font:FontSize36 color:FontColorFFFFFF target:self action:@selector(userRegister:)]];
    
//    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"免费注册（注册即送50畅达币）" frame:CGRectMake(35, 210, 250, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentCenter]];
    
//    [self.view_IOS7 addSubview:[UIButton customButtonTitle:nil tag:3 image:[UIImage imageNamed:@"QQ登录.png"] frame:CGRectMake(20, 275, ViewWidth-40, 44) target:self action:@selector(QQLogin:)]];
//    [self.view_IOS7 addSubview:[UIButton customButtonTitle:nil tag:4 image:[UIImage imageNamed:@"微博登录.png"] frame:CGRectMake(20, 329, ViewWidth-40, 44) target:self action:@selector(sinaLogin:)]];


    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"点击注册表示已阅读并同意" frame:CGRectMake(25, 235, 250, 40) font:FontSize28 color:FontColor979797 alignment:NSTextAlignmentLeft]];
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:104 title:@"用户服务协议" backImage:nil frame:CGRectMake(188, 235, 100, 40) font:FontSize28 color:FontColorRed target:self action:@selector(serviceAgreement)]];
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(283, 248, 10,10) image:[UIImage imageNamed:@"已阅读.png"]]];
    
    
    self.textFieldArray = [NSArray arrayWithObjects:self.userNameTF.textFiled,self.passWordTF.textFiled, nil];
}

#pragma mark-服务协议
-(void)serviceAgreement
{
    ServiceTermViewController *serviceAgreementVC = [[ServiceTermViewController alloc] init];
    [self.navigationController pushViewController:serviceAgreementVC animated:YES];
    [serviceAgreementVC release];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 2 && ![string isMatchedByRegex:PASSWARD] && string.length != 0 )
        return NO;
    
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
    
    if(textField.tag == 1 && textFieldStrLength > 30)
        return NO;
    else if(textField.tag == 2 && textFieldStrLength > 20)
    {
        [UIAlertView alertViewWithMessage:@"请输入6-20位密码！"];
        return NO;
    }
    return YES;
}

-(void)showPWD:(UIButton*)sender
{
    
    if(self.showPWD)
    {
        [self.swichBtn setImage:[UIImage imageNamed:@"NO.png"] forState:UIControlStateNormal];
        self.passWordTF.textFiled.secureTextEntry = YES;
    }
    else
    {
        [self.swichBtn setImage:[UIImage imageNamed:@"YES.png"] forState:UIControlStateNormal];
        self.passWordTF.textFiled.secureTextEntry = NO;
    }
    self.showPWD = !self.showPWD;
}

-(void)userRegister:(UIButton*)sender
{
    [UserLogin sharedUserInfo]._userName = userNameTF.textFiled.text;
 
    if([self.userNameTF.textFiled.text length] == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入用户名！"];
        return;
    }
    else if([self.passWordTF.textFiled.text length] == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入密码！"];
        return;
    }
    else if (passWordTF.textFiled.text.length <6 )
    {
        [UIAlertView alertViewWithMessage:@"请输入6-20位密码！"];
        return;
    }
    else if(![passWordTF.textFiled.text isMatchedByRegex:PASSWARD])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的密码！"];
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass userRegister:userNameTF.textFiled.text password:passWordTF.textFiled.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserRegisterPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onUserRegisterPaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] integerValue] != 0)
    {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    
    
    self.userID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]];
    [UserLogin sharedUserInfo].userID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]];
    [UserLogin sharedUserInfo].passWord = [NSString stringWithFormat:@"%@",passWordTF.textFiled.text];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.userNameTF.textFiled.text forKey:keyLoginUserName];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"LJY"] forKey:LOGINTYPE];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    
    VerificationViewController *verificationVC = [[VerificationViewController alloc] init];
    verificationVC.delegate = self.delegate;
    [self.navigationController pushViewController:verificationVC animated:YES];
    [verificationVC release];

}

-(void)QQLogin:(UIButton*)sender
{
    NSString *myQQID = [NSString  stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:QQID]];
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:QQID] isKindOfClass:[NSString class]] || myQQID.length == 0)
    {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAPPID andDelegate:self];
        NSArray *permissions = [[NSArray arrayWithObjects:@"all",  nil] retain];
        [_tencentOAuth authorize:permissions inSafari:NO];
    }
   else
   {
       [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:keyAudioLogin];
       [[NSUserDefaults standardUserDefaults] synchronize];
       
       [UserLogin sharedUserInfo].userID =  [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginUserID];
       [self removeViews];
       if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul:)]) {
           [self.delegate performSelector:@selector(loginSuccessFul:)];
       }
       
   }
}

-(void)sinaLogin:(UIButton*)sender
{
    NSDictionary *weiboData = [[NSUserDefaults standardUserDefaults] objectForKey:SinaWeiboAuthData];
    NSString * account = [weiboData objectForKey:@"UserIDKey"];
    
    if(account.length == 0 || ![[weiboData objectForKey:@"UserIDKey"] isKindOfClass:[NSString class]])//本地没有保存新浪微博登录信息
        [SinaWeiBoExtend sina_logIn:self Sel:@selector(onlogInResult:)];
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:keyAudioLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [UserLogin sharedUserInfo].userID =  [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginUserID];
        
        [self removeViews];
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul:)]) {
            [self.delegate performSelector:@selector(loginSuccessFul:)];
        }
    }
}

-(void)removeViews
{
    NSMutableArray * mArray = [NSMutableArray array];
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        
        if (!([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberLoginViewController class]] || [[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberRegisterViewController class]]))
        {
            [mArray addObject:[self.navigationController.viewControllers objectAtIndex:i]];
        }
	}
	self.navigationController.viewControllers = mArray;
    
}

#pragma mark-QQ
- (void)tencentDidLogin
{
    NSLog(@"%@",[_tencentOAuth openId]);
    NSLog(@"%@",[_tencentOAuth accessToken]);
    NSLog(@"%@",[_tencentOAuth expirationDate]);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[_tencentOAuth openId]] forKey:QQID];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[_tencentOAuth accessToken]] forKey:QQToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if([_tencentOAuth getUserInfo])
    {
        [WaitView showWaitView];
        NSLog(@"正在获取用户信息");
    }
    else
    {
        NSLog(@"获取失败");
        [self showInvalidTokenOrOpenIDMessage];
    }
}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}

//非网络错误导致登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    [WaitView hiddenWaitView];
    NSDictionary *dic = response.jsonResponse;
    
    self.userName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickname"]];
    if(self.userName.length > 0 && ![self.userName isKindOfClass:[NSNull class]])
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"QQ"] forKey:LOGINTYPE];
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:QQNAME];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self isEmpower];
    }
}

#pragma mark-WB
-(void)onlogInResult:(SinaWeibo *)sinaweibo
{
    NSLog(@"%@",sinaweibo.userID);
    NSLog(@"%@",[SinaWeiBoExtend sina_userID]);
    
    if([SinaWeiBoExtend sina_userID].length != 0)
    [SinaWeiBoExtend sina_usersShow:self Sel:@selector(onUsersShowResult:)];
    
}

-(void)onUsersShowResult:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
    self.userName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
    
    if(self.userName.length > 0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"WEIBO"] forKey:LOGINTYPE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self isEmpower];
    }

}

#pragma mark-isEmpower
-(void)isEmpower
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

-(void)onUserLoginOtherResult:(NSDictionary*)dic
{
    [UserLogin GetUserLogin:dic];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] forKey:keyLoginUserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"isEmpower"]] isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:keyAudioLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self removeViews];
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul:)]) {
            [self.delegate performSelector:@selector(loginSuccessFul:)];
        }
    }
    else
    {
        VerifyUserNameViewController *verifyUserNameVC = [[VerifyUserNameViewController alloc] init];
        verifyUserNameVC.userName = self.userName;
        verifyUserNameVC.delegate = self.delegate;
        [self.navigationController pushViewController:verifyUserNameVC animated:YES];
        [verifyUserNameVC release];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

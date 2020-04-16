//
//  BoundPhoneViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "BoundPhoneViewController.h"
#import "UserLogin.h"
#import "InterfaceClass.h"
#import "MyRegex.h"
@interface BoundPhoneViewController ()

@end

@implementation BoundPhoneViewController
@synthesize showSecond;
@synthesize phoneNumTF,verificationNumTF;
@synthesize textFieldArray,keyboardbar;
@synthesize shopForOrderVC;

- (void)dealloc
{
    self.showSecond = nil;
    
    self.phoneNumTF = nil;
    self.verificationNumTF = nil;
    
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self.shopForOrderVC =nil;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = ([UserLogin sharedUserInfo]._telephone.length == 11)?@"解除绑定" :@"绑定手机号";
	// Do any additional setup after loading the view.
    //界面
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, ViewWidth-40, 290) image:[UIImage imageNamed:@"白背景.png"]]];
    
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(35, 35, 250, 40) image:[UIImage imageNamed:@"绑定手机号.png"]]];
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:[UserLogin sharedUserInfo]._userName frame:CGRectMake(85, 35, 250, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];

    
    self.phoneNumTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 80, 250, 40) leftImage:[UIImage imageNamed:@"绑定1.png"] isMustFillIn:YES placeholder:@"请输入11位有效手机号码" delegate:self];
    self.phoneNumTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumTF.textFiled.tag = 1;
    self.phoneNumTF.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTF.textFiled.delegate = self;
    [self.view_IOS7 addSubview:self.phoneNumTF];
    
    self.verificationNumTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 125, 165, 40) leftImage:[UIImage imageNamed:@"白验证码.png"] isMustFillIn:YES placeholder:@"请输入验证码" delegate:self];
    self.verificationNumTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verificationNumTF.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.verificationNumTF.textFiled.tag = 2;
    self.verificationNumTF.textFiled.delegate = self;
    [self.view_IOS7 addSubview:self.verificationNumTF];
    
    self.getVerificationBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"获取验证码"  backImage:[UIImage imageNamed:@"验证码1.png"] frame:CGRectMake(210, 125, 75, 40) font:FontSize24 color:FontColor1B77C3 target:self action:@selector(getVerificationNum:)];
    [self.getVerificationBtn setBackgroundImage:[UIImage imageNamed:@"验证码2.png"] forState:UIControlStateHighlighted];
    [self.view_IOS7 addSubview:self.getVerificationBtn];
    
    self.showSecond = [UISubLabel labelWithTitle:@"" frame:CGRectMake(215.0f, 130.0f, 60.0f, 30.0f) font:FontBlodSize36 alignment:NSTextAlignmentCenter];
	self.showSecond.textColor = FontColorABABAB;
	self.showSecond.hidden = YES;
	[self.view_IOS7 addSubview:self.showSecond];
    
    
    
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"确认" backImage:[UIImage imageNamed:@"登录.png"] frame:CGRectMake(35, 185, 250, 45) font:FontSize36 color:FontColor1B77C3 target:self action:@selector(submit:)]];
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"1、可做为用户名登录；\n2、可以做为找回密码的凭证；\n3、可以获取更多积分。" frame:CGRectMake(35, 200, 250, 150) font:FontSize26 color:FontColor696969 alignment:NSTextAlignmentLeft]];
    
    
    
    if([UserLogin sharedUserInfo]._telephone.length == 11)
    {
        self.phoneNumTF.textFiled.text = [UserLogin sharedUserInfo]._telephone;
        self.phoneNumTF.textFiled.enabled = NO;
        self.textFieldArray = [NSArray arrayWithObjects:self.verificationNumTF.textFiled, nil];
    }
    else
        self.textFieldArray = [NSArray arrayWithObjects:self.phoneNumTF.textFiled,self.verificationNumTF.textFiled, nil];
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
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
    
    if(textField.tag == 1 && textFieldStrLength >11)
        return NO;
    else if(textField.tag == 2 && textFieldStrLength > 4)
        return NO;
    else if(textFieldStrLength > 30)
        return NO;
    return YES;
}

-(void)getVerificationNum:(UIButton*)sender
{
    if(![self.phoneNumTF.textFiled.text isMatchedByRegex:PHONENO])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的手机号"];
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass getCheckCode:phoneNumTF.textFiled.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetCheckCodePaseredResult:) Delegate:self needUserType:Default];
}


-(void)onGetCheckCodePaseredResult:(NSDictionary*)dic
{
    if(![[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
    }
    else
    {
        [self startTimer];
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
    }
}


//启动定时器
- (void)startTimer
{
	self.times= 61;
	_timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES] retain];
}
//执行自定义逻辑
- (void)onTimer
{
    
	self.times--;
	if (self.times == 60) {
		self.showSecond.hidden = NO;
        self.getVerificationBtn.enabled = NO;
        [self.getVerificationBtn setTitle:@"" forState:UIControlStateNormal];
	}
	self.showSecond.text = [NSString stringWithFormat:@"（%d）",self.times];
	if (self.times ==0) {
		self.showSecond.hidden = YES;
        self.getVerificationBtn.enabled = YES;
        [self.getVerificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
		[self stopTimer];
	}
	
}


//废弃定时器
- (void)stopTimer
{
	if(_timer != nil){
		[_timer invalidate];
		[_timer release];
		_timer = nil;
	}
}




-(void)submit:(UIButton*)sender
{
    if(self.phoneNumTF.textFiled.text.length != 11)
    {
        [UIAlertView alertViewWithMessage:@"请输入11位有效手机号码!"];
        return;
    }
    else if(self.verificationNumTF.textFiled.text.length < 4 || self.verificationNumTF.textFiled.text.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"验证码请输入4位有效数字!"];
        return;
    }
    else if (self.verificationNumTF.textFiled.text.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入验证码!"];
        return;
    }
    else if (![self.phoneNumTF.textFiled.text isMatchedByRegex:PHONENO])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的手机号!"];
        return;
    }
    
    
    if([self.title isEqualToString:@"绑定手机号"])
    {
        ASIFormDataRequest * theRequest = [InterfaceClass userBinding:[UserLogin sharedUserInfo].userID telephone:self.phoneNumTF.textFiled.text checkCode:self.verificationNumTF.textFiled.text referee:nil];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserBinding:) Delegate:self needUserType:Default];
    }
    else
    {
        ASIFormDataRequest * theRequest = [InterfaceClass userDelBinding:[UserLogin sharedUserInfo].userID telephone:self.phoneNumTF.textFiled.text checkCode:self.verificationNumTF.textFiled.text];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserDelBinding:) Delegate:self needUserType:Default];
    }
}

-(void)onUserBinding:(NSDictionary*)dic
{
    [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];

    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] isEqualToString:@"0"])
    {
        [self.shopForOrderVC changePhoneNum:self.phoneNumTF.textFiled.text];
        [UserLogin sharedUserInfo]._telephone = self.phoneNumTF.textFiled.text;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)onUserDelBinding:(NSDictionary*)dic
{
    [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];

    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        [UserLogin sharedUserInfo]._telephone = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

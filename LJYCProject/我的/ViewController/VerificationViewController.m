//
//  VerificationViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-31.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "VerificationViewController.h"
#import "MemberHomeViewController.h"
#import "UserLogin.h"
#import "MemberLoginViewController.h"
#import "MemberRegisterViewController.h"
#import "InterfaceClass.h"
#import "MyRegex.h"
@interface VerificationViewController ()

@end

@implementation VerificationViewController
@synthesize times,phoneNumTF,verificationNumTF,referrerTF,showSecond;
@synthesize textFieldArray,keyboardbar,delegate;
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
    self.phoneNumTF = nil;
    self.verificationNumTF = nil;
    self.referrerTF = nil;
    
    self.showSecond = nil;
    
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    
    self.delegate = nil;
    
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"账号验证";
    
    //界面
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, ViewWidth-40, 230) image:[UIImage imageNamed:@"白背景.png"]]];
    
    self.phoneNumTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 35, 250, 40) leftImage:[UIImage imageNamed:@"白手机.png"] isMustFillIn:YES placeholder:@"请输入11位有效手机号码" delegate:self];
    self.phoneNumTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumTF.textFiled.tag = 1;
    self.phoneNumTF.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTF.textFiled.delegate = self;
    [self.view_IOS7 addSubview:self.phoneNumTF];
    
    self.verificationNumTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 80, 165, 40) leftImage:[UIImage imageNamed:@"白验证码.png"] isMustFillIn:YES placeholder:@"请输入验证码" delegate:self];
    self.verificationNumTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verificationNumTF.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.verificationNumTF.textFiled.tag = 2;
    self.phoneNumTF.textFiled.delegate = self;
    [self.view_IOS7 addSubview:self.verificationNumTF];
    
    self.referrerTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 125, 250, 40) leftImage:[UIImage imageNamed:@"白头像.png"] isMustFillIn:NO placeholder:@"请输入推荐人用户名" delegate:self];
    self.referrerTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.referrerTF.textFiled.tag = 3;
    self.referrerTF.textFiled.delegate = self;
    [self.view_IOS7 addSubview:self.referrerTF];
    
    self.getVerificationBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"获取验证码" backImage:[UIImage imageNamed:@"验证码1.png"] frame:CGRectMake(210, 80, 75, 40) font:FontSize24 color:FontColor1B77C3 target:self action:@selector(getCheckCode:)];
    [self.getVerificationBtn setBackgroundImage:[UIImage imageNamed:@"验证码2.png"] forState:UIControlStateHighlighted];
    [self.view_IOS7 addSubview:self.getVerificationBtn];
    
    self.showSecond = [UISubLabel labelWithTitle:@"" frame:CGRectMake(215.0f, 85.0f, 60.0f, 30.0f) font:FontBlodSize36 alignment:NSTextAlignmentCenter];
	self.showSecond.textColor = FontColorABABAB;
	self.showSecond.hidden = YES;
	[self.view_IOS7 addSubview:self.showSecond];
    
    
    self.jumpBtn =[UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"跳过" backImage:[UIImage imageNamed:@"跳过1.png"] frame:CGRectMake(35, 185, 83, 45) font:FontSize36 color:FontColor1B77C3 target:self action:@selector(jump:)];
    [self.jumpBtn setBackgroundImage:[UIImage imageNamed:@"跳过2.png"] forState:UIControlStateHighlighted];
    [self.view_IOS7 addSubview:self.jumpBtn];
    
    
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"确认" backImage:[UIImage imageNamed:@"登录.png"] frame:CGRectMake(135, 185, 150, 45) font:FontSize36 color:FontColorFFFFFF target:self action:@selector(submit:)]];
    

    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"温馨提示\n我们可以为通过手机号码验证的用户提供以下服务：\n1、可做为用户名登录；\n2、可以做为找回密码的凭证；\n3、可以获取更多积分；\n4、给您的推荐人发送积分。" frame:CGRectMake(35, 260, 250, 150) font:FontSize26 color:FontColor696969 alignment:NSTextAlignmentLeft]];
    
    self.textFieldArray = [NSArray arrayWithObjects:self.phoneNumTF.textFiled,self.verificationNumTF.textFiled,self.referrerTF.textFiled, nil];
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
    
    if(textField.tag == 1 && textFieldStrLength > 11)
        return NO;
    else if(textField.tag == 2 && textFieldStrLength >4)
        return NO;
    else if(textField.tag == 3  && textFieldStrLength > 30)
        return NO;
    return YES;
}

-(void)getCheckCode:(UIButton*)sender
{
    if(self.phoneNumTF.textFiled.text.length != 11)
    {
        [UIAlertView alertViewWithMessage:@"请输入11位有效手机号码!"];
        return;
    }
    else if (![self.phoneNumTF.textFiled.text isMatchedByRegex:PHONENO])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的手机号!"];
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass getCheckCode:phoneNumTF.textFiled.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetCheckCodePaseredResult:) Delegate:self needUserType:Default];
    
}

-(void)onGetCheckCodePaseredResult:(NSDictionary*)dic
{
    [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    [self startTimer];
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
    
    ASIFormDataRequest * theRequest = [InterfaceClass userBinding:[UserLogin sharedUserInfo].userID telephone:self.phoneNumTF.textFiled.text checkCode:self.verificationNumTF.textFiled.text referee:referrerTF.textFiled.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserBinding:) Delegate:self needUserType:Default];
    
}

-(void)onUserBinding:(NSDictionary*)dic
{
    if([ [NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]]integerValue] == 0)
    {
        
        [UserLogin sharedUserInfo]._telephone = phoneNumTF.textFiled.text;
        
        [self removeLoginView];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul:)]) {
            [self.delegate performSelector:@selector(loginSuccessFul:) withObject:nil];
        }
    }
    else
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
        return;
    }
}

-(void)jump:(UIButton*)sender
{
    [self removeLoginView];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul:)]) {
		[self.delegate performSelector:@selector(loginSuccessFul:) withObject:nil];
	}
}

-(void)removeLoginView
{
    NSMutableArray * mArray = [NSMutableArray array];
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        if (!([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberLoginViewController class]] || [[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberRegisterViewController class]] || [[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[VerificationViewController class]]))
        {
            [mArray addObject:[self.navigationController.viewControllers objectAtIndex:i]];
        }
	}
	self.navigationController.viewControllers = mArray;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

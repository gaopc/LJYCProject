//
//  ResetPasswordViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "InterfaceClass.h"
#import "MyRegex.h"
@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController
@synthesize showPWD,showSecond;
@synthesize phoneNumTF,verificationNumTF,passwordNumTF,swichBtn,getVerificationBtn;
@synthesize textFieldArray,keyboardbar;
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
    self.passwordNumTF = nil;
    self.swichBtn = nil;
    self.getVerificationBtn = nil;
    
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    
    self.showSecond = nil;
    
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"重置密码";
    self.showPWD = NO;
	// Do any additional setup after loading the view.
    
    //界面
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, ViewWidth-40, 240) image:[UIImage imageNamed:@"白背景.png"]]];
    
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
    self.verificationNumTF.textFiled.delegate = self;
    [self.view_IOS7 addSubview:self.verificationNumTF];
    
    self.passwordNumTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 125, 250, 40) leftImage:[UIImage imageNamed:@"白锁.png"] isMustFillIn:YES placeholder:@"请输入6-12位新密码" delegate:self];
    self.passwordNumTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordNumTF.textFiled.secureTextEntry = YES;
    self.passwordNumTF.textFiled.tag = 3;
    self.passwordNumTF.textFiled.delegate = self;
    [self.view_IOS7 addSubview:self.passwordNumTF];
    

    self.getVerificationBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"获取验证码" backImage:[UIImage imageNamed:@"验证码1.png"] frame:CGRectMake(210, 80, 75, 40) font:FontSize24 color:FontColor1B77C3 target:self action:@selector(getCheckCode:)];
    [self.getVerificationBtn setBackgroundImage:[UIImage imageNamed:@"验证码2.png"] forState:UIControlStateHighlighted];
    [self.view_IOS7 addSubview:self.getVerificationBtn];
    
    self.showSecond = [UISubLabel labelWithTitle:@"" frame:CGRectMake(215.0f, 85.0f, 60.0f, 30.0f) font:FontBlodSize36 alignment:NSTextAlignmentCenter];
	self.showSecond.textColor = FontColorABABAB;
	self.showSecond.hidden = YES;
	[self.view_IOS7 addSubview:self.showSecond];
    
    
    
    UIButton *button = [UIButton customButtonTitle:nil tag:0 image:[UIImage imageNamed:@"NO.png"] frame:CGRectMake(35, 175, 70, 20) target:nil action:@selector(showPWD:)];
    self.swichBtn = button;
    [self.view_IOS7 addSubview:self.swichBtn];
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"显示密码" frame:CGRectMake(110, 175, 40, 20) font:FontSize16 color:FontColor1B77C3 alignment:NSTextAlignmentLeft]];
    
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"确认" backImage:[UIImage imageNamed:@"登录.png"] frame:CGRectMake(35, 205, 250, 45) font:FontSize36 color:FontColorFFFFFF target:self action:@selector(submit:)]];
    
    self.textFieldArray = [NSArray arrayWithObjects:self.phoneNumTF.textFiled,self.verificationNumTF.textFiled,self.passwordNumTF.textFiled, nil];
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
    if([ [NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]]isEqualToString:@"0"])
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


-(void)showPWD:(UIButton*)sender
{
    
    if(self.showPWD)
    {
        [self.swichBtn setImage:[UIImage imageNamed:@"NO.png"] forState:UIControlStateNormal];
        self.passwordNumTF.textFiled.secureTextEntry = YES;
    }
    else
    {
        [self.swichBtn setImage:[UIImage imageNamed:@"YES.png"] forState:UIControlStateNormal];
        self.passwordNumTF.textFiled.secureTextEntry = NO;
    }
    self.showPWD = !self.showPWD;
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
    if(textField.tag == 3 && ![string isMatchedByRegex:PASSWARD] && string.length != 0 )
        return NO;
    
    
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
    
    if(textField.tag == 1 && textFieldStrLength > 11)
        return NO;
    else if(textField.tag == 2 && textFieldStrLength > 4)
        return NO;
    else if (textField.tag == 3 && textFieldStrLength > 20)
    {
        [UIAlertView alertViewWithMessage:@"请输入6-20位密码！"];
        return NO;
    }
    
    return YES;
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
    else if (passwordNumTF.textFiled.text.length <6 )
    {
        [UIAlertView alertViewWithMessage:@"请输入6-20位密码！"];
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
    else if([self.passwordNumTF.textFiled.text length] == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入密码！"];
        return;
    }
    else if(![passwordNumTF.textFiled.text isMatchedByRegex:PASSWARD])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的密码！"];
        return;
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass resetPWDWithTelePhone:self.phoneNumTF.textFiled.text password:self.passwordNumTF.textFiled.text checkCode:self.verificationNumTF.textFiled.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onResetPWDPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onResetPWDPaseredResult:(NSDictionary*)dic
{
    [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

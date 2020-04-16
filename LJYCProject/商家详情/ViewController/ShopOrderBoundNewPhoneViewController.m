//
//  ShopOrderBoundNewPhoneViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 14-3-12.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "ShopOrderBoundNewPhoneViewController.h"
#import "MyRegex.h"
#import "ShopOrderBoundPhoneViewController.h"
@interface ShopOrderBoundNewPhoneViewController ()

@end

@implementation ShopOrderBoundNewPhoneViewController
@synthesize getVerificationBtn,showSecond;
@synthesize phoneNumTF,verificationNumTF;
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
    self.getVerificationBtn = nil;
    self.showSecond = nil;
    self.phoneNumTF = nil;
    self.verificationNumTF = nil;
    
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"修改手机号";
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, 230) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [self.view_IOS7 addSubview:backView];
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"验证码将发送到新手机上" frame:CGRectMake(10,10,300,30) font:FontSize28 color:FontColor454545 alignment:NSTextAlignmentLeft]];
    
    UIImageView *backView2 = [UIImageView ImageViewWithFrame:CGRectMake(0, 45, 320, 80) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [self.view_IOS7 addSubview:backView2];
    
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"新手机号" frame:CGRectMake(10,50,100,30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft]];
    self.phoneNumTF = [UISubTextField TextFieldWithFrame:CGRectMake(80,50,200,30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入新手机号" font:FontSize32];
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"验证码" frame:CGRectMake(10,90,100,30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft]];
    self.verificationNumTF = [UISubTextField TextFieldWithFrame:CGRectMake(80,90,150,30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"验证码" font:FontSize32];
    
    
    self.getVerificationBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"获取验证码"  backImage:nil frame:CGRectMake(219, 86, 90, 40) font:FontSize32 color:[UIColor orangeColor] target:self action:@selector(getVerificationNum:)];
    [self.view_IOS7 addSubview:self.getVerificationBtn];
    
    
    self.showSecond = [UISubLabel labelWithTitle:@"" frame:CGRectMake(220.0f, 90.0f, 95.0f, 30.0f) font:FontSize36 alignment:NSTextAlignmentCenter];
	self.showSecond.textColor = FontColorABABAB;
	self.showSecond.hidden = YES;
	[self.view_IOS7 addSubview:self.showSecond];
    
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithframe:CGRectMake(0, 85, 320, 1) backgroundColor:FontColorDADADA]];
    [self.view_IOS7 addSubview:[UISubLabel labelWithframe:CGRectMake(0, 125, 320, 1) backgroundColor:FontColorDADADA]];
    [self.view_IOS7 addSubview:[UISubLabel labelWithframe:CGRectMake(213, 85, 1, 40) backgroundColor:FontColorDADADA]];
    
    
    self.phoneNumTF.tag = 1;
    self.phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    self.verificationNumTF.tag = 2;
    self.verificationNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view_IOS7 addSubview:self.phoneNumTF];
    [self.view_IOS7 addSubview:self.verificationNumTF];
    
    UIButton *boundBut = [CoustomButton buttonWithOrangeColor:CGRectMake(20, 155, 280, 45) target:self action:@selector(bound:) title:@"绑定"];
    [self.view_IOS7 addSubview:boundBut];
    
    self.phoneNumTF.delegate = self;
    self.verificationNumTF.delegate = self;
    self.textFieldArray = [NSArray arrayWithObjects:self.phoneNumTF,self.verificationNumTF, nil];
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
    if(![self.phoneNumTF.text isMatchedByRegex:PHONENO])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的手机号"];
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass getCheckCode:phoneNumTF.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetCheckCodePaseredResult:) Delegate:self needUserType:Default];
    
    [self startTimer];
}


-(void)onGetCheckCodePaseredResult:(NSDictionary*)dic
{
    if(![[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
    }
    else
    {
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
	self.showSecond.text = [NSString stringWithFormat:@"已发送 %dS",self.times];
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


-(void)bound:(UIButton*)sender
{
    if(self.phoneNumTF.text.length != 11)
    {
        [UIAlertView alertViewWithMessage:@"请输入11位有效手机号码!"];
        return;
    }
    else if(self.verificationNumTF.text.length < 4 || self.verificationNumTF.text.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"验证码请输入4位有效数字!"];
        return;
    }
    else if (self.verificationNumTF.text.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入验证码!"];
        return;
    }
    else if (![self.phoneNumTF.text isMatchedByRegex:PHONENO])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的手机号!"];
        return;
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass userBinding:[UserLogin sharedUserInfo].userID telephone:self.phoneNumTF.text checkCode:self.verificationNumTF.text referee:nil];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onExamineCheckCode:) Delegate:self needUserType:Default];
}

-(void)onExamineCheckCode:(NSDictionary*)dic
{
    
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] isEqualToString:@"0"])
    {
        [UserLogin sharedUserInfo]._telephone = phoneNumTF.text;
        [self.shopForOrderVC changePhoneNum:phoneNumTF.text];
        [self.navigationController popToViewController:self.shopForOrderVC animated:YES];
    }
    else
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

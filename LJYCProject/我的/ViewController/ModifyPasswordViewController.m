//
//  ModifyPasswordViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "MyRegex.h"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController
@synthesize swichBtn,newPassWordTF,oldPassWordTF;
@synthesize showPWD,myUserLogin,textFieldArray,keyboardbar;
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
    self.swichBtn = nil;
    self.newPassWordTF = nil;
    self.oldPassWordTF = nil;
    self.myUserLogin = nil;
    
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改密码";
    self.showPWD = NO;
    
	// Do any additional setup after loading the view.
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, ViewWidth-40, 205) image:[UIImage imageNamed:@"白背景.png"]]];

    self.oldPassWordTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 35, 250, 40) leftImage:[UIImage imageNamed:@"白锁.png"] isMustFillIn:YES placeholder:@"请输入当前密码" delegate:self];
    self.oldPassWordTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldPassWordTF.textFiled.secureTextEntry = YES;
    self.oldPassWordTF.textFiled.tag = 1;
    [self.view_IOS7 addSubview:self.oldPassWordTF];
    
    self.newPassWordTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 80, 250, 40) leftImage:[UIImage imageNamed:@"白锁.png"] isMustFillIn:YES placeholder:@"请输入新密码" delegate:self];
    self.newPassWordTF.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.newPassWordTF.textFiled.secureTextEntry = YES;
    self.newPassWordTF.textFiled.tag = 2;
    [self.view_IOS7 addSubview:self.newPassWordTF];

    UIButton *button = [UIButton customButtonTitle:nil tag:0 image:[UIImage imageNamed:@"NO.png"] frame:CGRectMake(35, 130, 70, 25) target:self action:@selector(showPWD:)];
    self.swichBtn = button;
    [self.view_IOS7 addSubview:self.swichBtn];
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"显示密码" frame:CGRectMake(110, 132, 60, 20) font:FontSize24 color:FontColor1B77C3 alignment:NSTextAlignmentLeft]];
   
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"修改密码" backImage:[UIImage imageNamed:@"登录.png"] frame:CGRectMake(35, 165, 250, 45) font:FontSize36 color:FontColor1B77C3 target:self action:@selector(modifyPassword:)]];
    
    self.textFieldArray = [NSArray arrayWithObjects:self.oldPassWordTF.textFiled,self.newPassWordTF.textFiled, nil];
}
-(void)showPWD:(UIButton*)sender
{
    if(self.showPWD)
    {
        [self.swichBtn setImage:[UIImage imageNamed:@"YES.png"] forState:UIControlStateNormal];
        self.oldPassWordTF.textFiled.secureTextEntry = NO;
        self.newPassWordTF.textFiled.secureTextEntry = NO;
    }
    else
    {
        [self.swichBtn setImage:[UIImage imageNamed:@"NO.png"] forState:UIControlStateNormal];
        self.oldPassWordTF.textFiled.secureTextEntry = YES;
        self.newPassWordTF.textFiled.secureTextEntry = YES;
    }
    self.showPWD = !self.showPWD;
}
-(void)modifyPassword:(UIButton*)sender
{
    if(oldPassWordTF.textFiled.text.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入原密码!"];
        return;
    }
    else if (oldPassWordTF.textFiled.text.length < 6)
    {
        [UIAlertView alertViewWithMessage:@"请输入6-20位原密码！"];
        return;
    }
    else if (![oldPassWordTF.textFiled.text isEqualToString:[UserLogin sharedUserInfo].passWord])
    {
        [UIAlertView alertViewWithMessage:@"原密码输入错误！"];
        return;
    }
    else if(newPassWordTF.textFiled.text.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入新密码！"];
        return;
    }
    else if (newPassWordTF.textFiled.text.length < 6)
    {
        [UIAlertView alertViewWithMessage:@"请输入6-20位新密码！"];
        return;
    }
    else if(![newPassWordTF.textFiled.text isMatchedByRegex:PASSWARD])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的密码！"];
        return;
    }

    ASIFormDataRequest * theRequest = [InterfaceClass editPassword:[UserLogin sharedUserInfo].userID oldPassword:oldPassWordTF.textFiled.text newPassword:newPassWordTF.textFiled.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onEditPasswordPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onEditPasswordPaseredResult:(NSDictionary*)dic
{
    if([ [NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]]isEqualToString:@"0"])
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"修改成功！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        alerView.delegate = self;
        [alerView show];
        [alerView release];
    }
    else
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]]];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-TextField代理方法
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
    if(![string isMatchedByRegex:PASSWARD] && string.length != 0 )
        return NO;
    
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
    
     if(textFieldStrLength > 20)
        return NO;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

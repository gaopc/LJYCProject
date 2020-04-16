//
//  VerifyUserNameViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "VerifyUserNameViewController.h"
#import "UserLogin.h"
#import "InterfaceClass.h"
#import "SinaWeiBoExtend.h"
#import "MemberRegisterViewController.h"
#import "VerificationViewController.h"
#import "MemberLoginViewController.h"

@interface VerifyUserNameViewController ()

@end

@implementation VerifyUserNameViewController
@synthesize userNameTF,userName;
@synthesize textFieldArray,keyboardbar;
@synthesize delegate;
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
    self.userName = nil;
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    
    self.delegate = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"确认辣郊游用户名";
	// Do any additional setup after loading the view.
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 10, ViewWidth-10, 120) image:[UIImage imageNamed:@"白背景.png"]]];

    self.userNameTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(35, 35, 250, 40) leftImage:[UIImage imageNamed:@"白头像.png"] isMustFillIn:YES placeholder:@"请输入用户名" delegate:self];//
    [self.view_IOS7 addSubview:self.userNameTF];
    self.userNameTF.textFiled.delegate = self;
    [self.userNameTF.textFiled setText:self.userName];
    
    self.textFieldArray = [NSArray arrayWithObjects:self.userNameTF.textFiled, nil];
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"该用户名将作为昵称使用，且不能修改" frame:CGRectMake(35, 80, 250, 30) font:FontSize24 color:FontColorRed alignment:NSTextAlignmentLeft]];
    
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"确认" backImage:[UIImage imageNamed:@"登录.png"] frame:CGRectMake(30,160, 260, 40) font:FontSize36 color:FontColorFFFFFF target:self action:@selector(submit:)]];
}

-(void)submit:(UIButton*)sender
{
    [UserLogin sharedUserInfo]._userName = userNameTF.textFiled.text;
    
    
    ASIFormDataRequest * theRequest = [InterfaceClass userSetNickname:[UserLogin sharedUserInfo].userID nickname:[UserLogin sharedUserInfo]._userName];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserSetNicknameResult:) Delegate:self needUserType:Default];
}

-(void)onUserSetNicknameResult:(NSDictionary*)dic
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:keyAudioLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self removeViews];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul:)]) {
        [self.delegate performSelector:@selector(loginSuccessFul:)];
    }
}

-(void)removeViews
{
    NSMutableArray * mArray = [NSMutableArray array];
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        
        if (!([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberRegisterViewController class]] || [[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[VerificationViewController class]] || [[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[VerifyUserNameViewController class]] || [[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberLoginViewController class]]))
        {
            [mArray addObject:[self.navigationController.viewControllers objectAtIndex:i]];
        }
	}
	self.navigationController.viewControllers = mArray;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

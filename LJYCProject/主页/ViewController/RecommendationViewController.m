//
//  RecommendationViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "RecommendationViewController.h"
#import "InterfaceClass.h"
#import "MyRegex.h"
@interface RecommendationViewController ()

@end

@implementation RecommendationViewController
@synthesize myImageView,myLabel,myTextView,textFieldArray,keyboardbar,emailTF,ziCount;
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
    self.myImageView = nil;
    self.myLabel = nil;
    self.myTextView = nil;
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self.emailTF = nil;
    self.ziCount = nil;
    
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"投诉建议";
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 25, 23) backImage:[UIImage imageNamed:@"侧栏1.png"] target:self action:@selector(sideBar:)];
    [leftButton setImage:[UIImage imageNamed:@"侧栏2.png"] forState:UIControlStateHighlighted];
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
	// Do any additional setup after loading the view.
    
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"您的意见将帮助我们改进产品与服务:" frame:CGRectMake(15, 5, ViewWidth-10, 15) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft]];
    
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 30, ViewWidth-30, 130) image:[UIImage imageNamed:@"意见建议0.png"]]];
    self.myImageView = [UIImageView ImageViewWithFrame:CGRectMake(135, 60, 50, 50) image:[UIImage imageNamed:@"意见建议1.png"]];
    self.myLabel = [UISubLabel labelWithTitle:@"请留下您宝贵的意见" frame:CGRectMake(100, 120, 100, 30) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentCenter];
    self.myTextView = [UISubTextView TextViewWithFrame:CGRectMake(15, 30, ViewWidth-30, 130) font:FontSize32 textColor:FontColor000000];
    self.myTextView.returnKeyType = UIReturnKeyDone;
    self.myTextView.backgroundColor = [UIColor clearColor];
    self.myTextView.delegate = self;
    
    [self.view_IOS7 addSubview:self.myImageView];
    [self.view_IOS7 addSubview:self.myLabel];
    [self.view_IOS7 addSubview:self.myTextView];
    
    self.ziCount = [UISubLabel labelWithTitle:@"还可以输入500字" frame:CGRectMake(ViewWidth-15-150, 165, 150, 18) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentRight];
    [self.view_IOS7 addSubview:self.ziCount];
 
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 182, 21, 18) image:[UIImage imageNamed:@"意见建议2.png"]]];
    [self.view_IOS7 addSubview:[UISubLabel labelWithTitle:@"请填写真实邮箱，以便于我们对您的意见及时给出答案，谢谢！" frame:CGRectMake(40, 182, 280, 20) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentLeft]];
    
    self.emailTF = [CoustomTextField coustomTextFieldWithFrame:CGRectMake(15, 205, ViewWidth-30, 40) leftImage:[UIImage imageNamed:@"意见建议4.png"] isMustFillIn:NO placeholder:@"请输入真实邮箱" delegate:self];
    self.emailTF.textFiled.returnKeyType = UIReturnKeyDone;
    [self.view_IOS7 addSubview:self.emailTF];
    
    [self.view_IOS7 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"提交我的建议" backImage:[UIImage imageNamed:@"登录.png"] frame:CGRectMake(30, 300, ViewWidth-60, 45) font:FontBlodSize32 color:FontColorFFFFFF target:self action:@selector(sumbit:)]];

    self.textFieldArray = [NSArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBroard) name:@"closeKeyBoard" object:nil];
}

-(void)sumbit:(UIButton*)sender
{
    if(self.myTextView.text.length == 0 )
    {
        [UIAlertView alertViewWithMessage:@"请输入您的意见！"];
        return;
    }
    
    if (![self.emailTF.textFiled.text isMatchedByRegex:EMAIL] ) {
        
        [UIAlertView alertViewWithMessage:@"请填写正确的邮箱！"];
        return;
    }
    NSLog(@"%@",[UserLogin sharedUserInfo].userID);
    if(![UserLogin sharedUserInfo].userID)
    {
        ASIFormDataRequest * theRequest = [InterfaceClass advise:self.myTextView.text telephone:nil email:self.emailTF.textFiled.text userId:nil userType:@"0"];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAdvisePaseredResult:) Delegate:self needUserType:Default];
    }
    else
    {
        ASIFormDataRequest * theRequest = [InterfaceClass advise:self.myTextView.text telephone:[UserLogin sharedUserInfo]._telephone email:self.emailTF.textFiled.text userId:[UserLogin sharedUserInfo].userID userType:@"1"];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAdvisePaseredResult:) Delegate:self needUserType:Default];
    }
    

    
}

-(void)onAdvisePaseredResult:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] isEqualToString:@"0"])
    {
        self.myTextView.text = @"";
        self.emailTF.textFiled.text = @"";
        if(myTextView.text.length == 0)
        {
            self.myImageView.hidden = NO;
            self.myLabel.hidden = NO;
        }
        [UIAlertView alertViewWithMessage:@"提交成功，我们会反馈给相关工作人员！"];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
        self.view_IOS7.tag = 100;
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
		
	}
	[keyboardbar showBar:textField];  //显示工具条
	return  YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.myImageView.hidden = YES;
    self.myLabel.hidden = YES;
    
    if (self.keyboardbar == nil) {
        self.view_IOS7.tag = 100;
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7 ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
		
	}
	[keyboardbar showBar:textView];  //显示工具条
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * textFieldStr = [[textView.text stringByReplacingCharactersInRange:range withString:text] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
    
    int textFieldMaxLenth = 500;
    
    int count = 500-textFieldStrLength < 0 ? 0 : 500-textFieldStrLength;
    self.ziCount.text = [NSString stringWithFormat:@"还可以输入%d字",count];
    
	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textView.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(textView.text.length == 0)
    {
        self.myImageView.hidden = NO;
        self.myLabel.hidden = NO;
    }
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeKeyBroard
{
    [self.keyboardbar HiddenKeyBoard];
}
@end

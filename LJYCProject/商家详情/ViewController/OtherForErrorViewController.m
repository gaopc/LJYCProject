//
//  OtherForErrorViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "OtherForErrorViewController.h"
#import "MyRegex.h"

@interface OtherForErrorViewController ()

@end

@implementation OtherForErrorViewController
@synthesize textFieldArray;
@synthesize keyboardbar;
@synthesize _shopId;

- (void)dealloc
{
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self._shopId = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"店铺报错";
    self.textFieldArray = [NSArray array];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(20, 10, 280, 130) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    myTextView = [UITextView TextViewWithFrame:CGRectMake(25, 10, 270, 100) font:FontSize24 textColor:FontColor000000];
    myTextView.delegate = self;
    
    myImageView = [UIImageView ImageViewWithFrame:CGRectMake(135, 45, 50, 50) image:[UIImage imageNamed:@"意见建议1.png"]];
    myLabel = [UISubLabel labelWithTitle:@"请输入错误信息或修改意见（500字以内）" frame:CGRectMake(110, 95, 100, 30) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentCenter];
    
    countLab = [UISubLabel labelWithTitle:@"还可以输入500字" frame:CGRectMake(20, 120, 270, 20) font:FontSize20 color:FontColor979797 alignment:NSTextAlignmentRight];
    
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(20, 150, 280, 40) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    UIImageView *backView1 = [UIImageView ImageViewWithFrame:CGRectMake(20, 192, 280, 40) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    UISubLabel *emailLab = [UISubLabel labelWithTitle:@"您的Email" frame:CGRectMake(30, 155, 260, 30) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
    UISubLabel *phoneLab = [UISubLabel labelWithTitle:@"您的手机" frame:CGRectMake(30, 197, 260, 30) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    UIImageView *emailView = [UIImageView ImageViewWithFrame:CGRectMake(95, 155, 180, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    UIImageView *phoneView = [UIImageView ImageViewWithFrame:CGRectMake(95, 197, 180, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    emailField = [UISubTextField TextFieldWithFrame:CGRectMake(100, 155, 175, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入您的邮箱地址" font:FontSize24];
    emailField.delegate = self;
    emailField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    phoneField = [UISubTextField TextFieldWithFrame:CGRectMake(100, 197, 175, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入您的11位手机号码" font:FontSize24];
    phoneField.delegate = self;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view_IOS7 addSubview:textView];
    [self.view_IOS7 addSubview:myTextView];
    [self.view_IOS7 addSubview:countLab];
    [self.view_IOS7 addSubview:myImageView];
    [self.view_IOS7 addSubview:myLabel];
    
    [self.view_IOS7 addSubview:backView];
    [self.view_IOS7 addSubview:backView1];
    [self.view_IOS7 addSubview:emailView];
    [self.view_IOS7 addSubview:phoneView];
    [self.view_IOS7 addSubview:emailLab];
    [self.view_IOS7 addSubview:phoneLab];
    [self.view_IOS7 addSubview:emailField];
    [self.view_IOS7 addSubview:phoneField];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(submit) title:@"完成"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    self.textFieldArray = [NSArray arrayWithObjects:myTextView, emailField, phoneField,nil];
}

#pragma mark - textField UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7 ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textField];  //显示工具条
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	if (phoneField == textField) {
        
		textFieldMaxLenth = 11;
	}
    else if (emailField == textField) {
        
        textFieldMaxLenth = 30;
    }
    
	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}
}

#pragma mark - textView UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    myImageView.hidden = YES;
    myLabel.hidden = YES;
    
	if (self.keyboardbar == nil) {
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
    countLab.text = [NSString stringWithFormat:@"还可以输入%d字",count];
    
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
        myImageView.hidden = NO;
        myLabel.hidden = NO;
    }
    return YES;
}

- (void)submit
{
    if (myTextView.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请填写错误信息"];
        return;
    }
    
    if (emailField.text.length > 0 && ![emailField.text isMatchedByRegex:EMAIL] ) {
        
        [UIAlertView alertViewWithMessage:@"请填写正确的邮箱！"];
        return;
    }
    
    if (phoneField.text.length > 0 && ![phoneField.text isMatchedByRegex:PHONENO] ) {
        
        [UIAlertView alertViewWithMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    errorData = [[ShopForErrorData alloc] init];
    errorData._userId = [UserLogin sharedUserInfo].userID;
    errorData._content = myTextView.text;
    errorData._shopId = self._shopId;
    errorData._email = emailField.text;
    errorData._telephone = phoneField.text;
    
    ASIFormDataRequest * theRequest = [InterfaceClass shopOtherError:errorData];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopOtherErrorResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredShopOtherErrorResult:(NSDictionary *)dic
{
    [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"] tag:0 delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

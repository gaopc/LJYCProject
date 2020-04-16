//
//  ShopForQuestionViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForQuestionViewController.h"

@interface ShopForQuestionViewController ()

@end

@implementation ShopForQuestionViewController
@synthesize textFieldArray;
@synthesize keyboardbar;
@synthesize _shopId;
@synthesize _delegate;

- (void)dealloc
{
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self._shopId = nil;
    self._delegate = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"提问";
    
    self.textFieldArray = [NSArray array];
    
    UISubLabel *titleStr = [UISubLabel labelWithTitle:@"提问内容：" frame:CGRectMake(22, 15, 200, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
    UISubLabel *alertStr = [UISubLabel labelWithTitle:@"商家回复问题后，您将收到推送消息提醒" frame:CGRectMake(22, 35, 200, 20) font:FontSize20 color:FontColorRed alignment:NSTextAlignmentLeft];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(20, 60, 280, 130) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    myImageView = [UIImageView ImageViewWithFrame:CGRectMake(135, 95, 50, 50) image:[UIImage imageNamed:@"意见建议1.png"]];
    myLabel = [UISubLabel labelWithTitle:@"在这里您可以向商家提出您感兴趣的问题" frame:CGRectMake(110, 145, 100, 30) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentCenter];
    
    myTextView = [UITextView TextViewWithFrame:CGRectMake(25, 65, 270, 120) font:FontSize24 textColor:FontColor000000];
    myTextView.delegate = self;
    
    countLab = [UISubLabel labelWithTitle:@"还可以输入20字" frame:CGRectMake(20, 190, 270, 20) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentRight];
    
    [self.view_IOS7 addSubview:titleStr];
    [self.view_IOS7 addSubview:alertStr];
    [self.view_IOS7 addSubview:textView];
    [self.view_IOS7 addSubview:myTextView];
    [self.view_IOS7 addSubview:myImageView];
    [self.view_IOS7 addSubview:myLabel];
    [self.view_IOS7 addSubview:countLab];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(submit) title:@"提交"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
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
    int textFieldMaxLenth = 0;
    
	if (myTextView == textView) {
		
		textFieldMaxLenth = 20;
        int count = 20-textFieldStrLength < 0 ? 0 : 20-textFieldStrLength;
        countLab.text = [NSString stringWithFormat:@"还可以输入%d字",count];
	}
    
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
    NSString *temp = [myTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请提出您的问题"];
        return;
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass shopAddQuestion:self._shopId withUserId:[UserLogin sharedUserInfo].userID withContent:text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopQuestionResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredShopQuestionResult:(NSDictionary *)dic
{
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    
    if ([statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:message tag:0 delegate:self];
    }
    else {
        [UIAlertView alertViewWithMessage:message];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self._delegate && [self._delegate respondsToSelector:@selector(reloadQuestionData:)]) {
        [self._delegate performSelector:@selector(reloadQuestionData:) withObject:self];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

//
//  ShopForSignViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForSignViewController.h"

@interface ShopForSignViewController ()

@end

@implementation ShopForSignViewController
@synthesize textFieldArray;
@synthesize keyboardbar;

- (void)dealloc
{
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"签到";
    self.textFieldArray = [NSArray array];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(20, 10, 280, 130) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    myTextView = [UITextView TextViewWithFrame:CGRectMake(25, 10, 270, 100) font:FontSize24 textColor:FontColor000000];
    myTextView.delegate = self;
    
    myImageView = [UIImageView ImageViewWithFrame:CGRectMake(135, 45, 50, 50) image:[UIImage imageNamed:@"意见建议1.png"]];
    myLabel = [UISubLabel labelWithTitle:@"还没有人签到呢，快来抢沙发哦" frame:CGRectMake(110, 95, 100, 30) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentCenter];
    
    countLab = [UISubLabel labelWithTitle:@"还可以输入200字" frame:CGRectMake(20, 140, 270, 30) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentRight];
    
    [self.view_IOS7 addSubview:textView];
    [self.view_IOS7 addSubview:myTextView];
    [self.view_IOS7 addSubview:countLab];
    [self.view_IOS7 addSubview:myImageView];
    [self.view_IOS7 addSubview:myLabel];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(submit) title:@"完成"];
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
    
    int textFieldMaxLenth = 200;
    
    int count = 200 - textFieldStrLength < 0 ? 0 : 200 - textFieldStrLength;
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end

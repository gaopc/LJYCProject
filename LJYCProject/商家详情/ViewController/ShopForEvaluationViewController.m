//
//  ShopForEvaluationViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForEvaluationViewController.h"

@interface ShopForEvaluationViewController ()

@end

@implementation ShopForEvaluationViewController
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
	
    self.title = @"添加点评";
    self.textFieldArray = [NSArray array];
    selectStar = 0;
    
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(20, 25, 280, 45) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    starBut1 = [UIButton buttonWithTag:0 frame:CGRectMake(78, 35, 25, 25) target:self action:@selector(clickStar:)];
    starBut2 = [UIButton buttonWithTag:1 frame:CGRectMake(78 + 35, 35, 25, 25) target:self action:@selector(clickStar:)];
    starBut3 = [UIButton buttonWithTag:2 frame:CGRectMake(78 + 35*2, 35, 25, 25) target:self action:@selector(clickStar:)];
    starBut4 = [UIButton buttonWithTag:3 frame:CGRectMake(78 + 35*3, 35, 25, 25) target:self action:@selector(clickStar:)];
    starBut5 = [UIButton buttonWithTag:4 frame:CGRectMake(78 + 35*4, 35, 25, 25) target:self action:@selector(clickStar:)];
    [starBut1 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut2 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut3 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut4 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut5 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(20, 80, 280, 130) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    myTextView = [UITextView TextViewWithFrame:CGRectMake(25, 82, 270, 125) font:FontSize24 textColor:FontColor000000];
    myTextView.delegate = self;
    myImageView = [UIImageView ImageViewWithFrame:CGRectMake(135, 115, 50, 50) image:[UIImage imageNamed:@"意见建议1.png"]];
    myLabel = [UISubLabel labelWithTitle:@"请输入您的评价，为大家提供一盏明灯！" frame:CGRectMake(110, 165, 100, 30) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentCenter];
    
    countLab = [UISubLabel labelWithTitle:@"您还需要输入5个字" frame:CGRectMake(20, 210, 280, 30) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentRight];
    
    [self.view_IOS7 addSubview:backView];
    [self.view_IOS7 addSubview:textView];
    [self.view_IOS7 addSubview:starBut1];
    [self.view_IOS7 addSubview:starBut2];
    [self.view_IOS7 addSubview:starBut3];
    [self.view_IOS7 addSubview:starBut4];
    [self.view_IOS7 addSubview:starBut5];
    [self.view_IOS7 addSubview:myTextView];
    [self.view_IOS7 addSubview:countLab];
    [self.view_IOS7 addSubview:myImageView];
    [self.view_IOS7 addSubview:myLabel];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(submit) title:@"完成"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}

- (void)clickStar:(UIButton *)sender
{
    [starBut1 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut2 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut3 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut4 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    [starBut5 setBackgroundImage:[UIImage imageNamed:@"星星灰色.png"] forState:UIControlStateNormal];
    
    switch (sender.tag) {
        case 0:
            [starBut1 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            break;
        case 1:
            [starBut1 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut2 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [starBut1 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut2 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut3 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [starBut1 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut4 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut2 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut3 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            break;
        case 4:
            [starBut1 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut5 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut4 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut2 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            [starBut3 setBackgroundImage:[UIImage imageNamed:@"星星彩色.png"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    selectStar = sender.tag + 1;
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
        
        textFieldMaxLenth = 330;
        
        int count = 5 - textFieldStrLength;
        if (count > 0) {
            countLab.text = [NSString stringWithFormat:@"您还需要输入%d个字",count];
        }
        else {
            
            count = 330 - textFieldStrLength < 0 ? 0 : 330 - textFieldStrLength;
            countLab.text = [NSString stringWithFormat:@"您还可以输入%d个字",count];
        }
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
    
    if (selectStar == 0) {
        [UIAlertView alertViewWithMessage:@"请对店铺星级评分！"];
        return;
    }
    if (text.length < 5) {
        [UIAlertView alertViewWithMessage:@"您最少输入5个字！"];
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass shopAddComment:self._shopId withUserId:[UserLogin sharedUserInfo].userID withContent:text withStar:[NSString stringWithFormat:@"%d", selectStar]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopEvaResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredShopEvaResult:(NSDictionary *)dic
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
    if (self._delegate && [self._delegate respondsToSelector:@selector(reloadTableView:)]) {
        [self._delegate performSelector:@selector(reloadTableView:) withObject:[NSString stringWithFormat:@"%d", selectStar]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

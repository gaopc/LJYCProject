//
//  ShopForShareViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForShareViewController.h"
#import <Social/Social.h>

@interface ShopForShareViewController ()

@end

@implementation ShopForShareViewController
@synthesize textFieldArray;
@synthesize keyboardbar;
@synthesize wbapi;

- (void)dealloc
{
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"分享到社交网站";
    self.textFieldArray = [NSArray array];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(20, 10, 280, 130) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    myTextView = [UITextView TextViewWithFrame:CGRectMake(25, 12, 270, 105) font:FontSize24 textColor:FontColor000000];
    myTextView.delegate = self;
    myTextView.text = @""; //辣郊游帮您快速查找城市周边农家乐、采摘园、旅游景点、娱乐活动等各类商家信息！\n轻松查找商家的地址、电话、推荐信息、用户点评、信息全面客观；\n提供签到、点评、拍照等功能！记录您丰富的生活！\n支持微信、QQ、新浪微博分享到好友！
    
    myImageView = [UIImageView ImageViewWithFrame:CGRectMake(135, 45, 50, 50) image:[UIImage imageNamed:@"意见建议1.png"]];
    myLabel = [UISubLabel labelWithTitle:@"输入您想说的" frame:CGRectMake(110, 95, 100, 30) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentCenter];
    myImageView.hidden = YES;
    myLabel.hidden = YES;
    
    countLab = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 120, 270, 20) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentRight];
    countLab.text = [NSString stringWithFormat:@"还可以输入%d字",140 - [myTextView.text length]];
    
    UIImageView *textView1 = [UIImageView ImageViewWithFrame:CGRectMake(20, 142, 280, 55) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    xinlangBut = [UIButton buttonWithTag:0 frame:CGRectMake(30 + 45, 152, 35, 35) target:self action:@selector(clickBut:)];
    qqBut = [UIButton buttonWithTag:1 frame:CGRectMake(30, 152, 35, 35) target:self action:@selector(clickBut:)];
    [xinlangBut setBackgroundImage:[UIImage imageNamed:@"分享新浪-01.png"] forState:UIControlStateNormal];
    [qqBut setBackgroundImage:[UIImage imageNamed:@"腾讯微薄-01.png"] forState:UIControlStateNormal];
    
    [self.view_IOS7 addSubview:textView];
    [self.view_IOS7 addSubview:myTextView];
    [self.view_IOS7 addSubview:countLab];
    [self.view_IOS7 addSubview:myImageView];
    [self.view_IOS7 addSubview:myLabel];
    [self.view_IOS7 addSubview:textView1];
//    [self.view_IOS7 addSubview:xinlangBut];
    [self.view_IOS7 addSubview:qqBut];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(submit) title:@"完成"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    
    if(self->wbapi == nil)
    {
        self->wbapi = [[WeiboApi alloc]initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUri:REDIRECTURI] ;
    }
    NSDictionary *qqWeiboData = [[NSUserDefaults standardUserDefaults] objectForKey:@"QQWeiboAuthData"];
    [wbapi loginWithAccesstoken:[qqWeiboData objectForKey:@"accesstoken"] andOpenId:[qqWeiboData objectForKey:@"openid"] andExpires:[[qqWeiboData objectForKey:@"expires"] floatValue] andRefreshToken:[qqWeiboData objectForKey:@"refreshtoken"] andDelegate:self];
    
    if ([wbapi isAuthValid]) {
        selectQ = YES;
        [qqBut setBackgroundImage:[UIImage imageNamed:@"腾讯微薄-00.png"] forState:UIControlStateNormal];
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
    
    int textFieldMaxLenth = 140;
    
    int count = 140 - textFieldStrLength < 0 ? 0 : 140 - textFieldStrLength;
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
        
        [UIAlertView alertViewWithMessage:@"请输入分享的内容！"];
        return;
    }
    
    if (selectQ) {
        
        [self onAddPic];
    }
}

- (void)clickBut:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            selectX = !selectX;
            if (selectX) {
                [xinlangBut setBackgroundImage:[UIImage imageNamed:@"分享新浪-00.png"] forState:UIControlStateNormal];
            }
            else {
                [xinlangBut setBackgroundImage:[UIImage imageNamed:@"分享新浪-01.png"] forState:UIControlStateNormal];
            }
            break;
        }
        case 1:
        {
            selectQ = !selectQ;
            if (selectQ) {
                
                if (![wbapi isAuthValid]) {
                    [self onQQLogin];
                    return;
                }
                [qqBut setBackgroundImage:[UIImage imageNamed:@"腾讯微薄-00.png"] forState:UIControlStateNormal];
            }
            else {
                [qqBut setBackgroundImage:[UIImage imageNamed:@"腾讯微薄-01.png"] forState:UIControlStateNormal];
            }
            break;
        }
        default:
            break;
    }
}

//腾讯微博授权
- (void)onQQLogin {
    [wbapi loginWithDelegate:self andRootController:self];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthFinished:(WeiboApi *)wbapi_
{
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r refreshToken=%@ \r expires=%f\r", wbapi_.accessToken, wbapi_.openid, wbapi_.refreshToken, wbapi_.expires];
    
    NSLog(@"result = %@",str);
    [str release];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              wbapi_.accessToken, @"accesstoken",
                              wbapi_.openid, @"openid",
                              wbapi_.refreshToken, @"refreshtoken",
                              [NSString stringWithFormat:@"%f", wbapi_.expires], @"expires", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"QQWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    selectQ = YES;
    [qqBut setBackgroundImage:[UIImage imageNamed:@"腾讯微薄-00.png"] forState:UIControlStateNormal];
    [UIAlertView alertViewWithMessage:@"腾讯微博授权成功！"];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthFailWithError:(NSError *)error
{
    [UIAlertView alertViewWithMessage:@"腾讯微博授权失败！"];
}

- (void)onAddPic
{
    
    UIImage *pic = [UIImage imageNamed:@"PopularIcon.png"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   myTextView.text, @"content",
                                   pic, @"pic",
                                   nil];
    [wbapi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
    [pic release];
    [params release];
    
}

#pragma mark WeiboRequestDelegate

/**
 * @brief   接口调用成功后的回调
 * @param   INPUT   data    接口返回的数据
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didReceiveRawData:(NSData *)data reqNo:(int)reqno
{
    [UIAlertView alertViewWithMessage:@"分享成功！"];
}
/**
 * @brief   接口调用失败后的回调
 * @param   INPUT   error   接口返回的错误信息
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didFailWithError:(NSError *)error reqNo:(int)reqno
{
    [UIAlertView alertViewWithMessage:@"分享失败！"];
}

@end

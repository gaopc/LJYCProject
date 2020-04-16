//
//  MessageDetailViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController
@synthesize myMessage, _delegate;
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
    self.myMessage = nil;
    self._delegate = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.myMessage._title;
    
    UIButton  * rightButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(delegate) title:@"删除"];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
	// Do any additional setup after loading the view.
    if(![self.myMessage._picUrl isEqualToString:@""] &&  self.myMessage._picUrl != nil)
    {
        NSURL *url = [NSURL URLWithString:self.myMessage._picUrl];
        
        [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(7, 10, ViewWidth-14, 133) image:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]]];
        [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 143, ViewWidth-10, 122) image:[UIImage imageNamed:@"白背景.png"]]];
        
        UISubLabel *label = [UISubLabel labelWithTitle:self.myMessage._content frame:CGRectMake(10, 153, ViewWidth-20, 100) font:FontSize30 color:FontColor565656 alignment:NSTextAlignmentLeft autoSize:YES];
        UISubLabel *label2 = [UISubLabel labelWithTitle:[self getTimeFormString:self.myMessage._time] frame:CGRectMake(5, 235, ViewWidth-15, 30) font:FontSize30 color:FontColor565656 alignment:NSTextAlignmentRight];
        
        [self.view_IOS7 addSubview:label];
        [self.view_IOS7 addSubview:label2];
    }
    else
    {
        [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 10, ViewWidth-10, 250) image:[UIImage imageNamed:@"白背景.png"]]];
       
        UISubLabel *label = [UISubLabel labelWithTitle:self.myMessage._content frame:CGRectMake(10, 10, ViewWidth-20, 110) font:FontSize30 color:FontColor565656 alignment:NSTextAlignmentLeft autoSize:YES];
        UISubLabel *label2 = [UISubLabel labelWithTitle:[self getTimeFormString:self.myMessage._time] frame:CGRectMake(5, label.frame.origin.y+15, ViewWidth-15, 30) font:FontSize30 color:FontColor565656 alignment:NSTextAlignmentRight];
        
        [self.view_IOS7 addSubview:label];
        [self.view_IOS7 addSubview:label2];
    }
}

-(NSString *)getTimeFormString:(NSString*)str
{
    long long dataLong = [str longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

-(void)delegate
{
    ASIFormDataRequest * theRequest = [InterfaceClass delMessage:self.myMessage._id];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelMessagePaseredResult:) Delegate:self needUserType:Default];
    
}

-(void)onDelMessagePaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]] tag:0 delegate:self];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UIAlerViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self._delegate && [self._delegate respondsToSelector:@selector(reloadMyTableView)]) {
        [self._delegate performSelector:@selector(reloadMyTableView)];
    }
}
@end

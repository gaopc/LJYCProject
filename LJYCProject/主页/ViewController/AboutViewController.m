//
//  AboutViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于我们";
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 25, 23) backImage:[UIImage imageNamed:@"侧栏1.png"] target:self action:@selector(sideBar:)];
    [leftButton setImage:[UIImage imageNamed:@"侧栏2.png"] forState:UIControlStateHighlighted];
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
	// Do any additional setup after loading the view.
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth-61)/2, 5, 61, 63) image:[UIImage imageNamed:@"关于我们_03.png"]]];
    
    [self.view addSubview:[UISubLabel labelWithTitle:@"辣郊游" frame:CGRectMake((ViewWidth-61)/2, 72, 61, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentCenter autoSize:YES]];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 100, ViewWidth-20, 80) image:[UIImage imageNamed:@"关于我们_06.png"]]];
    
    [self.view addSubview:[UISubLabel labelWithTitle:@"        辣郊游帮您快速查找城市周边农家乐、采摘园、旅游景点、娱乐活动等各类商家信息！轻松查找商家的地址、电话、推荐信息、用户点评、信息全面客观；提供签到、点评、拍照等功能！记录您丰富的生活！支持微信、QQ、新浪微博分享到好友！" frame:CGRectMake(14, 102, ViewWidth-22, 75) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft autoSize:YES]];
    
    NSArray *array = [NSArray arrayWithObjects:@"客服热线:010-56138893",@"网     址:www.lajiaou.com",@"QQ:3097749469",@"电子邮箱:3097749469@qq.com ", nil];
    for(int i =0;i<4;i++)
    {
        UIButton *button = [UIButton customButtonTitle:nil tag:i image:[UIImage imageNamed:@"关于我们_15.png"] frame:CGRectMake(10, 188+52*i, ViewWidth-20, 47) target:self action:@selector(click:)];
        [button setBackgroundImage:[UIImage imageNamed:@"关于我们_18.png"] forState:UIControlStateHighlighted];
        [self.view addSubview:button];
        
        [self.view addSubview:[UISubLabel labelWithTitle:[array objectAtIndex:i] frame:CGRectMake(20, 195+52*i, ViewWidth-40, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
//        if(i == 0)
//        {
//            [self.view addSubview:[UISubLabel labelWithTitle:@"400-6858-999" frame:CGRectMake(100, 195+52*i, 100, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
//        }
        
        [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-30, 205+52*i, 6, 10) image:[UIImage imageNamed:@"关于我们_11.png"] ]];
        
    }

}

-(void)click:(UIButton*)sender
{
    NSLog(@"%d",sender.tag);
    switch (sender.tag) {
        case 0:
        {
            [self callTel:@"010-56138893"];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}

-(void)map:(UIButton*)sender
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

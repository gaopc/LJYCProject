//
//  TellToFriendsViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "TellToFriendsViewController.h"

@interface TellToFriendsViewController ()

@end

@implementation TellToFriendsViewController

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
    self.title = @"告诉朋友";
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 25, 23) backImage:[UIImage imageNamed:@"侧栏1.png"] target:self action:@selector(sideBar:)];
    [leftButton setImage:[UIImage imageNamed:@"侧栏2.png"] forState:UIControlStateHighlighted];
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

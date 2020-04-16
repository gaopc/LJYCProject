//
//  HelpViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpCell.h"
@interface HelpViewController ()

@end

@implementation HelpViewController
@synthesize titlesArray;
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
    self.titlesArray = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"使用帮助";
    self.titlesArray = [NSArray arrayWithObjects:@"新手入门",@"注册流程",@"购买流程",@"购物保障",@"团购帮助",@"手机充值",@"联系我们", nil];
    self.selectSection = 100;
    
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 25, 23) backImage:[UIImage imageNamed:@"侧栏1.png"] target:self action:@selector(sideBar:)];
    [leftButton setImage:[UIImage imageNamed:@"侧栏2.png"] forState:UIControlStateHighlighted];
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
	// Do any additional setup after loading the view.
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(5, 5, ViewWidth-10, 35) image:[UIImage imageNamed:@"使用帮助_03.png"]]];
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 40, ViewWidth-10, ViewHeight-40) style:UITableViewStylePlain];
    self.myTableview = aTableView;
    [aTableView release];
    self.myTableview.dataSource = self;
    self.myTableview.delegate = self;
    self.myTableview.backgroundColor = [UIColor clearColor];
    self.myTableview.scrollEnabled = NO;
    [self.view_IOS7 addSubview:self.myTableview];
}

#pragma mark - Table view data source

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 40;
    else
        return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == self.selectSection)
        return 2;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        NSString *identifier = [NSString stringWithFormat:@"helpIdentifier%d",indexPath.section];
        HelpCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        // Configure the cell...
        if (cell == nil)
        {
            cell = [[[HelpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
        if(self.selectSection == indexPath.section)
        {
            [cell.bakgroundImageView setImage:[UIImage imageNamed:@"使用帮助_22.png"]];
            cell.imageView1.hidden = NO;
            [cell.imageView2 setImage:[UIImage imageNamed:@"使用帮助_15.png"]];
        }
        else
        {
            [cell.bakgroundImageView setImage:[UIImage imageNamed:@"使用帮助_29.png"]];
            cell.imageView1.hidden = YES;
            [cell.imageView2 setImage:[UIImage imageNamed:@"使用帮助_11.png"]];
        }
        [cell.numLabel setText:[NSString stringWithFormat:@"%d",indexPath.section+1]];
        [cell.titleLabel setText:[self.titlesArray objectAtIndex:indexPath.section]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        NSString *tagIdentifier = [NSString stringWithFormat:@"tagIdentifier%d%d",indexPath.section,indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagIdentifier];
        
        // Configure the cell...
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tagIdentifier] autorelease];
        }
        NSString *str = @"为保障";
        [cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth-10, 80) image:[UIImage imageNamed:@"使用帮助_29.png"]]];
        [cell.contentView addSubview:[UISubLabel labelWithTitle:str frame:CGRectMake(5, 5, ViewWidth-10, 60) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectSection != indexPath.section)
    {
        self.selectSection = indexPath.section;
        [self.myTableview reloadData];
    }
    else
    {
        self.selectSection = 100;
        [self.myTableview reloadData];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

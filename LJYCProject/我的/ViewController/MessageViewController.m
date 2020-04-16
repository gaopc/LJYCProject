//
//  MessageViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageDetailViewController.h"
#import "InterfaceClass.h"
@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize  _dataArray;
- (void)dealloc
{
    self._dataArray = nil;
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
    self.title = @"消息中心";
        UIButton  * rightButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(clear) title:@"清空"];
        UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightBar;
        [rightBar release];
    
    self._dataArray = [NSArray arrayWithObjects:@"temp",@"temp",@"temp",@"temp",nil];
	// Do any additional setup after loading the view.
    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,0,ViewWidth,ViewHeight) style:UITableViewStylePlain];
	mytableView.backgroundColor = [UIColor clearColor];
	mytableView.dataSource = self;
	mytableView.delegate = self;
	mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view_IOS7 addSubview:mytableView];

}
-(void)clear
{
    ASIFormDataRequest * theRequest = [InterfaceClass delMessage:[UserLogin sharedUserInfo].userID];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelMessagePaseredResult:) Delegate:self needUserType:Default];

}

-(void)onDelMessagePaseredResult:(NSDictionary*)dic
{
    if(![[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        self._dataArray = nil;
        [mytableView reloadData];
    }
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	
	return [self._dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier =@"identifier";
	UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		UIImageView * cellImageView = [UIImageView ImageViewWithFrame:CGRectMake(10, 3, tableView.frame.size.width-20, 44) image:[UIImage imageNamed:@"个人中心cell.png"]];
		[cell addSubview:cellImageView];
        UIImageView * cellArrowImageView = [UIImageView ImageViewWithFrame:CGRectMake(cellImageView.frame.size.width - 12, 17, 7, 10) image:[UIImage imageNamed:@"CellArrow.png"]];
		[cellImageView addSubview:cellArrowImageView];
		UISubLabel * label = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 3, tableView.frame.size.width - 45, 44) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
		label.tag = 99;
		[cell addSubview:label];
        UISubLabel * label1 = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 3, tableView.frame.size.width - 45-10, 44) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentRight];
		label1.tag = 199;
		[cell addSubview:label1];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    UISubLabel * label = (UISubLabel *)[cell viewWithTag:99];
    label.text = @"消息标题";
    UISubLabel * label1 = (UISubLabel *)[cell viewWithTag:199];
    label1.text = @"2013.06.25";
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	NSString * messageItem = [self._dataArray objectAtIndex:indexPath.row];
    MessageDetailViewController * detailVC = [[MessageDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

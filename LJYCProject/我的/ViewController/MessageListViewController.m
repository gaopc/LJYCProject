//
//  MessageListViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageDetailViewController.h"
#import "InterfaceClass.h"
#import "MyMessageData.h"

@interface MessageListViewController ()

@end

@implementation MessageListViewController
@synthesize  myMessageData,isfromRecomend;
- (void)dealloc
{
    self.myMessageData = nil;
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		if (_refreshHeaderView) {
			myTableView.contentSize = CGSizeMake(ViewWidth, myTableView.contentSize.height-65.0f);
			[_refreshHeaderView removeFromSuperview];
			_refreshHeaderView = nil;
		}
		
	}
	else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[myTableView addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}

- (void)loadFitstDataSource
{
	[myTableView reloadData];
	
	_refreshHeaderView.frame=CGRectMake(0.0f, myTableView.contentSize.height, myTableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

-(void)setHeaderView
{
    if(pageIndex == [self.myMessageData.totalPage intValue] && [self.myMessageData.totalPage intValue] != 1)
    {
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
//        myTableView.contentSize = CGSizeMake(ViewWidth, myTableView.contentSize.height-65.0f);
        return;
    }
    _refreshHeaderView.frame=CGRectMake(0.0f, myTableView.contentSize.height, myTableView.frame.size.width, 80);
    [self doneLoadingTableViewData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息中心";
    pageIndex = 1;
    
	// Do any additional setup after loading the view.
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,0,ViewWidth,ViewHeight-44) style:UITableViewStylePlain];
	myTableView.backgroundColor = [UIColor clearColor];
	myTableView.dataSource = self;
	myTableView.delegate = self;
	myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view_IOS7 addSubview:myTableView];

    [self isrefreshHeaderView];
	
	[self loadFitstDataSource];
}

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass findMessage:[UserLogin sharedUserInfo].userID pageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFindMessagePaseredResult:) Delegate:self needUserType:Default];
}

-(void)onFindMessagePaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1)
            self.myMessageData = [MyMessageData getMyMessageData:dic];
        else
        {
            MyMessageData *aMyMessageData = [MyMessageData getMyMessageData:dic];
            [self.myMessageData.messagesAry addObjectsFromArray:aMyMessageData.messagesAry];
        }
        
        [myTableView reloadData];
        [self setHeaderView];
    }
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	
	return [self.myMessageData.messagesAry count];
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
        UISubLabel * label = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 12, tableView.frame.size.width/2 - 20, 25) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        label.tag = 99;
        [cell addSubview:label];
        UISubLabel * label1 = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 3, tableView.frame.size.width - 45-10, 44) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentRight];
        label1.tag = 199;
		[cell addSubview:label1];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    Message *message = (Message*)[self.myMessageData.messagesAry objectAtIndex:indexPath.row];
    UISubLabel * label = (UISubLabel *)[cell viewWithTag:99];
    label.text = message._title;
    UISubLabel * label1 = (UISubLabel *)[cell viewWithTag:199];
    label1.text = [self getTimeFormString:message._time];

	return cell;
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailViewController * detailVC = [[MessageDetailViewController alloc] init];
    detailVC._delegate = self;
    detailVC.myMessage = (Message*)[self.myMessageData.messagesAry objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate －－上拉涮新委托方法

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark Data Source Loading / Reloading －－上拉涮新相关

//实现上拖的方法
- (void)reloadTableViewDataSource
{
	if (pageIndex == [self.myMessageData.messagesAry count])
    {
        return;
    }
    pageIndex++;
    [self loadDataSource];
    reloading = YES;
}



//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadMyTableView
{
    pageIndex = 1;
    [self loadDataSource];
}
@end

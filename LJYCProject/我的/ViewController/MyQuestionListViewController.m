//
//  MyQuestionListViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MyQuestionListViewController.h"
#import "ShopForAQCell.h"
#import "ShopForDetailsViewController.h"
#import "MyQCell.h"
@interface MyQuestionListViewController ()

@end

@implementation MyQuestionListViewController
@synthesize userForQuestionData,myTableView;
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
    self.userForQuestionData = nil;
    self.myTableView = nil;
    
    [super dealloc];
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
    if(pageIndex == [self.userForQuestionData._totalPage intValue] && [self.userForQuestionData._totalPage intValue] != 1)
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
    self.title = @"我的问答";
    pageIndex = 1;

  
	// Do any additional setup after loading the view.
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 320, ViewHeight-44-10) style:UITableViewStylePlain];
    self.myTableView = aTableView;
    [aTableView release];
    self.myTableView.delegate = self;
    self.myTableView.dataSource =self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView setBackgroundColor:[UIColor clearColor]];
    [self.view_IOS7 addSubview:self.myTableView];
    
    [self isrefreshHeaderView];
	[self loadFitstDataSource];
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [userForQuestionData._questionArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UserForQuestionInfo *userForQuestionInfo = [userForQuestionData._questionArr objectAtIndex:section];
    if([userForQuestionInfo._replyTime intValue] ==  0)
        return 2;
    else
        return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserForQuestionInfo *userForQuestionInfo = [self.userForQuestionData._questionArr objectAtIndex:indexPath.section];
    CGSize contentSize = [userForQuestionInfo._content sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize contentSize2 = [userForQuestionInfo._replyContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if (indexPath.row == 0)
        return 30;
    else if (indexPath.row == 1)
    {
        if([userForQuestionInfo._replyTime intValue] == 0)
            return contentSize.height + 40;
        else
            return contentSize.height + 20;
    }
    else
    {
        if([userForQuestionInfo._replyTime intValue] == 0)
            return contentSize.height + 60;
        else
            return contentSize2.height + 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"identifier%d%d",indexPath.section,indexPath.row];
    
    UserForQuestionInfo *userForQuestionInfo = [[UserForQuestionInfo alloc] init];
    userForQuestionInfo = [self.userForQuestionData._questionArr objectAtIndex:indexPath.section];
    if (indexPath.row == 0)
    {
        
        ShopStarCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            
            cell = [[[ShopStarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        int shopStar = [userForQuestionInfo._shopStar floatValue];
        if(shopStar != -1)
            [cell setStar:shopStar];
        else
            [cell setStar:0];
        
        [cell._name setText:userForQuestionInfo._shopName];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        
        MyQCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)  {
            
            cell = [[[MyQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
        }
        CGSize contentSize = [userForQuestionInfo._content sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGRect imageFrame = cell._imageView.frame;
        imageFrame.size.height = contentSize.height + 25;
        cell._imageView.frame = imageFrame;
        
        CGRect verFrame = cell._content.frame;
        verFrame.size.height =  contentSize.height;
        cell._content.frame = verFrame;
        
        CGRect _dateFrame = cell._date.frame;
        _dateFrame.origin.y =  cell._imageView.frame.size.height- 15;
        cell._date.frame = _dateFrame;
        
        [cell._date setText:[self getTimeFormString:userForQuestionInfo._time]];
        [cell._content setText:userForQuestionInfo._content];
        return cell;
    }
    else
    {
        
        MyACell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            
            cell = [[[MyACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        CGSize contentSize = [userForQuestionInfo._replyContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
       
        CGRect imageFrame = cell._imageView.frame;
        imageFrame.size.height = contentSize.height + 25;
        cell._imageView.frame = imageFrame;
        
        CGRect verFrame = cell._content.frame;
        verFrame.size.height =  contentSize.height;
        cell._content.frame = verFrame;
        
        CGRect _dateFrame = cell._date.frame;
        _dateFrame.origin.y =  cell._imageView.frame.size.height- 15;
        cell._date.frame = _dateFrame;
        
        
        [cell._date setText:[self getTimeFormString:userForQuestionInfo._replyTime]];
        [cell._content setText:userForQuestionInfo._replyContent];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        UserForQuestionInfo * aUserForCommentInfo = [self.userForQuestionData._questionArr objectAtIndex:indexPath.section];
        
        ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:aUserForCommentInfo._shopId withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
    }
}

-(void)onPaseredShopDetailResult:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] isEqualToString:@"0"])
    {
        ShopForDetailsViewController *shopForDetailsVC = [[ShopForDetailsViewController alloc]init];
        shopForDetailsVC._detailData = [ShopForDataInfo setShopForDataInfo:dic];
        shopForDetailsVC._isSign = YES;
        [self.navigationController pushViewController:shopForDetailsVC animated:YES];
        [shopForDetailsVC release];
    }
    else
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    
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

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass getUserQAList:[UserLogin sharedUserInfo].userID PageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserQAListPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onUserQAListPaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1)
            self.userForQuestionData = [UserForQuestionData setUserForQuestionData:dic];
        else
        {
            UserForQuestionData *aUserForQuestionData = [UserForQuestionData setUserForQuestionData:dic];
            [self.userForQuestionData._questionArr addObjectsFromArray:aUserForQuestionData._questionArr];
        }
        
        [myTableView reloadData];
        [self setHeaderView];
    }
    
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
    if (pageIndex == self.userForQuestionData._questionArr.count)
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
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

@end

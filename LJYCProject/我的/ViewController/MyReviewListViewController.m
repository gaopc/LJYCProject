//
//  MyReviewListViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MyReviewListViewController.h"
#import "UserReviewCell.h"
#import "ShopForDetailsViewController.h"

@interface MyReviewListViewController ()

@end

@implementation MyReviewListViewController
@synthesize userForCommentData,myTableView;
@synthesize isfromRecomend;
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
    self.userForCommentData = nil;
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
    if(pageIndex == [self.userForCommentData._totalPage intValue] && [self.userForCommentData._totalPage intValue] != 1)
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
    self.title = @"我的点评";
    pageIndex = 1;
 
	// Do any additional setup after loading the view.
    [self.view_IOS7 addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, ViewHeight-44) image:[UIImage imageNamed:@"背景-中.png"]]];
    
    UISubLabel *lable = [UISubLabel labelWithTitle:@"评      价：" frame:CGRectMake(15, 10, 60, 30) font:FontSize24 alignment:NSTextAlignmentLeft];
    
    UISubLabel *commentNum = [UISubLabel labelWithTitle:nil frame:CGRectMake(70, 10, 50, 30) font:FontSize22 alignment:NSTextAlignmentLeft];
    commentNum.text = [NSString stringWithFormat:@"共%@条",self.userForCommentData._count];
    commentNum.textColor = FontColor454545;
    
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, ViewWidth, ViewHeight- 44-35)];
    self.myTableView = aTableView;
    [aTableView release];
    
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.allowsSelection = YES;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
    [self.view_IOS7 addSubview:lable];
    [self.view_IOS7 addSubview:commentNum];
    [self.view_IOS7 addSubview:myTableView];
   
    
    
    
    [self isrefreshHeaderView];
	[self loadFitstDataSource];
}

-(void)edit:(UIButton*)sender
{
    
}

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass getUserCommentList:[UserLogin sharedUserInfo].userID PageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserCommentListPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onUserCommentListPaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1)
            self.userForCommentData = [UserForCommentData setUserForCommentData:dic];
        else
        {
            UserForCommentData *aUserForCommentData = [UserForCommentData setUserForCommentData:dic];
            [self.userForCommentData._commentArr addObjectsFromArray:aUserForCommentData._commentArr];
        }
        
        [myTableView reloadData];
        [self setHeaderView];
    }
}

#pragma mark - Table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [userForCommentData._commentArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserForCommentInfo * aUserForCommentInfo = [userForCommentData._commentArr objectAtIndex:indexPath.row];
    CGSize contentSize = [aUserForCommentInfo._content sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize contentSize2 = [aUserForCommentInfo._replyContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    if([aUserForCommentInfo._replyTime intValue] == 0)
    {
        return contentSize.height+61;
    }
    else
    {
        return  contentSize.height+contentSize2.height+101;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"identifier%d",indexPath.row];
    UserForCommentInfo * aUserForCommentInfo = [userForCommentData._commentArr objectAtIndex:indexPath.row];
    
    UserReviewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[[UserReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    CGSize contentSize = [aUserForCommentInfo._content sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect serFrame = cell._content.frame;
    serFrame.size.height = contentSize.height;
    cell._content.frame = serFrame;
    
    CGRect horFrame = cell.horizontalView1.frame;
    horFrame.origin.y = cell._content.frame.origin.y + cell._content.frame.size.height + 10;
    cell.horizontalView1.frame = horFrame;
    
    CGRect verFrame = cell.verticalView1.frame;
    verFrame.size.height = contentSize.height + 60;
    cell.verticalView1.frame = verFrame;
    

    [cell setStar:[aUserForCommentInfo._star floatValue]];
    [cell._name setText:aUserForCommentInfo._shopName];
    [cell._content setText:aUserForCommentInfo._content];
    [cell._date setText:[self getTimeFormString:aUserForCommentInfo._time]];

    
    if([aUserForCommentInfo._replyTime intValue] == 0)
    {
        cell.horizontalView1.hidden = NO;
        
        cell.verticalView2.hidden = YES;
        cell.horizontalView2.hidden = YES;
        cell.imageView.hidden = YES;
        cell.label.hidden = YES;
        cell.reViewContentLabel.hidden = YES;
        cell.reViewTimeLabel.hidden = YES;
    }
    else
    {
        cell.horizontalView1.hidden = YES;
        
        CGSize contentSize2 = [aUserForCommentInfo._replyContent sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        
        
        CGRect imageFrame2 = cell.imageView.frame;
        imageFrame2.origin.y = cell._content.frame.origin.y + cell._content.frame.size.height;
        imageFrame2.size.height = contentSize2.height + 40;
        cell.imageView.frame = imageFrame2;
        
        CGRect labelFrame2 = cell.label.frame;
        labelFrame2.origin.y = cell._content.frame.origin.y + cell._content.frame.size.height + 20;
        cell.label.frame = labelFrame2;
        
        CGRect rtimeFrame2 = cell.reViewTimeLabel.frame;
        rtimeFrame2.origin.y = cell._content.frame.origin.y + cell._content.frame.size.height + 10;
        cell.reViewTimeLabel.frame = rtimeFrame2;
        
        CGRect reViewFrame2 = cell.reViewContentLabel.frame;
        reViewFrame2.origin.y = cell._content.frame.origin.y + cell._content.frame.size.height + 10 ;
        reViewFrame2.size.height = contentSize2.height + 60;
        cell.reViewContentLabel.frame = reViewFrame2;
        
        
        CGRect horFrame2 = cell.horizontalView2.frame;
        horFrame2.origin.y = cell.imageView.frame.origin.y + cell.imageView.frame.size.height + 10;
        cell.horizontalView2.frame = horFrame2;
  
        CGRect verFrame2 = cell.verticalView2.frame;
        verFrame2.origin.y = contentSize.height + 60;
        verFrame2.size.height = cell.horizontalView2.frame.origin.y + cell.horizontalView2.frame.size.height - contentSize.height - 60;
        cell.verticalView2.frame = verFrame2;
        
        
        cell.verticalView2.hidden = NO;
        cell.horizontalView2.hidden = NO;
        cell.imageView.hidden = NO;
        cell.label.hidden = NO;
        cell.reViewContentLabel.hidden = NO;
        cell.reViewTimeLabel.hidden = NO;

        [cell.reViewContentLabel setText:aUserForCommentInfo._replyContent];
        [cell.reViewTimeLabel setText:[self getTimeFormString:aUserForCommentInfo._replyTime]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserForCommentInfo * aUserForCommentInfo = [userForCommentData._commentArr objectAtIndex:indexPath.row];

    ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:aUserForCommentInfo._shopId withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
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
    if (pageIndex == self.userForCommentData._commentArr.count)
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

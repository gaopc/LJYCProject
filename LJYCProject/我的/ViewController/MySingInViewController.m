//
//  MySingInViewController.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MySingInViewController.h"
#import "MySignInInfoCell.h"
#import "ShopForDetailsViewController.h"
@interface MySingInViewController ()

@end

@implementation MySingInViewController
@synthesize myUserSignInData,myTableView,isfromRecomend;

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
    self.myUserSignInData = nil;
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
    if(pageIndex == [self.myUserSignInData.totalPage intValue] && [self.myUserSignInData.totalPage intValue] != 1)
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
    self.title = @"我的签到";
	// Do any additional setup after loading the view.
    pageIndex = 1;
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, ViewHeight-44) style:UITableViewStylePlain];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myUserSignInData.signIns.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//     NSString *identifier = [NSString stringWithFormat:@"identifier%d%d",indexPath.section,indexPath.row];
//    
//    SingInCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        
//        cell = [[[SingInCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor clearColor];
//        
//        
//        SignInInfo *leftSignInInfo = [self.myUserSignInData.signIns objectAtIndex:indexPath.row*2];
//        float leftRandom = arc4random()%30/180.0f;
//        cell.leftView.transform = CGAffineTransformRotate(cell.leftView.transform, M_PI*leftRandom);
//        cell.leftBtn.tag = indexPath.row*2;
//        [cell.leftName setTextColor:[UIColor colorWithRed:((arc4random()%155)/255.0f) green:(arc4random()%155)/255.0f blue:(arc4random()%155)/255.0f alpha:1]];
//        [cell.leftName setText:leftSignInInfo._shopName];
//        [cell.leftDate setText:leftSignInInfo._time];
//        
//        if([self.myUserSignInData.signIns count] > indexPath.row*2+1)
//        {
//            cell.rightView.hidden = NO;
//            
//            SignInInfo *rightSignInInfo = [self.myUserSignInData.signIns objectAtIndex:indexPath.row*2+1];
//            float rightRandom = (1-arc4random()%30/180.0f)+1;
//            cell.rightView.transform = CGAffineTransformRotate(cell.rightView.transform, M_PI*rightRandom);
//            cell.rightBtn.tag = indexPath.row*2+1;
//            [cell.rightName setTextColor:[UIColor colorWithRed:((arc4random()%155)/255.0f) green:(arc4random()%155)/255.0f blue:(arc4random()%155)/255.0f alpha:1]];
//            [cell.rightName setText:rightSignInInfo._shopName];
//            [cell.rightDate setText:rightSignInInfo._time];
//        }
//        else
//        {
//            cell.rightView.hidden = YES;
//        }
//    }
    
    SignInInfo *signInInfo = [self.myUserSignInData.signIns objectAtIndex:indexPath.row];
    NSString *identifier = [NSString stringWithFormat:@"identifier%d%d",indexPath.section,indexPath.row];
    
    MySignInInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[[MySignInInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        [cell.shopNameLabel setText:signInInfo._shopName];
        [cell.timeLabel setText: [self getTimeFormString:signInInfo._time ]];
  
        [cell setStar:[signInInfo._star intValue]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SignInInfo *signInInfo = [self.myUserSignInData.signIns objectAtIndex:indexPath.row];
    ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:signInInfo._shopId withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
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

-(void)click:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    SignInInfo *signInInfo = [self.myUserSignInData.signIns objectAtIndex:sender.tag];
    ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:signInInfo._shopId withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
}

-(void)onPaseredShopDetailResult:(NSDictionary*)dic
{
    ShopForDetailsViewController *shopForDetailsVC = [[ShopForDetailsViewController alloc]init];
    shopForDetailsVC._detailData = [ShopForDataInfo setShopForDataInfo:dic];
    shopForDetailsVC._isSign = YES;
    [self.navigationController pushViewController:shopForDetailsVC animated:YES];
    [shopForDetailsVC release];
}

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass userSingIn:[UserLogin sharedUserInfo].userID pageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserSingInPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onUserSingInPaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1)
            self.myUserSignInData = [UserSignInData getUserSignInData:dic];
        else
        {
            UserSignInData *aUserSignInData = [UserSignInData getUserSignInData:dic];
            [self.myUserSignInData.signIns addObjectsFromArray:aUserSignInData.signIns];
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
    if (pageIndex == self.myUserSignInData.signIns.count)
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

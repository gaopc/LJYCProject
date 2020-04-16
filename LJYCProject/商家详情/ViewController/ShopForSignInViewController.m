//
//  ShopForSignInViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-15.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForSignInViewController.h"
#import "ShopForSignViewController.h"
#import "SingInCell.h"
#import "MemberLoginViewController.h"

@interface ShopForSignInViewController ()

@end

@implementation ShopForSignInViewController
@synthesize _signInData,myTableView,isfromRecomend;
@synthesize _shopId;
@synthesize _butHiden;
@synthesize _delegate;

- (void)dealloc
{
    self._delegate = nil;
    self._signInData = nil;
    self.myTableView = nil;
    self._shopId = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"签到簿";
    pageIndex = 1;
	
    emptyView = [[UIView alloc] initWithFrame:self.view.bounds];
    if (self._signInData._count == 0) {
        emptyView.hidden = NO;
    }
    else {
        emptyView.hidden = YES;
    }
    
    UIImageView *emptyImg = [UIImageView ImageViewWithFrame:CGRectMake(40, 100, 50, 50) image:[UIImage imageNamed:@"空白页.png"]];
    UISubLabel *emptyLab = [UISubLabel labelWithTitle:@"没有人签到，可点击右上角签到" frame:CGRectMake(95, 100, 200, 50) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    [emptyView addSubview:emptyImg];
    [emptyView addSubview:emptyLab];
    [self.view addSubview:emptyView];
    
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
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(signIn) title:@"签到"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    if (self._butHiden) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)signIn
{
    if (NO == [self setUserLogin:ShopForSign]) {
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass signIn:[UserLogin sharedUserInfo].userID withShopId:self._shopId];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSignResult:) Delegate:self needUserType:Member];
}

- (void)onSignResult:(NSDictionary *)dic
{
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    
    if ([statusCode isEqualToString:@"0"]) {
        
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"HH:mm:ss"];
        NSString* str = [formatter stringFromDate:date];
        
        ShopForSignInData *aSignInInfo = [[ShopForSignInData alloc] init];
        aSignInInfo._userName = [UserLogin sharedUserInfo]._userName;
        aSignInInfo._time = str;
        
        if (!self._signInData) {
            self._signInData = [[ShopForSignData alloc] init];
        }
        [self._signInData._signDataArr addObject:aSignInInfo];
        
        [UIAlertView alertViewWithMessage:message tag:0 delegate:self];
    }
    else {
        [UIAlertView alertViewWithMessage:message];
    }
}

#pragma mark - Table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int num = (self._signInData._signDataArr.count +1)/2;
    return num;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"identifier%d%d",indexPath.section,indexPath.row];
    
    SingInCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[[SingInCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        float leftRandom = arc4random()%30/180.0f;
        cell.leftView.transform = CGAffineTransformRotate(cell.leftView.transform, M_PI*leftRandom);
        cell.leftBtn.tag = indexPath.row*2;
        [cell.leftName setTextColor:[UIColor colorWithRed:((arc4random()%155)/255.0f) green:(arc4random()%155)/255.0f blue:(arc4random()%155)/255.0f alpha:1]];
        
        
        
        float rightRandom = (1-arc4random()%30/180.0f)+1;
        cell.rightView.transform = CGAffineTransformRotate(cell.rightView.transform, M_PI*rightRandom);
        cell.rightBtn.tag = indexPath.row*2+1;
        [cell.rightName setTextColor:[UIColor colorWithRed:((arc4random()%155)/255.0f) green:(arc4random()%155)/255.0f blue:(arc4random()%155)/255.0f alpha:1]];
    }
    
    ShopForSignInData *dataInfo1 = [self._signInData._signDataArr objectAtIndex:indexPath.row*2];
    cell.leftName.text = dataInfo1._userName;
    cell.leftDate.text = dataInfo1._time;
    
    if (self._signInData._signDataArr.count%2 != 0 && indexPath.row == (self._signInData._signDataArr.count - 1)/2) {
        
        
    }
    else {
        ShopForSignInData *dataInfo2 = [self._signInData._signDataArr objectAtIndex:indexPath.row*2 + 1];
        cell.rightName.text = dataInfo2._userName;
        cell.rightDate.text = dataInfo2._time;
    }
    return cell;
}

#pragma mark - UIAlerViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    pageIndex = 1;
    [self loadDataSource];
    if (self._delegate && [self._delegate respondsToSelector:@selector(setSignCount)]) {
        [self._delegate performSelector:@selector(setSignCount)];
    }
}

- (BOOL)setUserLogin:(ShopClickType)type
{
    if (![UserLogin sharedUserInfo].userID)
    {
        MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
        memberLoginVC.delegate = self;
        memberLoginVC._clickType = type;
        [self.navigationController pushViewController:memberLoginVC animated:YES];
        [memberLoginVC release];
        return NO;
    }
    return YES;
}

-(void) loginSuccessFul:(ShopClickType)type
{
    if (type == ShopForSign) {
        
        [self signIn];
    }
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		if (_refreshHeaderView) {
//			myTableView.contentSize = CGSizeMake(ViewWidth, myTableView.contentSize.height-65.0f);
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
    if(pageIndex == [self._signInData._totalPage intValue] && [self._signInData._totalPage intValue] != 1)
    {
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
        myTableView.contentSize = CGSizeMake(ViewWidth, myTableView.contentSize.height-65.0f);
        return;
    }
    _refreshHeaderView.frame=CGRectMake(0.0f, myTableView.contentSize.height, myTableView.frame.size.width, 80);
    [self doneLoadingTableViewData];
}

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass shopSingIn:self._shopId withPageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onShopSingInPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onShopSingInPaseredResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1) {
            self._signInData = [ShopForSignData setShopForSignData:dic];
            
            if ([self._signInData._count intValue] != 0) {
                emptyView.hidden = YES;
            }
            
            if ([self._signInData._totalPage intValue] < 2) {
                
                self.isfromRecomend = YES;
                [self isrefreshHeaderView];
            }
            else {
                self.isfromRecomend = NO;
                [self isrefreshHeaderView];
            }
        }
        else {
            ShopForSignData *shopSignInData = [ShopForSignData setShopForSignData:dic];
            [self._signInData._signDataArr addObjectsFromArray:shopSignInData._signDataArr];
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
    if (pageIndex == self._signInData._signDataArr.count)
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
@end

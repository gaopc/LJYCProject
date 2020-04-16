//
//  ShopForAQListViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForAQListViewController.h"
#import "ShopForAQCell.h"
#import "ShopForQuestionViewController.h"
#import "MemberLoginViewController.h"

@interface ShopForAQListViewController ()

@end

@implementation ShopForAQListViewController
@synthesize _shopQuestData;
@synthesize isfromRecomend;
@synthesize _shopId;
@synthesize _butHiden;

- (void)dealloc
{
    self._shopQuestData = nil;
    self._shopId = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.title = @"问答";
    pageIndex = 1;
    
    emptyView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *emptyImg = [UIImageView ImageViewWithFrame:CGRectMake(40, 100, 50, 50) image:[UIImage imageNamed:@"空白页.png"]];
    UISubLabel *emptyLab = [UISubLabel labelWithTitle:@"没有提问内容，可点击右上角提问" frame:CGRectMake(95, 100, 200, 50) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    [emptyView addSubview:emptyImg];
    [emptyView addSubview:emptyLab];
    [self.view addSubview:emptyView];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 320, ViewHeight-44- 15) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view_IOS7 addSubview:myTable];
    [myTable release];
    
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(questionClick) title:@"提问"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    if (self._butHiden) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self isrefreshHeaderView];
	[self loadFitstDataSource];
    
    [self loadDataSource];
}

- (void)questionClick
{
    if (NO == [self setUserLogin:ShopForQuestion]) {
        return;
    }
    ShopForQuestionViewController *questionVC = [[ShopForQuestionViewController alloc] init];
    questionVC._delegate = self;
    questionVC._shopId = self._shopId;
    [self.navigationController pushViewController:questionVC animated:YES];
    [questionVC release];
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self._shopQuestData._questionArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ShopForQuestionInfo *questionInfo = [self._shopQuestData._questionArr objectAtIndex:section];
    if ([questionInfo._comReplyTime intValue] == 0) {
        
        return 1;
    }
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        ShopForQuestionInfo *questionInfo = [self._shopQuestData._questionArr objectAtIndex:indexPath.section];
        if ([questionInfo._comReplyTime intValue] == 0) {
            
            return 55;
        }
        return 50;
    }
    else {
        
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"identifier%d%d", indexPath.row, indexPath.section];
    
    ShopForQuestionInfo *questionInfo = [self._shopQuestData._questionArr objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        
        ShopForQCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)  {
            
            cell = [[[ShopForQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell._name.text = questionInfo._comName;
        cell._date.text = questionInfo._comTime;
        cell._content.text = questionInfo._comContent;
        return cell;
    }
    else {
        
        ShopForACell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            
            cell = [[[ShopForACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        long long dataLong = [questionInfo._comReplyTime longLongValue];
        double dateDou = dataLong/1000;
        NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString* str = [formatter stringFromDate:date];
        
        cell._name.text = @"店主";
        cell._date.text = str;
        cell._content.text = questionInfo._comReplyContent;
        return cell;
    }
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		if (_refreshHeaderView) {
			myTable.contentSize = CGSizeMake(ViewWidth, myTable.contentSize.height-65.0f);
			[_refreshHeaderView removeFromSuperview];
			_refreshHeaderView = nil;
		}
		
	}
	else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[myTable addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}

- (void)loadFitstDataSource
{
	[myTable reloadData];
	
	_refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

-(void)setHeaderView
{
    if(pageIndex == [self._shopQuestData._totalPage intValue] && [self._shopQuestData._totalPage intValue] != 1)
    {
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
        myTable.contentSize = CGSizeMake(ViewWidth, myTable.contentSize.height-65.0f);
        return;
    }
    _refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
    [self doneLoadingTableViewData];
}

-(void)loadDataSource
{
    ASIFormDataRequest * theRequest = [InterfaceClass getQuestionList:nil withShopId:self._shopId withFilter:@"0" withPageIndex:[NSString stringWithFormat:@"%d",pageIndex] withPageSize:@"20"];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopQuestionResult:) Delegate:self needUserType:Default];
}

-(void)onPaseredShopQuestionResult:(NSDictionary*)dic
{
    if([[dic objectForKey:@"statusCode"] isEqualToString:@"0"])
    {
        if(pageIndex == 1) {
            self._shopQuestData = [ShopForQuestionData setShopForQuestionData:dic];
            
            if ([self._shopQuestData._count intValue] != 0) {
                emptyView.hidden = YES;
            }
            
            if ([self._shopQuestData._totalPage intValue] < 2) {
                
                self.isfromRecomend = YES;
                [self isrefreshHeaderView];
            }
        }
        else {
            ShopForQuestionData *shopQAData = [ShopForQuestionData setShopForQuestionData:dic];
            [self._shopQuestData._questionArr addObjectsFromArray:shopQAData._questionArr];
        }
        
        [myTable reloadData];
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
    if (pageIndex == self._shopQuestData._questionArr.count)
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTable];
}

#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)reloadQuestionData:(id)sender
{
    [self loadDataSource];
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
    if (type == ShopForQuestion) {
        
        [self questionClick];
    }
}
@end

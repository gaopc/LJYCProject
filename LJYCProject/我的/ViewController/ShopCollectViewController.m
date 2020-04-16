//
//  ShopCollectViewController.m
//  LJYCProject
//
//  Created by z1 on 13-11-6.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopCollectViewController.h"
#import "ShopForDetailsViewController.h"
#import "DataClass.h"
#import "InterfaceClass.h"
#import "ASIFormDataRequest.h"
#import "ShopCollectDataResponse.h"
@interface ShopCollectViewController ()
- (void)loadDataSource;
//加载酒店详情数据
- (void)loadDelDataSource;
- (void)isrefreshHeaderView;
- (void)loadShopInfoSource;
- (void)loadFitstDataSource;
@end

@implementation ShopCollectViewController

@synthesize shopListArray,shops;
@synthesize h_tableView = _h_tableView;
@synthesize orderMenu,typeMenu,arrowUp1,arrowDown1,arrowUp2,arrowDown2,orderButton,typeButton;
@synthesize _dataIsFull,isfromRecomend,pageIndex,shopCollectDataResponse,collectProperty,promptlable,shopCollect;
@synthesize orderLabel,filterLabel,arrow1,arrow2,inputView,cityListArray,editButton,rightBar;
- (void) dealloc {
	
	self.orderMenu = nil;
	self.typeMenu = nil;
	self.arrowUp1 = nil;
	self.arrowDown1 = nil;
	self.arrowUp2 = nil;
	self.arrowDown2 = nil;
	self.orderButton = nil;
	self.typeButton = nil;
	self.h_tableView = nil;
	self.h_tableView.delegate = nil;
	self.h_tableView.dataSource = nil;
	self.shopListArray = nil;
	self.shopCollectDataResponse = nil;
	self.collectProperty =nil;
	self.promptlable =nil;
	self.shopCollect = nil;
	
	self.orderLabel = nil;
	self.filterLabel = nil;
	self.inputView = nil;
	self.cityListArray = nil;
	[_h_tableView release];
	self.shops = nil;
	self.editButton = nil;
	self.rightBar = nil;
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
	if (!self._dataIsFull) {
		pageIndex = 1;
		
		[self loadDataSource];
	}
	
	self._dataIsFull = FALSE;
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		[_refreshHeaderView removeFromSuperview];
		_refreshHeaderView = nil;
		
	}else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[self.h_tableView addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}


-(void)setHeaderView
{
	if([self.shopCollectDataResponse.totalPage intValue] <= 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		return;
	}
	if(pageIndex == [self.shopCollectDataResponse.totalPage intValue] &&[self.shopCollectDataResponse.totalPage intValue] != 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
		return;
	}
	_refreshHeaderView.frame=CGRectMake(0.0f, self.h_tableView.contentSize.height, self.h_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
        self.title = @"我的收藏";
	
	self.editButton = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(tableViewEdit:) title:@"编辑"];
	self.rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
	self.navigationItem.rightBarButtonItem = self.rightBar;
	
	
	UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	headView.backgroundColor = [UIColor whiteColor];
	
	self.orderButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(10, 7, 137, 25.5) backImage:[UIImage imageNamed:@"OLongButton.png"] target:self  action:@selector(order:)];
	[self.orderButton setImage:[UIImage imageNamed:@"OLongClickButton.png"] forState:UIControlStateHighlighted];
	[headView addSubview:self.orderButton];
	
	self.arrowDown1 =  [UIImageView ImageViewWithFrame:CGRectMake(110.0f, 17.0f, 8.7f, 7.0f) image:[UIImage imageNamed:@"ArrowDown.png"]];
	self.arrowDown1.hidden = NO;
	//[headView addSubview:self.arrowDown1];
	
	self.arrowUp1 =  [UIImageView ImageViewWithFrame:CGRectMake(110.0f, 17.0f, 8.7f, 7.0f) image:[UIImage imageNamed:@"ArrowUp.png"]];
	self.arrowUp1.hidden = YES;
	//[headView addSubview:self.arrowUp1];

	self.orderLabel  = [UISubLabel labelWithTitle:@"排序" frame:CGRectMake(20, 7, 94, 25.5) font:FontBlodSize20 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
	self.orderLabel.backgroundColor = [UIColor clearColor];
	[headView addSubview:self.orderLabel];
	
	self.arrow1 = YES;
	pageIndex = 1;
	
	self.typeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(165, 7, 137, 25.5) backImage:[UIImage imageNamed:@"OLongButton.png"] target:self   action:@selector(type:)];
	[self.typeButton setImage:[UIImage imageNamed:@"OLongClickButton.png"] forState:UIControlStateHighlighted];
	[headView addSubview:self.typeButton];
	
	self.arrowDown2 =  [UIImageView ImageViewWithFrame:CGRectMake(270.0f, 17.0f, 8.7f, 7.0f) image:[UIImage imageNamed:@"ArrowDown.png"]];
	self.arrowDown2.hidden = NO;
	//[headView addSubview:self.arrowDown2];
	
	self.arrowUp2 =  [UIImageView ImageViewWithFrame:CGRectMake(270.0f, 17.0f, 8.7f, 7.0f) image:[UIImage imageNamed:@"ArrowUp.png"]];
	self.arrowUp2.hidden = YES;
	//[headView addSubview:self.arrowUp2];
	
	self.filterLabel  = [UISubLabel labelWithTitle:@"筛选" frame:CGRectMake(175, 7, 94, 25.5) font:FontBlodSize20 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
	self.filterLabel.backgroundColor = [UIColor clearColor];
	[headView addSubview:self.filterLabel];
	
	self.arrow2 = YES;
	
	self.promptlable = [UISubLabel labelWithTitle:@"" frame:CGRectMake(30, 80, 200, 30) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
	self.promptlable.backgroundColor = [UIColor clearColor];
	self.promptlable.hidden = YES;
	[self.view_IOS7 addSubview:self.promptlable];
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,44.0f,ViewWidth,ViewHeight-86.0f) style:UITableViewStylePlain];
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
        self.h_tableView.separatorStyle = UITableViewCellAccessoryNone;
	[self.view_IOS7 addSubview:self.h_tableView];
	
	self.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ViewWidth, ViewHeight)];
	self.inputView.backgroundColor = [UIColor blackColor];
	self.inputView.alpha = 0.5;
	self.inputView.hidden = YES;
	[self.view_IOS7 addSubview:self.inputView];
	
	[self.inputView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(0.0f, 0.0f, self.inputView.frame.size.width, self.inputView.frame.size.height) backImage:nil target:self action:@selector(inputClick:)]];
	
	
	self.orderMenu = [[OrderMenuView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 130.0f)];
	self.orderMenu.orderArray = [NSArray arrayWithObjects:@"时间",@"星级", @"人气",nil];
	self.orderMenu.backgroundColor = [UIColor whiteColor];
	self.orderMenu.delegate = self;
	self.orderMenu.hidden = YES;
	[self.view_IOS7 addSubview:self.orderMenu];

	self.typeMenu = [[FilterMenuView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 240.0f)];
	self.typeMenu.backgroundColor = [UIColor whiteColor];
	self.typeMenu.hidden = YES;
	//self.typeMenu.typeArray = [DataClass selectShopType];
	self.typeMenu.delegate = self;
	[self.view_IOS7 addSubview:self.typeMenu];
	
	[self.view_IOS7 addSubview:headView];
	[headView release];
	
	[self isrefreshHeaderView];
	
	
	if (!self.collectProperty) {
		
		self.collectProperty = [[CollectProperty alloc]init];
		self.collectProperty._userId = [UserLogin sharedUserInfo].userID;
		self.collectProperty._pageIndex =@"1";
		self.collectProperty._order = @"0";
		self.collectProperty._shopTypeId = @"";
		self.collectProperty._cityId = @"";
		
	}
	

	[self loadFitstDataSource];
}


//加载数据
- (void)loadDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass userFindCollect:self.collectProperty];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryHotelPaseredResult:) Delegate:self needUserType:Default];
	
}


//加载数据
- (void)loadFitstDataSource
{
	[self.h_tableView reloadData];
	_refreshHeaderView.frame=CGRectMake(0.0f, self.h_tableView.contentSize.height, self.h_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

//加载成功
- (void)onqueryHotelPaseredResult:(NSDictionary *)dic
{
	
	self.shopCollectDataResponse = [ShopCollectDataResponse findCollect:dic];
	self.cityListArray =  self.shopCollectDataResponse.citys;
	self.typeMenu.cityArray = self.cityListArray;
	if (self.typeMenu.currentTag== 0) {
		[self.typeMenu getCityDictionary];
	}
	
	if (pageIndex==1)
		self.shopListArray = self.shopCollectDataResponse.collects;
	else
		[self.shopListArray addObjectsFromArray:self.shopCollectDataResponse.collects];
	
	if (self.shopListArray.count <=0) {
		self.promptlable.hidden = NO;
		self.promptlable.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]];
	}else{
		self.promptlable.hidden = YES;
	}
	[self.h_tableView reloadData];
	[self setHeaderView];
	
	
}

//加载酒店详情数据
- (void)loadShopInfoSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:self.shopCollect._id withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
	
}

//删除收藏
-(void) loadDelDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass userDelCollect:[UserLogin sharedUserInfo].userID shopId:self.shopCollect._id];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	
}

//加载成功
- (void)onPaseredShopDetailResult:(NSDictionary *)dic
{
	if ([ShopForDataInfo setShopForDataInfo:dic]) {
		
		ShopForDetailsViewController *shopForDetailsVC = [[ShopForDetailsViewController alloc]init];
		shopForDetailsVC.shops = self.shops;
		shopForDetailsVC._detailData = [ShopForDataInfo setShopForDataInfo:dic];
		shopForDetailsVC._isSign = TRUE;
		[self.navigationController pushViewController:shopForDetailsVC animated:YES];
		[shopForDetailsVC release];
	}
}


- (void)onDelPaseredResult:(NSDictionary *)dic
{
	if (self.shopListArray.count <=0) {
		pageIndex = 1;
		self.collectProperty._pageIndex = [NSString stringWithFormat:@"%d",pageIndex];
		//[self.shopListArray removeAllObjects];
		
	}
	[self loadDataSource];
}

-(void)inputClick:(UIButton *)sender
{
	self.inputView.hidden = YES;
    
	self.orderMenu.hidden = YES;
	[self.orderButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
	self.arrow1 = YES;
	self.typeMenu.hidden = YES;
	[self.typeButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
	self.arrow2 = YES;
}

-(void) order:(UIButton *)sender
{
	[self.typeButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
	self.arrow2 = YES;
	self.typeMenu.hidden = YES;
	
	if (self.arrow1) {
		
		self.inputView.hidden = NO;
		self.orderMenu.hidden = NO;
		self.orderMenu.alpha = 0.0;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.orderMenu.alpha = 1.0f;
		[UIView commitAnimations];
		
		[self.orderButton setImage:[UIImage imageNamed:@"OLongClickButton.png"] forState:UIControlStateNormal];
		self.arrow1 = NO;
		
//		self.arrowDown1.hidden = YES;
//		self.arrowUp1.hidden = NO;
//		
//		self.arrowDown2.hidden = NO;
//		self.arrowUp2.hidden = YES;
		
		
		
		
	}else {
		self.inputView.hidden = YES;
		self.orderMenu.alpha = 1.0f;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.orderMenu.alpha = 0.0;
		[UIView commitAnimations];
		self.orderMenu.hidden = NO;
		[self.orderButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
		self.arrow1 = YES;
//		self.arrowDown1.hidden = NO;
//		self.arrowUp1.hidden = YES;
		
	}
}

-(void)orderMenu:(int) orderBy
{
	pageIndex = 1;
	
	self.collectProperty._pageIndex = [NSString stringWithFormat:@"%d",pageIndex];
	self.collectProperty._order = [NSString stringWithFormat:@"%d",orderBy];
	self.collectProperty._shopTypeId =@"";
	
	if (self.isfromRecomend) {
		self.isfromRecomend = FALSE;
		[self isrefreshHeaderView];
	}
	
	
	
	self.orderMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	self.orderMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.orderMenu.hidden = NO;
	
	[self.orderButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
	self.arrow1 = YES;
	self.inputView.hidden = YES;
//	self.arrowDown1.hidden = NO;
//	self.arrowUp1.hidden = YES;
	
	
	[self loadDataSource];
}

-(void) type:(UIButton *)sender
{
	
	self.orderMenu.hidden = YES;
	self.arrow1 = YES;
	[self.orderButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
	
	if (self.arrow2) {
		
		self.typeMenu.hidden = NO;
		self.inputView.hidden = NO;
		self.typeMenu.alpha = 0.0;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.typeMenu.alpha = 1.0f;
		[UIView commitAnimations];
		
		[self.typeButton setImage:[UIImage imageNamed:@"OLongClickButton.png"] forState:UIControlStateNormal];
		self.arrow2 = NO;
		
//		self.arrowDown2.hidden = YES;
//		self.arrowUp2.hidden = NO;
//		
//		self.arrowDown1.hidden = NO;
//		self.arrowUp1.hidden = YES;
		
		
	}else {
		self.typeMenu.alpha = 1.0f;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		self.typeMenu.alpha = 0.0;
		[UIView commitAnimations];
		self.typeMenu.hidden = NO;
		self.inputView.hidden = YES;
		[self.typeButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
		self.arrow2 = YES;
//		self.arrowDown2.hidden = NO;
//		self.arrowUp2.hidden = YES;
		
	}
	
	
	
}

-(void)typeMenu:(NSString*) tag
{
	pageIndex = 1;
	self.typeMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	self.typeMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.typeMenu.hidden = NO;
//	self.arrowDown2.hidden = NO;
//	self.arrowUp2.hidden = YES;
	self.inputView.hidden = YES;
	[self.typeButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
	self.arrow2 = YES;
	
	[self loadDataSource];
}

-(void)filterMenu:(NSString*)cityId type:(NSString*)type
{
	pageIndex = 1;
	
	self.collectProperty._pageIndex = [NSString stringWithFormat:@"%d",pageIndex];
	
	if (cityId!=nil) {
		self.collectProperty._cityId = cityId;
	}else{
		self.collectProperty._cityId = @"";
	}
	if (type!=nil) {
		self.collectProperty._shopTypeId = type;
	}else{
		self.collectProperty._shopTypeId = @"";
	}
	
	if (self.isfromRecomend) {
		self.isfromRecomend = FALSE;
		[self isrefreshHeaderView];
	}
	
	self.typeMenu.alpha = 1.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	self.typeMenu.alpha = 0.0;
	[UIView commitAnimations];
	self.typeMenu.hidden = NO;
	//	self.arrowDown2.hidden = NO;
	//	self.arrowUp2.hidden = YES;
	self.inputView.hidden = YES;
	[self.typeButton setImage:[UIImage imageNamed:@"OLongButton.png"] forState:UIControlStateNormal];
	self.arrow2 = YES;
	
	[self loadDataSource];

	
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}

- (void)tableViewEdit:(id)sender{

	[sender setTitle:[self.h_tableView isEditing]? @"编辑" :@"完成" forState:UIControlStateNormal];
	
	[self.h_tableView setEditing:!self.h_tableView.editing animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		self.shopCollect = (ShopCollect *)[self.shopListArray objectAtIndex:indexPath.row];
		if(pageIndex == [self.shopCollectDataResponse.totalPage intValue]){
			[self.shopListArray removeObjectAtIndex:indexPath.row];
			[self.h_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
		[self loadDelDataSource];
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
	
	

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	
	return [self.shopListArray count];
	
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 96.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	static NSString * identifier = @"identifier";
	ShopCollectCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[ShopCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.delegate = self;
		
		UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
		selectedView.backgroundColor = [UIColor clearColor];
		UIImageView *bgClickImageView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 5.0f, 300.0f, 86.0f) image:[UIImage imageNamed:@"ShopListCellClickBg.png"]];
		[selectedView addSubview:bgClickImageView];
		cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
		[selectedView release];

	}
	ShopCollect *shop = nil;
	shop = (ShopCollect *)[self.shopListArray objectAtIndex:indexPath.row];
	cell.name.text = shop._name;
	cell.phoneButton.tag = indexPath.row;
	cell.serviceTags.text = shop._serviceTags;
	cell.area.text = shop._district;
	
	if ([shop._state intValue] == 0) {
		cell.phoneButton.hidden = NO;
		cell.phoneNoButton.hidden = YES;
		cell.shopClose.hidden = YES;
		cell.shopRest.hidden = YES;
		
	}if ([shop._state intValue] == 1) {
		cell.phoneNoButton.hidden = NO;
		cell.phoneButton.hidden = YES;
		cell.shopClose.hidden = NO;
		cell.shopRest.hidden = YES;
	}if ([shop._state intValue] == 2) {
		cell.phoneNoButton.hidden = YES;
		cell.phoneButton.hidden = NO;
		cell.shopClose.hidden = YES;
		cell.shopRest.hidden = NO;
	}
	if ([shop._isNotice boolValue]== NO)
	
		cell.notice.hidden = YES;
	else
		cell.notice.hidden = NO;
	
	[cell.shopImageView setUrlString:shop._picUrl];
	[cell drawStarCodeView:[shop._star floatValue]];
	return cell;
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	//[self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 74)];
	
	self.shopCollect = (ShopCollect *)[self.shopListArray objectAtIndex:indexPath.row];
	[self loadShopInfoSource];
	
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
	if(pageIndex == [self.shopCollectDataResponse.totalPage intValue])
	{
		return;
	}
	pageIndex++;
	self.collectProperty._pageIndex = [NSString stringWithFormat:@"%d" ,pageIndex];
	[self loadDataSource];
	reloading = YES;
}

//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.h_tableView];
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

- (void)phoneClick:(UIButton *)sender
{
	self.shops = (Shops *)[self.shopListArray objectAtIndex:sender.tag];
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"拨打电话：%@", self.shops._telephone] delegate:self cancelButtonTitle:@"确认"
					    otherButtonTitles:@"取消", nil];
	
	
	[alert show];
	[alert release];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self callTel:self.shops._telephone];
	}
}

@end

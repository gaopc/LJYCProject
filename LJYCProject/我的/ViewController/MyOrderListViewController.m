//
//  MyOrderListViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "AsyncImageView.h"
#import "ShopForOrderViewController.h"
#import "OrderDetailsData.h"
#import "ShopTuanDetailsViewController.h"
#import "VoucherObligationOrderDetailViewController.h"
#import "VoucherUnusedOrderDetailViewController.h"
#import "VoucherUsedOrderDetailViewController.h"
#import "VoucherRefundedOrderDetailViewController.h"

#import "VoucherTakeOrderViewController.h"

@interface OrderListCell : UITableViewCell
//@property (nonatomic,retain) AsyncImageView *shopImageView;
@property (nonatomic,retain) UISubLabel *_name; //名称
@property (nonatomic,retain) UISubLabel *_sale; //价格
@property (nonatomic,retain) UISubLabel *_smallSale; //价格
@property (nonatomic,retain) UISubLabel *_count; //数量
@property (nonatomic,retain) UISubLabel *_state; // 状态
@property (nonatomic,retain) UIImageView *_areaView; // 色块

@end

@implementation OrderListCell
@synthesize _count,_name,_sale,_smallSale,_state, _areaView;
- (void)dealloc
{
    self._areaView = nil;
    self._name = nil;
    self._sale = nil;
    self._smallSale = nil;
    self._count = nil;
    self._state = nil;

    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 100) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        [self addSubview:backView];
        
        self._areaView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 205, 90)];
        self._areaView.backgroundColor = [UIColor colorWithRed:38.0/255.0f green:159.0/255.0f blue:209.0/255.0f alpha:1];
        [self addSubview:self._areaView];
		
		self._name =   [UISubLabel labelWithTitle:@"李金喜采摘园" frame:CGRectMake(20, 5, ViewWidth-20, 30) font:FontSize36 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
		[self addSubview:self._name];
        
        [self addSubview:[UILabel labelWithTitle:@"¥" frame:CGRectMake(22, 60, 30, 20) font:[UIFont systemFontOfSize:15] color:FontColorFFFFFF alignment:NSTextAlignmentLeft autoSize:NO]];
        
        self._sale = [UISubLabel labelWithTitle:@"20.00" frame:CGRectMake(34, 45, ViewWidth-20, 40) font:[UIFont systemFontOfSize:30] color:FontColorFFFFFF alignment:NSTextAlignmentLeft autoSize:NO];
        [self addSubview:self._sale];
        [self addSubview:[UISubLabel labelWithTitle:@"支付数量" frame:CGRectMake(ViewWidth-105, 15, 40, 40) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:YES]];
        
        self._smallSale = [UISubLabel labelWithTitle:@"20.00" frame:CGRectMake(ViewWidth-15-90, 15, 90, 20) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentRight autoSize:NO];
        [self addSubview:self._smallSale];
        
        self._count = [UISubLabel labelWithTitle:@"x2" frame:CGRectMake(ViewWidth-15-90, 33, 90, 20) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentRight autoSize:NO];
        [self addSubview:self._count];
        
        self._state = [UISubLabel labelWithTitle:@"未使用" frame:CGRectMake(10, 70, ViewWidth-20-5, 20) font:[UIFont systemFontOfSize:15] color:[UIColor colorWithRed:53.0/255.0f green:214.0/255.0f blue:128.0/255.0f alpha:1] alignment:NSTextAlignmentRight autoSize:NO];
        [self addSubview:self._state];


	}
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    self.backgroundColor = [UIColor clearColor];

	return self;
}


@end


@interface MyOrderListViewController ()
{
    UIButton * proBtn;
}
- (void)loadDataSource;
- (void)isrefreshHeaderView;
- (void)loadFitstDataSource;
- (void)loadOrderInfoSource;
@end

@implementation MyOrderListViewController

@synthesize _dataIsFull,isfromRecomend,saleArray,myTableView,totalPage,orders;

-(void)dealloc
{
//    self.didSaleArray = nil;
//    self.notSaleArray = nil;
    self.saleArray = nil;
	self.myTableView = nil;
	self.orders = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
	if (!self._dataIsFull) {
		pageIndex = 1;
		
		[self loadDataSource];
	}
	
	//self._dataIsFull = FALSE;
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
			[self.myTableView addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}

-(void)setHeaderView
{
	if(self.totalPage <= 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		return;
	}
	if(pageIndex == self.totalPage && self.totalPage != 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		self.myTableView.contentSize = CGSizeMake(ViewWidth, self.myTableView.contentSize.height-65.0f);
		
		return;
	}
	_refreshHeaderView.frame=CGRectMake(0.0f, self.myTableView.contentSize.height, self.myTableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

-(void)loadView
{
    [super loadView];
    
//    self.notSaleArray = [NSArray arrayWithObjects:@"0",@"0", @"0", @"0", @"0", @"0",  nil];
//    self.didSaleArray = [NSArray arrayWithObjects:@"0",@"0", @"0", @"0",  nil];

//    self.notSaleArray = [FindOrders getFindOrders:nil]._ordersArr;
//    self.didSaleArray = [FindOrders getFindOrders:nil]._ordersArr;
    self.isfromRecomend = YES;
    
    
    selectedTypeNow = 0;
    pageIndex = 1;
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.view_IOS7 addSubview:topView];
    [topView release];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ViewWidth - 20, 30)];
    [backView setBackgroundColor:[UIColor colorWithRed:38.0/255.0f green:159.0/255.0f blue:209.0/255.0f alpha:1]];
    backView.center = topView.center;
    backView.layer.cornerRadius = 3;
    [topView addSubview:backView];
    [backView release];

    NSArray * arr = [NSArray arrayWithObjects:@"全部", @"待付款",@"未消费",@"已消费",@"已退款",nil];
    btnSelectedView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ((ViewWidth - 20)/[arr count]), 30)];
    btnSelectedView.backgroundColor = [UIColor colorWithRed:18.0/255.0f green:188.0/255.0f blue:230.0/255.0f alpha:1];
    btnSelectedView.layer.cornerRadius = 3;
    [topView addSubview:btnSelectedView];
    [btnSelectedView release];
    
    for (int i=0; i<[arr count]; i++) {
        UIColor * color ;
        if (i==0) {
            color = [UIColor whiteColor];
        }
        else
        {
            color = [UIColor whiteColor];
        }
        UIButton * btn =  [UIButton buttonWithType:UIButtonTypeCustom tag:i title:[arr objectAtIndex:i] backImage:nil frame:CGRectMake(10 + i*((ViewWidth - 20)/[arr count]), 0, ((ViewWidth - 20)/[arr count]), 44) font:[UIFont systemFontOfSize:12] color:color target:self action:@selector(voucherListType:)];
        [topView addSubview:btn];
        if (i==0) {
            proBtn = btn;
            btnSelectedView.center = btn.center;
        }
    }
    
    
//    notSaleBtn =  [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"未付款" backImage:nil frame:CGRectMake(0, 0, 320/2, 44) font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor] target:self action:@selector(btnNotSale:)];
//    [topView addSubview:notSaleBtn];
//    btnSelectedView.center = notSaleBtn.center;
//    didSaleBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"已付款" backImage:nil frame:CGRectMake(320/2, 0, 320/2, 44) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] target:self action:@selector(btnDidSale:)];
//    [topView addSubview:didSaleBtn];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, ViewHeight-90) style:UITableViewStylePlain];
    self.myTableView.backgroundColor = [UIColor clearColor];
	self.myTableView.dataSource = self;
	self.myTableView.delegate = self;
	self.myTableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view_IOS7 addSubview:self.myTableView];
    
	
	[self isrefreshHeaderView];
	
	[self loadFitstDataSource];

}

//加载数据
- (void)loadFitstDataSource
{
	[self.myTableView reloadData];
	_refreshHeaderView.frame=CGRectMake(0.0f, self.myTableView.contentSize.height, self.myTableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}
- (void)loadDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass findOrder:[UserLogin sharedUserInfo].userID filter:[NSString stringWithFormat:@"%ld",selectedTypeNow] pageIndex:[NSString stringWithFormat:@"%d", pageIndex]];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFindOrderPaseredResult:) Delegate:self needUserType:Default];
	
//	if (pageIndex==1)
////		self.saleArray = [NSMutableArray arrayWithObjects:@"0",@"0", @"0", @"0", @"0", @"0",@"0",@"0",@"0",@"0",  nil];
//	self.saleArray = [FindOrders getFindOrders:nil]._ordersArr;
//	else if(pageIndex==2)
//		
//		[self.saleArray addObjectsFromArray:[NSArray arrayWithObjects:@"0",@"0", @"0", @"0", @"0", @"0",@"0",@"0",@"0",@"0", nil]];
//
//	else
//		[self.saleArray addObjectsFromArray:[NSArray arrayWithObjects:@"0",@"0", @"0",nil]];
//	
//	[self.myTableView reloadData];
//	[self setHeaderView];
}

-(void)onFindOrderPaseredResult:(NSDictionary*)dic
{
	
    self.totalPage = [[dic objectForKey:@"totalPage"] intValue];
    if (self.totalPage > 1) {
        self.isfromRecomend = NO;
        [self isrefreshHeaderView];
    }
	if (pageIndex==1)
		self.saleArray = [FindOrders getFindOrders:dic]._ordersArr;
	else
		[self.saleArray addObjectsFromArray:[FindOrders getFindOrders:dic]._ordersArr];
	
//	if (self.saleArray.count <=0) {
//		self.promptlable.hidden = NO;
//		self.promptlable.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]];
//	}else{
//		self.promptlable.hidden = YES;
//	}
	[self.myTableView reloadData];
	[self setHeaderView];
	
}

//加载订单详情数据
- (void)loadOrderInfoSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass orderDetail:self.orders._orderId];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredOrderDetailResult:) Delegate:self needUserType:Default];
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的代金券";
    
	// Do any additional setup after loading the view.
}
- (void)voucherListType:(UIButton *)sender
{
    pageIndex = 1;
    myTableView.contentOffset = CGPointMake(0, 0);
    btnSelectedView.center = sender.center;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if(proBtn != sender)
    {
        [proBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    proBtn = sender;
    selectedTypeNow = sender.tag > 1 ? sender.tag + 1 : sender.tag;
//    if (!self.isfromRecomend) {
//        self.isfromRecomend = FALSE;
//        [self isrefreshHeaderView];
//    }
    [self loadDataSource];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
//    if (selectedTypeNow == 0) {
//        return [self.notSaleArray count];
//    }
    return [self.saleArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OrderListCellIdentifier = @"OrderListCellIdentifier";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderListCellIdentifier];
    if (cell == nil) {
        cell = [[[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderListCellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row%2 == 0) {
            cell._areaView.backgroundColor = [UIColor colorWithRed:38.0/255.0f green:159.0/255.0f blue:209.0/255.0f alpha:1];
        }
        else {
            cell._areaView.backgroundColor = [UIColor colorWithRed:53.0/255.0f green:214.0/255.0f blue:128.0/255.0f alpha:1];
        }
    }

   self.orders =  [self.saleArray objectAtIndex:indexPath.row];
  
    switch ([self.orders._state intValue]) {
        case 1:
            cell._state.text = @"代付款";
            break;
        case 3:
            cell._state.text = @"已使用";
            break;
        case 4:
             cell._state.text = @"未使用";
            break;
        case 5:
             cell._state.text = @"已退款";
            break;
            
        default:
            cell._state.text = @"";
            break;
    }


    cell._name.text = self.orders._shopName;
    cell._sale.text = [NSString stringWithFormat:@"%.2f", [self.orders._thePrice floatValue]];
    cell._smallSale.text = [NSString stringWithFormat:@"%.2f", [self.orders._totalPrice floatValue]];
    cell._count.text = self.orders._count;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.orders = [self.saleArray objectAtIndex:indexPath.row];
    ASIFormDataRequest * theRequest = [InterfaceClass orderVouchersDetail:self.orders._orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGroupPurDetailResult:) Delegate:self needUserType:Default];
    
    
    
//    if ([self.orders._state isEqualToString:@"0"]) {
////        ASIFormDataRequest * theRequest = [InterfaceClass groupPurDetail:self.orders._groupPurId];
////        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGroupPurDetailResult:) Delegate:self needUserType:Default];
//        
//        //假流程
//            ShopTuanDetailsViewController *orderVC = [[ShopTuanDetailsViewController alloc] init];
//            orderVC.groupdata = [GroupPurDetailData groupPurDetailDataInfo:nil];
//            orderVC.groupPurId = self.orders._orderId;
//            [self.navigationController pushViewController:orderVC animated:YES];
//            [orderVC release];
//
//    }
//    else
//    {
//        [self loadOrderInfoSource];
//    }
	
}

- (void)onGroupPurDetailResult:(NSDictionary *)dic
{
    if ([self.orders._state intValue] == 1) {
        
//        VoucherSaleViewController *orderVC = [[VoucherSaleViewController alloc] init];
//        orderVC.title = self.orders._shopName;
//        orderVC._groupdata = [GroupPurDetailData groupPurDetailDataInfo:dic];
//        orderVC._groupdata._id = self.orders._vouchersid;
//        orderVC._groupdata._price = [NSString stringWithFormat:@"%d", [orderVC._groupdata._totalPrice intValue]/[orderVC._groupdata._count intValue]];
//        orderVC._shopAddress = orderVC._groupdata._shopAddress;
//        [self.navigationController pushViewController:orderVC animated:YES];
//        [orderVC release];
        
        VoucherTakeOrderViewController *orderVC = [[VoucherTakeOrderViewController alloc] init];
        orderVC.title = self.orders._shopName;
        orderVC._orderData = [GroupPurDetailData groupPurDetailDataInfo:dic];
        orderVC._orderData._price = [NSString stringWithFormat:@"%d", [orderVC._orderData._totalPrice intValue]/[orderVC._orderData._count intValue]];
        orderVC._tuanId = orderVC._orderData._vouchersId;
        [self.navigationController pushViewController:orderVC animated:YES];
        [orderVC release];
        
//        VoucherObligationOrderDetailViewController * orderDetailVC = [[VoucherObligationOrderDetailViewController alloc]init];
//        orderDetailVC._dataInfo = [GroupPurDetailData groupPurDetailDataInfo:dic];
//        [self.navigationController pushViewController:orderDetailVC animated:YES];
//        [orderDetailVC release];
    }
    else {
        
        VoucherUnusedOrderDetailViewController *orderDetailVC = [[VoucherUnusedOrderDetailViewController alloc]init];
        orderDetailVC._dataInfo = [GroupPurDetailData groupPurDetailDataInfo:dic];
        if ([self.orders._state intValue] == 3) {
            orderDetailVC._isUse = YES;
        }
        [self.navigationController pushViewController:orderDetailVC animated:YES];
        [orderDetailVC release];
    }
    
    
//    UIViewController * orderDetailVC = nil;
//    switch ([self.orders._status intValue]) {
//        case 0:
//        {
//            VoucherObligationOrderDetailViewController * orderDetailVC = [[VoucherObligationOrderDetailViewController alloc]init];
//            orderDetailVC._dataInfo = [GroupPurDetailData groupPurDetailDataInfo:dic];
//            [self.navigationController pushViewController:orderDetailVC animated:YES];
//            [orderDetailVC release];
//        }
//            break;
//        case 1:
//        {
//            VoucherUnusedOrderDetailViewController *orderDetailVC = [[VoucherUnusedOrderDetailViewController alloc]init];
//            orderDetailVC._dataInfo = [GroupPurDetailData groupPurDetailDataInfo:dic];
//            [self.navigationController pushViewController:orderDetailVC animated:YES];
//            [orderDetailVC release];
//        }
//            break;
//        case 2:
//        {
//            VoucherUsedOrderDetailViewController *orderDetailVC = [[VoucherUsedOrderDetailViewController alloc]init];
//            orderDetailVC._dataInfo = [GroupPurDetailData groupPurDetailDataInfo:dic];
//            [self.navigationController pushViewController:orderDetailVC animated:YES];
//            [orderDetailVC release];
//        }
//            break;
//        case 3:
//        {
//            VoucherRefundedOrderDetailViewController *orderDetailVC = [[VoucherRefundedOrderDetailViewController alloc]init];
//            orderDetailVC._dataInfo = [GroupPurDetailData groupPurDetailDataInfo:dic];
//            [self.navigationController pushViewController:orderDetailVC animated:YES];
//            [orderDetailVC release];
//
//        }
//            break;
//            
//        default:
//            break;
//    }
    

    
//    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
//    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
//    if (![statusCode isEqualToString:@"0"]) {
//        [UIAlertView alertViewWithMessage:message];
//        return;
//    }
//    ShopForOrderViewController * submitOrderVC = [[ShopForOrderViewController alloc] init];
//    submitOrderVC._orderData =[GroupPurDetailData groupPurDetailDataInfo:dic];
//    submitOrderVC._orderData._didSellCount = self.orders._count;
//    submitOrderVC._orderData._orderId = self.orders._orderId;
//    submitOrderVC._orderData._telephone = self.orders._telePhone;
//    submitOrderVC._tuanId = self.orders._groupPurId;
//    submitOrderVC._cancelOrder = YES;
//    [self.navigationController pushViewController:submitOrderVC animated:YES];
//    [submitOrderVC release];
   
}
-(void)cancelOrder
{
    [self.saleArray removeObject:self.orders];
    [myTableView reloadData];
}

//加载成功
- (void)onPaseredOrderDetailResult:(NSDictionary *)dic
{
//	if ([OrderDetailsData getOrderDetailsData:dic]) {
//		
//		MyOrderDetailViewController *orderDetailVC = [[MyOrderDetailViewController alloc]init];
//		orderDetailVC.name = self.orders._groupPurName;
//		orderDetailVC.orderDetailsData = [OrderDetailsData getOrderDetailsData:dic];
//		[self.navigationController pushViewController:orderDetailVC animated:YES];
//		[orderDetailVC release];
//	}
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
	
	if(pageIndex == self.totalPage)
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

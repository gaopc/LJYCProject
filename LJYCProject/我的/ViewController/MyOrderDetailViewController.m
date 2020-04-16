//
//  MyOrderDetailViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "ShopTuanDetailsViewController.h"
#import "OrderDetailsData.h"
@interface OrderInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_countLab;
@property (nonatomic, retain) UISubLabel *_totalPriceLab;
@property (nonatomic, retain) UISubLabel *_tuanDetailLab;
@property (nonatomic, retain) UIButton *_phoneBut;

@end

@interface OrderOtherInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_orderID;
@property (nonatomic, retain) UISubLabel *_orderTime;
@property (nonatomic, retain) UISubLabel *_orderState;

@end

@implementation OrderInfoCell
@synthesize _countLab, _totalPriceLab,_tuanDetailLab;
@synthesize _phoneBut;
- (void)dealloc
{
    self._totalPriceLab = nil;
    self._countLab = nil;
    self._phoneBut = nil;
    self._tuanDetailLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 45, 320, 170-45) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];

        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"订单信息" frame:CGRectMake(20, 5, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._phoneBut = [UIButton buttonWithTag:0 frame:CGRectMake(0, 40, 320, 50) target:nil action:nil];
        UIImageView *pointView = [UIImageView ImageViewWithFrame:CGRectMake(300, 61, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]];
        UISubLabel * xiangmuLab = [UISubLabel labelWithTitle:@"团购项目" frame:CGRectMake(20, 40, 100, 50) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._tuanDetailLab= [UISubLabel labelWithTitle:@"辣尚瘾：代金券1张（价值100元）" frame:CGRectMake(100, 40, 195, 50) font:FontSize30 color:[UIColor grayColor] alignment:NSTextAlignmentLeft];
        self._tuanDetailLab.numberOfLines = 1;


        UISubLabel * countLab = [UISubLabel labelWithTitle:@"购买数量" frame:CGRectMake(20, 90, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._countLab= [UISubLabel labelWithTitle:@"1" frame:CGRectMake(20, 90, 280, 40) font:FontSize30 color:[UIColor grayColor] alignment:NSTextAlignmentRight];
        UISubLabel * totalPriceLab = [UISubLabel labelWithTitle:@"总价" frame:CGRectMake(20, 130, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._totalPriceLab= [UISubLabel labelWithTitle:@"¥ 88.00" frame:CGRectMake(20, 130, 280, 40) font:FontSize30 color:[UIColor grayColor] alignment:NSTextAlignmentRight];

        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._phoneBut];
        [self addSubview:xiangmuLab];
        [self addSubview:_tuanDetailLab];
        [self addSubview:pointView];
        [self addSubview:totalPriceLab];
        [self addSubview:self._totalPriceLab];
        [self addSubview:countLab];
        [self addSubview:self._countLab];
       
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 90, 300, 1) backgroundColor:FontColorDADADA]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 130, 300, 1) backgroundColor:FontColorDADADA]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(0, 169, 320, 1) backgroundColor:FontColorDADADA]];

    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end

@implementation OrderOtherInfoCell
@synthesize _orderID, _orderState, _orderTime;

- (void)dealloc
{
    self._orderID = nil;
    self._orderState = nil;
    self._orderTime = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 25, 320, 145-25) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20, 5, 280, 20) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft];
        
        
        UISubLabel * orderid = [UISubLabel labelWithTitle:@"订单编号" frame:CGRectMake(20, 25, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._orderID= [UISubLabel labelWithTitle:@"147559935" frame:CGRectMake(20, 25, 280, 40) font:FontSize30 color:[UIColor grayColor] alignment:NSTextAlignmentRight];
        
        UISubLabel * time = [UISubLabel labelWithTitle:@"下单时间" frame:CGRectMake(20, 65, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._orderTime= [UISubLabel labelWithTitle:@"2013-08-26 19:33" frame:CGRectMake(20, 65, 280, 40) font:FontSize30 color:[UIColor grayColor] alignment:NSTextAlignmentRight];
        
        UISubLabel * state = [UISubLabel labelWithTitle:@"订单状态" frame:CGRectMake(20, 105, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._orderState= [UISubLabel labelWithTitle:@"交易成功" frame:CGRectMake(20, 105, 280, 40) font:FontSize30 color:[UIColor grayColor] alignment:NSTextAlignmentRight];
        
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:orderid];
        [self addSubview:_orderID];
        [self addSubview:time];
        [self addSubview:_orderTime];
        [self addSubview:state];
        [self addSubview:_orderState];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 65, 300, 1) backgroundColor:FontColorDADADA]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 105, 300, 1) backgroundColor:FontColorDADADA]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(0, 144, 320, 1) backgroundColor:FontColorDADADA]];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@interface CouponCell : UITableViewCell
@property (nonatomic,retain) UISubLabel * _codeLab;
@property (nonatomic,retain) UISubLabel * _timeLab;
@property (nonatomic, retain) UIImageView *_orderStateImageV;

@end

@implementation CouponCell
@synthesize _codeLab,_timeLab,_orderStateImageV;
- (void)dealloc
{
    self._timeLab = nil;
    self._codeLab = nil;
    self._orderStateImageV = nil;

    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, 90) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
        //UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 4, 320, 86) image:[[UIImage imageNamed:@"couponBackImage.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        //[self addSubview:backView];
        
        self._codeLab = [UISubLabel labelWithTitle:@"2469 0403 50" frame:CGRectMake(20, 4, 280, 86) font:FontSize60 color:[UIColor grayColor] alignment:NSTextAlignmentLeft];
        self._timeLab = [UISubLabel labelWithTitle:@"2013年8月26日已使用" frame:CGRectMake(20, 90-30, 280, 30) font:FontSize26 color:[UIColor grayColor] alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithTitle:@"序列号" frame:CGRectMake(20, 4, 280, 30) font:FontSize26 color:[UIColor grayColor] alignment:NSTextAlignmentLeft]];
        [self addSubview:_codeLab];
        [self addSubview:_timeLab];
        self._orderStateImageV = [UIImageView ImageViewWithFrame:CGRectMake(320-80, (90-74)/2, 59, 74)];
        [self addSubview:self._orderStateImageV];

        [self addSubview:[UISubLabel labelWithframe:CGRectMake(0, 89, 320, 1) backgroundColor:FontColorDADADA]];

    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end


@interface MyOrderDetailViewController ()

@end

@implementation MyOrderDetailViewController
@synthesize name,orderDetailsData;
- (void)dealloc
{
    self.name = nil;
    self.orderDetailsData = nil;
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
    self.title = @"订单详情";
	// Do any additional setup after loading the view.
    self.orderDetailsData =[OrderDetailsData getOrderDetailsData:nil];
    
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 3, 320, ViewHeight-44-5) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view_IOS7 addSubview:myTable];
    [myTable release];

}
#pragma mark - Table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+1+[self.orderDetailsData._groupPursArry count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 170;
    }
    else if (indexPath.row == 1) {
        return 145;
    }
    else if (indexPath.row == 2) {
        return 30;
    }
    else {
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        static NSString * identifier0 = @"identifier0";

        OrderInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil)
        {
            cell = [[[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0] autorelease];
            [cell._phoneBut addTarget:self action:@selector(shopForTuanDetail) forControlEvents:UIControlEventTouchUpInside];
        }
        cell._tuanDetailLab.text = self.name;
        cell._countLab.text = orderDetailsData._count;
        cell._totalPriceLab.text = orderDetailsData._totalPrice;
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString * identifier1 = @"identifier1";

        OrderOtherInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil)
        {
            cell = [[[OrderOtherInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1] autorelease];
        }
        cell._orderID.text = orderDetailsData._orderCode;
        cell._orderTime.text = orderDetailsData._time;
	    if ([orderDetailsData._state isEqualToString:@"0"]) {
		    cell._orderState.text = @"待支付";
	    }else{
		     cell._orderState.text = @"已支付";
	    }
	    //cell._orderState.text = orderDetailsData._state;
        return cell;
    }
    else if (indexPath.row == 2) {
        static NSString * identifier2 = @"identifier2";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell =[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:[UISubLabel labelWithTitle:@"团购券信息" frame:CGRectMake(20, 0, 280, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        }
        return cell;
    }
    else
    {
        static NSString * identifier3 = @"identifier3";
        
        CouponCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
        if (cell == nil)
        {
            cell = [[[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3] autorelease];
        }
        GroupPurs *groupPurs = [orderDetailsData._groupPursArry objectAtIndex:indexPath.row -3];
        cell._codeLab.text = groupPurs._code;
     
        switch ([groupPurs._state intValue]) {
            case 0:
                cell._timeLab.text = [NSString stringWithFormat:@"%@购买",groupPurs._time];
                
                cell._orderStateImageV.image = nil;
//                //模拟效果
//                if (arc4random()%3==2) {
//                    cell._orderStateImageV.image = [UIImage imageNamed:@"common_detail_indicator_used.png"];
//                }
//                else if (arc4random()%3==1)
//                {
//                    cell._orderStateImageV.image = [UIImage imageNamed:@"common_detail_indicator_expired.png"];
//                }
//                else
//                {
//                    cell._orderStateImageV.image = nil;
//                }

                break;
            case 1:
                cell._timeLab.text = [NSString stringWithFormat:@"%@已使用",groupPurs._time];
                cell._orderStateImageV.image = [UIImage imageNamed:@"common_detail_indicator_used.png"];
                break;
            case 2:
                cell._timeLab.text = [NSString stringWithFormat:@"%@已过期",groupPurs._time];
                cell._orderStateImageV.image = [UIImage imageNamed:@"common_detail_indicator_expired.png"];
                break;
            default:
                break;
        }
        return cell;
    }
    
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)shopForTuanDetail
{
	ASIFormDataRequest * theRequest = [InterfaceClass groupPurDetail:orderDetailsData._groupPurId];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGroupPurDetailResult:) Delegate:self needUserType:Default];
	
	
//    ShopTuanDetailsViewController * shopTuanVC = [[ShopTuanDetailsViewController alloc] init];
//    [self.navigationController pushViewController:shopTuanVC animated:YES];
//    [shopTuanVC release];
}
- (void)onGroupPurDetailResult:(NSDictionary *)dic
{
	NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
	NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
	if (![statusCode isEqualToString:@"0"]) {
		[UIAlertView alertViewWithMessage:message];
		return;
	}
	
	ShopTuanDetailsViewController *orderVC = [[ShopTuanDetailsViewController alloc] init];
	orderVC.groupdata = [GroupPurDetailData groupPurDetailDataInfo:dic];
	orderVC.groupPurId = orderDetailsData._groupPurId;
	[self.navigationController pushViewController:orderVC animated:YES];
	[orderVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

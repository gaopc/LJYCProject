//
//  ShopForOrderViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "ShopForOrderViewController.h"
#import "ShopForOrderCell.h"
#import "ShopOrderBoundPhoneViewController.h"
#import "ShopForPayViewController.h"
#import "ShopForDataInfo.h"
#import "BoundPhoneViewController.h"
#import "MyOrderListViewController.h"

@interface ShopForOrderViewController ()

@end

@implementation ShopForOrderViewController
@synthesize _shopCount;
@synthesize _orderData, _tuanId;
@synthesize _phoneNum;
@synthesize _cancelOrder;

- (void)dealloc
{
    self._shopCount = nil;
    self._orderData = nil;
    self._tuanId = nil;
    self._phoneNum = nil;
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
	
    self.title = @"提交订单";
    self._phoneNum = self._orderData._telephone;
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 3, 320, ViewHeight-44-5) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view_IOS7 addSubview:myTable];
    [myTable release];
    
    if (self._cancelOrder) {
        
        UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(cancelOrder) title:@"取消"];
        UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
        self.navigationItem.rightBarButtonItem = rightBar;
        [rightBar release];
    }
}

#pragma mark - Table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 222;
    }
    else if (indexPath.row == 1) {
        return 180;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier11%d%d", indexPath.row, indexPath.section];
   
    if (indexPath.row == 0) {
        
        ShopForOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[ShopForOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell._delegate = self;
            cell._orderCount = [self._orderData._didSellCount intValue];
            [cell setMaxCount:[self._orderData._maxCount intValue] withNewTag:[self._orderData._didSellCount intValue]];
            [cell set_noticeView:[self._orderData._isAnyTimeRefund boolValue] with:[self._orderData._isExpiryRefund boolValue]];
        }
        
        float price = [self._orderData._price floatValue];
        self._shopCount = [NSString stringWithFormat:@"%d", cell._orderCount];
        
        cell._contentLab.text = self._orderData._name;
        cell._priceLab.text = [NSString stringWithFormat:@"¥ %.2f", price];
        cell._countLab.text = [NSString stringWithFormat:@"%d", cell._orderCount];
        cell._totalPriceLab.text = [NSString stringWithFormat:@"¥ %.2f", cell._orderCount*price];
        
        return cell;
    }
    else if (indexPath.row == 1) {
        
        ShopForPhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[ShopForPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            [cell._phoneBut addTarget:self action:@selector(boundPhone) forControlEvents:UIControlEventTouchUpInside];
            [cell._submitBut addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        }

        if (self._phoneNum.length != 11) {
            cell._noticeLab.text = @"绑定手机号";
        }
        else {
            cell._noticeLab.text = @"修改手机号";
        }
        cell._phoneLab.text = self._phoneNum;
        return cell;
    }
    
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        ASIFormDataRequest * theRequest = [InterfaceClass cancelOrder:self._orderData._orderId];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCancelResult:) Delegate:self needUserType:Default];
    }
}

- (void)reloadCell
{
    [myTable reloadData];
}

- (void)boundPhone
{
    NSLog(@"绑定手机号");
    if (self._phoneNum.length != 11) {
        
        BoundPhoneViewController * shopC = [[BoundPhoneViewController alloc] init];
        shopC.shopForOrderVC = self;
        [self.navigationController pushViewController:shopC animated:YES];
        [shopC release];
    }
    else {
        ShopOrderBoundPhoneViewController *boundPhoneVC = [[ShopOrderBoundPhoneViewController alloc] init];
        boundPhoneVC.shopForOrderVC = self;
        [self.navigationController pushViewController:boundPhoneVC animated:YES];
        [boundPhoneVC release];
    }
}

- (void)changePhoneNum:(NSString *)telephone
{
    self._phoneNum = telephone;
    [myTable reloadData];
}

- (void)submit
{
    NSLog(@"提交");
    
    if (self._phoneNum.length != 11) {
        [UIAlertView alertViewWithMessage:@"请绑定您的手机号码！"];
        return;
    }
    
    //假流程
    float price = [self._orderData._price floatValue];
    ShopForReturn *returnData = [ShopForReturn set_returnData:nil];
    returnData._orderTitle = self._orderData._name;
    returnData._totalPrice = [NSString stringWithFormat:@"%.2f", [self._shopCount intValue]*price];
    returnData._payPrice = returnData._totalPrice;
    ShopForPayViewController * payOrderVC = [[ShopForPayViewController alloc] init];
    payOrderVC._orderData = returnData;
    [self.navigationController pushViewController:payOrderVC animated:YES];
    [payOrderVC release];

//    ASIFormDataRequest * theRequest = [InterfaceClass submitOrder:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withId:self._tuanId withCount:self._shopCount withPhone:self._phoneNum];
//    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSubmitResult:) Delegate:self needUserType:Default];
}

- (void)onSubmitResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:message];
        return;
    }
    
    float price = [self._orderData._price floatValue];
    
    ShopForReturn *returnData = [ShopForReturn set_returnData:dic];
    returnData._orderTitle = self._orderData._name;
    returnData._totalPrice = [NSString stringWithFormat:@"%.2f", [self._shopCount intValue]*price];
    returnData._payPrice = returnData._totalPrice;
    
    ShopForPayViewController * payOrderVC = [[ShopForPayViewController alloc] init];
    payOrderVC._orderData = returnData;
    [self.navigationController pushViewController:payOrderVC animated:YES];
    [payOrderVC release];
}

- (void)cancelOrder
{
    NSLog(@"订单取消");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"是否取消该订单？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alertView.tag = 0;
    [alertView show];
    [alertView release];
}

- (void)onCancelResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:message];
        return;
    }
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        
        if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MyOrderListViewController class]])
        {
            MyOrderListViewController *orderVC = [self.navigationController.viewControllers objectAtIndex:i];
            [orderVC cancelOrder];
            
            [self.navigationController popToViewController:orderVC animated:YES];
            break;
        }
    }
}
@end

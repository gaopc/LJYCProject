//
//  VoucherTakeOrderViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-4.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "VoucherTakeOrderViewController.h"
#import "ShopForOrderCell.h"
#import "ShopOrderBoundPhoneViewController.h"
#import "ShopForPayViewController.h"
#import "ShopForDataInfo.h"
#import "BoundPhoneViewController.h"
#import "MyOrderListViewController.h"
#import "AppDelegate.h"

@interface VoucherTakeOrderViewController ()<ShopForSubmitCellDelegate>
{
    NSInteger payMode;  //0支付宝，1微信
}
@end

@implementation VoucherTakeOrderViewController
@synthesize _shopCount;
@synthesize _orderData, _tuanId;
@synthesize _phoneNum;
@synthesize _cancelOrder;


@synthesize  myDelegate, myMode;
@synthesize requestApplication, requestURL, requestTimes;

- (void)dealloc
{
    self._shopCount = nil;
    self._orderData = nil;
    self._tuanId = nil;
    self._phoneNum = nil;
    
    self.myDelegate = nil;
    self.requestURL = nil;
    self.requestApplication = nil;
    self.myDelegate.alixPayResultDelegate = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myMode = Alix;
    payMode = 0;
    
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.myDelegate.alixPayResultDelegate = self;

    
    self._phoneNum = [UserLogin sharedUserInfo]._telephone;
    
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 190;
    }
    else if (indexPath.row == 1) {
        return 110;
    }
    else if (indexPath.row == 2) {
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
            cell._orderCount = 1;
            [cell setMaxCount:10 withNewTag:0];
            
            if ([self._orderData._count intValue] > 0) {
                int orderCount = [self._orderData._count intValue];
                cell._orderCount = orderCount;
                [cell setMaxCount:orderCount withNewTag:-1];
            }
            else {
                cell._orderCount = 1;
                [cell setMaxCount:10 withNewTag:0];
            }
        }
        
        float price = [self._orderData._price floatValue];
        self._shopCount = [NSString stringWithFormat:@"%d", cell._orderCount];
        
        cell._contentLab.text = self._orderData._note;
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
        }
        
        if (self._phoneNum.length != 11) {
            cell._noticeLab.text = @"绑定手机号";
        }
        cell._phoneLab.text = self._phoneNum;
        return cell;
    }
    else if (indexPath.row == 2) {
        
        ShopForSubmitCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[ShopForSubmitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            [cell._submitBut addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
            
            cell.delegate = self;
        }

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
-(void)aliPay
{
    self.myMode = Alix;
    payMode = 0;
}
-(void)wxPay
{
    self.myMode = Wx;
    payMode = 1;
}

- (void)submit
{
    NSLog(@"提交");
    
    if (self._phoneNum.length != 11) {
        [UIAlertView alertViewWithMessage:@"请绑定您的手机号码！"];
        return;
    }
    else
    {
        ASIFormDataRequest * theRequest = [InterfaceClass submitOrder:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderCode withId:self._tuanId withshopId:self._orderData._shopId withCount:self._shopCount withToutalPrice:self._orderData._totalPrice withPhone:self._phoneNum withPayType:@"1"];
         [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSubmitResult:) Delegate:self needUserType:Default];
    }
}

- (void)onSubmitResult:(NSDictionary *)dic//提交订单
{
    self._orderData._orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderId"]];
    ASIFormDataRequest * theRequest = [InterfaceClass getPackets:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withPayType:@"1"];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetPacketsResult:) Delegate:self needUserType:Default];
    
    
}
- (void)onGetPacketsResult:(NSDictionary *)resultDic//获取支付报文
{
//    [self paySuccessFul:resultDic];
//    return;
    
    self._orderData._packets = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"packets"]];
    if (self.myMode == Alix) {
        if (self._orderData._packets) {
            NSString *appScheme = @"LJYCProject";
            [[AlipaySDK defaultService] payOrder:self._orderData._packets fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                self.myMode = AlixPayEnd;
                self.requestURL =  resultDic;
                NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",[resultDic objectForKey:@"resultStatus"],[resultDic objectForKey:@"memo"],[resultDic objectForKey:@"result"]];
                NSLog(@"%@",resultData);
                
                ASIFormDataRequest * theRequest = [InterfaceClass submitResult:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withPayType:@"1" withpackets:resultData];
                if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
                    self.myMode = Alix;
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
                }
                else {
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getSubmitResultResult:) Delegate:self needUserType:Default];
                }
                
            }];
        }
        return;
    }
}
- (void)parseURL:(NSDictionary *)resultDic application:(UIApplication *)application
{
    self.myMode = AlixPayEnd;
    self.requestURL =  resultDic;
    self.requestApplication = application;
    
    NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",[resultDic objectForKey:@"resultStatus"],[resultDic objectForKey:@"memo"],[resultDic objectForKey:@"result"]];
    NSLog(@"%@",resultData);
    
    ASIFormDataRequest * theRequest = [InterfaceClass submitResult:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withPayType:@"1" withpackets:resultData];
    
    if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getSubmitResultResult:) Delegate:self needUserType:Default];
    }
}
- (void)getSubmitResultResult:(NSDictionary *)resultDic //通知支付结果
{
    if (self.myMode == AlixPayEnd) {
        
        GetPaymentInfoResphonse * paymentInfo = [GetPaymentInfoResphonse GetPaymentInfoResphonse:resultDic];
        
        if([paymentInfo.result isEqualToString:@"1"]){
            if (requestTimes == 1) {
                sleep(5);
            }
            else if (requestTimes == 2) {
                sleep(3);
            }
            else if (requestTimes < 11)  {
                sleep(2);
            }
            else {
                [self paySuccessFul:resultDic];
                return;
            }
            if (self.myMode == AlixPayEnd) {
                [self parseURL:requestURL application:requestApplication];
            }
            return;
        }
        else {
            if ([paymentInfo.result isEqualToString:@"0"] || [paymentInfo.result isEqualToString:@"3"]) {
                [self paySuccessFul:resultDic];
            }
            else {
                [UIAlertView alertViewWithMessage:paymentInfo.message tag:0 delegate:nil];
            }
        }
        return;
    }

}
-(void) paySuccessFul:(NSDictionary *)resultDic
{
    self.myDelegate.alixPayResultDelegate = nil;
    NSLog(@"支付成功");
    VoucherPaySuccessfulViewController * successfulVC = [[VoucherPaySuccessfulViewController alloc] init];
    [self.navigationController pushViewController:successfulVC animated:YES];
    [successfulVC release];
}

//- (void)submit
//{
//    NSLog(@"提交");
//    
//    if (self._phoneNum.length != 11) {
//        [UIAlertView alertViewWithMessage:@"请绑定您的手机号码！"];
//        return;
//    }
//    
//    //假流程
//    float price = [self._orderData._price floatValue];
//    ShopForReturn *returnData = [ShopForReturn set_returnData:nil];
//    returnData._orderTitle = self._orderData._name;
//    returnData._totalPrice = [NSString stringWithFormat:@"%.2f", [self._shopCount intValue]*price];
//    returnData._payPrice = returnData._totalPrice;
//    ShopForPayViewController * payOrderVC = [[ShopForPayViewController alloc] init];
//    payOrderVC._orderData = returnData;
//    [self.navigationController pushViewController:payOrderVC animated:YES];
//    [payOrderVC release];
//    
//    //    ASIFormDataRequest * theRequest = [InterfaceClass submitOrder:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withId:self._tuanId withCount:self._shopCount withPhone:self._phoneNum];
//    //    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSubmitResult:) Delegate:self needUserType:Default];
//}
//
//- (void)onSubmitResult:(NSDictionary *)dic
//{
//    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
//    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
//    if (![statusCode isEqualToString:@"0"]) {
//        [UIAlertView alertViewWithMessage:message];
//        return;
//    }
//    
//    float price = [self._orderData._price floatValue];
//    
//    ShopForReturn *returnData = [ShopForReturn set_returnData:dic];
//    returnData._orderTitle = self._orderData._name;
//    returnData._totalPrice = [NSString stringWithFormat:@"%.2f", [self._shopCount intValue]*price];
//    returnData._payPrice = returnData._totalPrice;
//    
//    ShopForPayViewController * payOrderVC = [[ShopForPayViewController alloc] init];
//    payOrderVC._orderData = returnData;
//    [self.navigationController pushViewController:payOrderVC animated:YES];
//    [payOrderVC release];
//}
//


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

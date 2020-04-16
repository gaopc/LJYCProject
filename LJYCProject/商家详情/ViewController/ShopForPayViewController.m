//
//  ShopForPayViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 14-3-12.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "ShopForPayViewController.h"
#import "AppDelegate.h"
#import "MyOrderListViewController.h"


@interface PayInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_nameLab;
@property (nonatomic, retain) UISubLabel *_totalPriceLab;
@property (nonatomic, retain) UISubLabel *_balanceLab;
@property (nonatomic, retain) UISubLabel *_payPriceLab;
@property (nonatomic, retain) UIButton *_selectedBut;
@property (nonatomic, assign) BOOL _isSelected;
@property (nonatomic, assign) id _delegate;

@end

@interface PayModeInfoCell : UITableViewCell
@property (nonatomic,retain) UIButton * _payBtn;
@end

@implementation PayInfoCell
@synthesize _nameLab, _totalPriceLab,_balanceLab,_payPriceLab,_isSelected;
@synthesize _selectedBut,_delegate;
- (void)dealloc
{
    self._nameLab = nil;
    self._totalPriceLab = nil;
    self._balanceLab = nil;
    self._payPriceLab = nil;
    self._selectedBut = nil;
    _isSelected=NO;
    self._delegate = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isSelected = NO;
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, 170) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        self._nameLab = [UISubLabel labelWithTitle:@"辣尚瘾：代金券1张（价值100元）" frame:CGRectMake(20, 0, 280, 50) font:FontSize30 color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        UISubLabel * totalPriceLab = [UISubLabel labelWithTitle:@"总价：¥" frame:CGRectMake(20, 50, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._totalPriceLab= [UISubLabel labelWithTitle:@"88.00" frame:CGRectMake(75, 50, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        UISubLabel * balanceLab = [UISubLabel labelWithTitle:@"我的余额：¥" frame:CGRectMake(20, 90, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._balanceLab= [UISubLabel labelWithTitle:@"0.00" frame:CGRectMake(105, 90, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(275, 50+40+7, 25, 25)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor grayColor].CGColor;
        
        self._selectedBut = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:nil frame:CGRectMake(260, 50+40, 60, 40) font:nil color:nil target:self action:@selector(selectBalance:)];
        view.center = self._selectedBut.center;

        UISubLabel * payPriceLab = [UISubLabel labelWithTitle:@"还需支付：¥" frame:CGRectMake(20, 130, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._payPriceLab= [UISubLabel labelWithTitle:@"88.00" frame:CGRectMake(105, 130, 280, 40) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        
        [self addSubview:backView];
        [self addSubview:_nameLab];
        [self addSubview:_totalPriceLab];
        [self addSubview:balanceLab];
        [self addSubview:_balanceLab];
        [self addSubview:view];
        [view release];
        [self addSubview:_selectedBut];
        [self addSubview:payPriceLab];
        [self addSubview:totalPriceLab];
        [self addSubview:self._payPriceLab];
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 90, 300, 1) backgroundColor:FontColorDADADA]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 130, 300, 1) backgroundColor:FontColorDADADA]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(0, 170, 320, 2) backgroundColor:FontColorDADADA]];
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)selectBalance:(UIButton *)sender
{
    self._isSelected = !self._isSelected;
    if (self._isSelected) {
        [sender setImage:[UIImage imageNamed:@"已阅读.png"] forState:UIControlStateNormal];
        float _fl =[self._totalPriceLab.text floatValue]-[self._balanceLab.text floatValue];
        self._payPriceLab.text = [NSString stringWithFormat:@"%.2f",_fl];
    }
    else
    {
        [sender setImage:nil forState:UIControlStateNormal];
        self._payPriceLab.text = self._totalPriceLab.text;
    }
    if (self._delegate && [self._delegate respondsToSelector:@selector(balance:)]) {
        [self._delegate performSelector:@selector(balance:) withObject:self._payPriceLab.text];
    }
}
@end

@implementation PayModeInfoCell
@synthesize _payBtn;
- (void)dealloc
{
    self._payBtn = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 30, 320, 170-30) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"选择支付方式" frame:CGRectMake(20, 0, 280, 30) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft];
        
        
        UISubLabel * paymode = [UISubLabel labelWithTitle:@"支付宝客户端支付" frame:CGRectMake(20, 35, 280, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UISubLabel * paymodeDes = [UISubLabel labelWithTitle:@"推荐已安装支付宝客户端的用户使用" frame:CGRectMake(20, 65, 280, 20) font:FontSize26 color: [UIColor grayColor] alignment:NSTextAlignmentLeft];

        UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:nil frame:CGRectMake(275, 30+12, 25, 25) font:nil color:nil target:nil action:nil];
        [selectBtn setImage:[UIImage imageNamed:@"已阅读.png"] forState:UIControlStateNormal];

        self._payBtn = [CoustomButton buttonWithOrangeColor:CGRectMake(20, 110, 280, 40) target:nil action:nil title:@"确认支付"];

        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:paymode];
        [self addSubview:paymodeDes];
        [self addSubview:selectBtn];
        [self addSubview:_payBtn];
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(0, 90, 320, 1) backgroundColor:FontColorDADADA]];

    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end
@interface ShopForPayViewController ()

@end

@implementation ShopForPayViewController
@synthesize _orderData, myDelegate, myMode;
@synthesize requestApplication, requestURL, requestTimes;

- (void)dealloc
{
    self._orderData = nil;
    self.myDelegate = nil;
    self.requestURL = nil;
    self.requestApplication = nil;
    self.myDelegate.alixPayResultDelegate = nil;
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
	self.title = @"确认订单";
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view.
    
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 170;
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
    
    if (indexPath.row == 0) {
        static NSString * identifier0 = @"identifier0";
        
        PayInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil)
        {
            cell = [[[PayInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0] autorelease];
            cell._delegate = self;
        }
        cell._nameLab.text = self._orderData._orderTitle;
        cell._totalPriceLab.text = self._orderData._totalPrice;
        cell._payPriceLab.text = self._orderData._payPrice;
        cell._balanceLab.text = self._orderData._balanceMoney;
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString * identifier1 = @"identifier1";
        
        PayModeInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil)
        {
            cell = [[[PayModeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1] autorelease];
            [cell._payBtn addTarget:self action:@selector(payBtn) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)balance:(NSString *)text
{
    NSLog(@"余额：%@",text);
    self._orderData._payPrice = text;
}
- (void)payBtn
{
    NSLog(@"支付");
    
    self.myMode = Alix;
    self.myDelegate.alixPayResultDelegate = self;
    [self orderPay:@"0"];
}

- (void)orderPay:(NSString *)payType
{
    ASIFormDataRequest * theRequest = [InterfaceClass getMessageState:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withPayType:payType];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getMessageStateResult:) Delegate:self needUserType:Member];
}

- (void)getMessageStateResult:(NSDictionary *)dic
{
    NSString * orderInfo  = nil;
    if ([[dic objectForKey:@"statusCode"] intValue] == 0) {
        orderInfo  = [dic objectForKey:@"packets"];
//        if ([orderInfo length] <10) {
//            orderInfo = nil;
//        }
    }
    
    if (self.myMode == Alix) {
        if (orderInfo) {
            NSString *appScheme = @"FlightProject";
            [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                self.myMode = AlixPayEnd;
                self.requestURL =  resultDic;
                
                //                self.requestURL =  url;
                //                self.requestApplication = application;
                
                NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",[resultDic objectForKey:@"resultStatus"],[resultDic objectForKey:@"memo"],[resultDic objectForKey:@"result"]];
                NSLog(@"%@",resultData);
                
                ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withPayType:@"0" withPackets:resultData];
                
                if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
                }
                else {
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
                }
                
            }];
        }

//        if (orderInfo) {
//            NSString *appScheme = @"LJYCProject";
//            AlixPay * alixpay = [AlixPay shared];
//            int ret = [alixpay pay:orderInfo applicationScheme:appScheme];
//            if (ret == kSPErrorAlipayClientNotInstalled) {
//                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                     message:@"您还没有安装支付宝客户端，请安装后进行支付。\n点击确定，立即安装。"
//                                                                    delegate:self
//                                                           cancelButtonTitle:@"取消"
//                                                           otherButtonTitles:@"确定",nil];
//                [alertView setTag:123];
//                [alertView show];
//                [alertView release];
//            }
//            else if (ret == kSPErrorSignError) {
//                NSLog(@"签名错误！");
//            }
//        }
        
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
    
    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withPayType:@"0" withPackets:resultData];
    
    if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
    }
}

//- (void)parseURL:(NSURL *)url application:(UIApplication *)application
//{
//    self.myMode = AlixPayEnd;
//    self.requestURL =  url;
//    self.requestApplication = application;
//    NSString * urlStr = [[NSString stringWithFormat:@"%@",url] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlStr);
//    NSRange range = [urlStr rangeOfString:@"?"];
//    NSString * query = [urlStr substringFromIndex:range.location+1];
//    NSLog(@"%@",query);
//    NSDictionary * alixDic = [query JSONValue];
//    NSDictionary * data = [alixDic objectForKey:@"memo"];
//    NSString * resultStatus = [data objectForKey:@"ResultStatus"];
//    NSString * memo = [data objectForKey:@"memo"];
//    NSString * result = [data objectForKey:@"result"];
//    //    result = [result stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
//    //    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
//    NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",resultStatus,memo,result];
//    NSLog(@"%@",resultData);
//    
//    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserLogin sharedUserInfo].userID withOrderId:self._orderData._orderId withPayType:@"0" withPackets:resultData];
//    
//    if ([resultStatus intValue] != 9000) {
//        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
//    }
//    else {
//        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
//    }
//}

- (void)getOrdersStateResult:(NSDictionary *)dic
{
    if (self.myMode == AlixPayEnd) {
        
        GetPaymentInfoResphonse * paymentInfo = [GetPaymentInfoResphonse GetPaymentInfoResphonse:dic];
        
        if([paymentInfo.result isEqualToString:@"1"]){
//            if (requestTimes == 1) {
//                sleep(5);
//            }
//            else if (requestTimes == 2) {
//                sleep(3);
//            }
//            else if (requestTimes < 11)  {
//                sleep(2);
//            }
//            else {
//                [self paySuccessFul:dic];
//                return;
//            }
//            if (self.myMode == AlixPayEnd) {
//                [self parseURL:requestURL application:requestApplication];
//            }
            [self paySuccessFul:dic];
            return;
        }
        else {
            if ([paymentInfo.result isEqualToString:@"0"] || [paymentInfo.result isEqualToString:@"3"]) {
                [self paySuccessFul:dic];
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
    [UIAlertView alertViewWithMessage:@"支付成功" tag:0 delegate:self];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
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

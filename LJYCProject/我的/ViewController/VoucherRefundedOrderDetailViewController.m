//
//  VoucherRefundedOrderDetailViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-6.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "VoucherRefundedOrderDetailViewController.h"
#import "MyOrderListViewController.h"

@interface VoucherRefundedOrderDetailViewController ()
{
    UILabel *shopNameLab;
    UILabel *priceLab;
    UILabel *thePriceLab;
    UILabel *refundPriceLab;
    UILabel *countLab;
    UILabel *changeLab;
    
    UIButton *reduceBut;
    UIButton *addBut;
    
    NSInteger orderCount;
    NSInteger maxCount;
}
@end

@implementation VoucherRefundedOrderDetailViewController
@synthesize _orderDataInfo;


- (void)dealloc
{
    self._orderDataInfo = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退款申请";
    self.view_IOS7.backgroundColor = [UIColor whiteColor];
    
    CGFloat offy = 0;
    
    shopNameLab = [UISubLabel labelWithTitle:@"暴风一号" frame:CGRectMake(20, 0, ViewWidth - 40, 75) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
    [self.view addSubview:shopNameLab];
    
    offy += 75;
    [self.view addSubview:[UILabel labelWithframe:CGRectMake(20, offy, ViewWidth - 40, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    thePriceLab = [UISubLabel labelWithTitle:@"20元代金券" frame:CGRectMake(20, offy, ViewWidth - 40, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
    [self.view addSubview:thePriceLab];
    
    countLab = [UISubLabel labelWithTitle:@"x 2" frame:CGRectMake(20, offy, ViewWidth - 40 - 5, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentRight];
    [self.view addSubview:countLab];
    
    offy += 40;
    [self.view addSubview:[UILabel labelWithframe:CGRectMake(20, offy, ViewWidth - 40, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    [self.view addSubview:[UISubLabel labelWithTitle:@"退回数量" frame:CGRectMake(20, offy + 5, ViewWidth - 40, 30) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft]];
    
    changeLab = [UILabel labelWithTitle:@"1" frame:CGRectMake(195, offy + 5, 55, 30) font:FontSize30 color:FontColor959595 alignment:NSTextAlignmentCenter];
    changeLab.backgroundColor = FontColorDADADA;
    changeLab.layer.borderColor = FontColorC3C3C3.CGColor;
    changeLab.layer.borderWidth = 1;
    changeLab.layer.cornerRadius = 3;
    
    reduceBut = [CoustomButton buttonWithOrangeColor:CGRectMake(140, offy + 5, 50, 30) target:self action:@selector(reduceCount:) title:@"—"];
    addBut = [CoustomButton buttonWithOrangeColor:CGRectMake(255, offy + 5, 50, 30) target:self action:@selector(addCount:) title:@"+"];
    addBut.enabled = NO;
    addBut.backgroundColor = FontColor959595;
    [self.view addSubview:reduceBut];
    [self.view addSubview:addBut];
    [self.view addSubview:changeLab];
    
    offy += 40;
    [self.view addSubview:[UILabel labelWithframe:CGRectMake(20, offy, ViewWidth - 40, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    [self.view addSubview:[UISubLabel labelWithTitle:@"退回金额" frame:CGRectMake(20, offy, ViewWidth - 40, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft]];
    
    refundPriceLab = [UISubLabel labelWithTitle:@"100.00" frame:CGRectMake(20, offy, ViewWidth - 40 - 5, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentRight];
    [self.view addSubview:refundPriceLab];
    
    offy += 40;
    [self.view addSubview:[UILabel labelWithframe:CGRectMake(20, offy, ViewWidth - 40, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    
    UIButton *submitBtn = [CoustomButton buttonWithOrangeColor:CGRectMake(45, offy + 40, ViewWidth - 90, 40) target:self action:@selector(submitBtn:) title:@"申请退款"];
    [self.view addSubview:submitBtn];
    
    
    [self getMaxCount:self._orderDataInfo._groupVouchers];
    shopNameLab.text = self._orderDataInfo._shopName;
    thePriceLab.text = [NSString stringWithFormat:@"%@元代金券", self._orderDataInfo._thePice];
    countLab.text = [NSString stringWithFormat:@"x %@", self._orderDataInfo._count];
    refundPriceLab.text = [NSString stringWithFormat:@"%.2f", maxCount * [self._orderDataInfo._totalPrice floatValue] / [self._orderDataInfo._count intValue]];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
        if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MyOrderListViewController class]]) {
            MyOrderListViewController *listVC = [self.navigationController.viewControllers objectAtIndex:i];
            [self.navigationController popToViewController:listVC animated:YES];
        }
    }
}

- (void)getMaxCount:(NSArray *)array
{
    maxCount = 0;
    for (int i = 0; i < array.count; i++) {
        VoucherInfo * info = [array objectAtIndex:i];
        if ([info._state intValue] == 2) {
            maxCount ++;
        }
    }
    
    if (maxCount <= 1) {
        reduceBut.enabled = NO;
        reduceBut.backgroundColor = FontColor959595;
    }

    orderCount = maxCount;
    changeLab.text = [NSString stringWithFormat:@"%d", maxCount];
}

- (void)reduceCount:(UIButton *)sender
{
    orderCount = orderCount -- < 1 ? 1 : orderCount --;
    if (orderCount == 1) {
        sender.enabled = NO;
        sender.backgroundColor = FontColor959595;
    }
    
    if (orderCount < maxCount) {
        addBut.enabled = YES;
        addBut.backgroundColor = [UIColor orangeColor];
    }
    
    [self reloadMyView];
}

- (void)addCount:(UIButton *)sender
{
    orderCount = orderCount ++ >= maxCount ? maxCount : orderCount ++;
    if (orderCount == maxCount) {
        sender.enabled = NO;
        sender.backgroundColor = FontColor959595;
    }
    
    if (orderCount > 1) {
        reduceBut.enabled = YES;
        reduceBut.backgroundColor = [UIColor orangeColor];
    }
    
    [self reloadMyView];
}

- (void)submitBtn:(id)sender
{
    ASIFormDataRequest * theRequest = [InterfaceClass submitVouchersRefund:self._orderDataInfo._orderCode withCount:[NSString stringWithFormat:@"%d", orderCount] withPhone:[UserLogin sharedUserInfo]._telephone];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredRefundResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredRefundResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if ([statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:message tag:0 delegate:self];
    }
    else {
        [UIAlertView alertViewWithMessage:message];
    }
}

- (void)reloadMyView
{
    changeLab.text = [NSString stringWithFormat:@"%d", orderCount];
    refundPriceLab.text = [NSString stringWithFormat:@"%.2f", orderCount * [self._orderDataInfo._totalPrice floatValue] / [self._orderDataInfo._count intValue]];
}
@end

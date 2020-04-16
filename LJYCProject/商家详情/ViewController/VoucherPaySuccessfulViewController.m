//
//  VoucherPaySuccessfulViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-4.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "VoucherPaySuccessfulViewController.h"
#import "AsyncImageView.h"
#import "MyOrderListViewController.h"
#import "ShopFindViewController.h"
#import "ShopForDetailsViewController.h"

@interface VoucherPaySuccessfulViewController ()
{
    UISubLabel * nameLab;
    UISubLabel * vouchersLab;
    
    UIScrollView * scrollV ;
}
@end

@implementation VoucherPaySuccessfulViewController

-(void)loadView
{
    [super loadView];
    scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    [self.view addSubview:scrollV];
    [scrollV release];
    
    CGFloat startY = 0;
    nameLab = [UISubLabel labelWithTitle:@"李金喜采摘园20元代金券  购买成功" frame:CGRectMake(10,startY,ViewWidth-20,60) font:[UIFont systemFontOfSize:18] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:nameLab];
    startY += 70;
    vouchersLab = [UISubLabel labelWithTitle:@"代金券：000 3456 56788 90923098\n代金券：000 3456 56788 90923098" frame:CGRectMake(10,startY,ViewWidth-20,80) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:YES];
    [scrollV addSubview:vouchersLab];
    startY += (vouchersLab.frame.size.height+30);
    
    UIButton * voucherListBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"查看代金券" frame:CGRectMake(15, startY, (ViewWidth-45)/2, 45) font:[UIFont systemFontOfSize:16] color:[UIColor redColor] target:self action:@selector(showVoucherList:)];
    UIButton * voucherAddBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"继续购买" frame:CGRectMake(15+(ViewWidth-45)/2+15, startY, (ViewWidth-45)/2, 45) font:[UIFont systemFontOfSize:16] color:[UIColor greenColor] target:self action:@selector(addVouche:)];
    voucherListBtn.layer.borderColor = [UIColor redColor].CGColor;
    voucherAddBtn.layer.borderColor = [UIColor greenColor].CGColor;
    voucherListBtn.layer.borderWidth = 1;
    voucherAddBtn.layer.borderWidth = 1;
    [scrollV addSubview:voucherListBtn];
    [scrollV addSubview:voucherAddBtn];

    startY += 80;
    
    [scrollV addSubview:[UISubLabel labelWithTitle:@"看了本代金券的用户还看了" frame:CGRectMake(10,startY,ViewWidth-20,30) font:[UIFont systemFontOfSize:15] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO]];
    startY += 30;
    
    ShopFindCell * cell = [[ShopFindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.delegate = self;
    cell.frame = CGRectMake(0, startY, ViewWidth, 96);
    [cell drawStarCodeView:5.0];
    [scrollV addSubview:cell];
    [cell release];
    
    startY += 96;
    
    cell = [[ShopFindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.delegate = self;
    cell.frame = CGRectMake(0, startY, ViewWidth, 96);
    [cell drawStarCodeView:5.0];
    [scrollV addSubview:cell];
    [cell release];
    
    startY += 150;
    
    scrollV.contentSize = CGSizeMake(ViewWidth, startY);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"购买成功";
    
}

- (void)backHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)bgClick:(UIButton *)sender
{
    ASIFormDataRequest * theRequest = [InterfaceClass getShopDetail:[UserLogin sharedUserInfo].userID withShopId:@"dd43627e92f44ddbbd284a1cbfdb7b58" withLongitude:[UserLogin sharedUserInfo]._longitude withLatitude:[UserLogin sharedUserInfo]._latitude];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopDetailResult:) Delegate:self needUserType:Default];
    
}
////加载成功
- (void)onPaseredShopDetailResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMessage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    
    if([statusCode isEqualToString:@"0"])
    {
        ShopForDetailsViewController *shopForDetailsVC = [[ShopForDetailsViewController alloc]init];
        shopForDetailsVC._detailData = [ShopForDataInfo setShopForDataInfo:dic];
        shopForDetailsVC._isSign = YES;
        [self.navigationController pushViewController:shopForDetailsVC animated:YES];
        [shopForDetailsVC release];
    }
    else {
        [UIAlertView alertViewWithMessage:statusMessage];
    }
}

- (void)showVoucherList:(UIButton *)sender  //查看代金券
{
    MyOrderListViewController * orderlistVC = [[MyOrderListViewController alloc] init];
    [self.navigationController pushViewController:orderlistVC animated:YES];
    [orderlistVC release];
}

- (void)addVouche:(UIButton *)sender  //继续购买
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

//
//  VoucherObligationOrderDetailViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-6.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "VoucherObligationOrderDetailViewController.h"
#import "AsyncImageView.h"
#import "VoucherPaySuccessfulViewController.h"

@interface VoucherObligationOrderDetailViewController ()
{
    AsyncImageView * imageV;
    UISubLabel * nameLab;
    UISubLabel * subNameLab;
    UISubLabel * saleCountLab;
    UISubLabel * addressLab;
    UISubLabel * orderDetailLab;
    UISubLabel * desLab;
    
    
    UIImageView * payModleImageV;
    UIButton * alipayBtn;
    UIButton * wxpayBtn;
    NSInteger payMode;  //0支付宝，1微信
    
    UIScrollView * scrollV;
    
}

@end

@implementation VoucherObligationOrderDetailViewController
@synthesize _dataInfo;
- (void)dealloc
{
    self._dataInfo = nil;
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    
    scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    [self.view addSubview:scrollV];
    [scrollV release];
    
    
    CGFloat startY = 0;
    imageV = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, startY, ViewWidth, 120)];
    imageV.urlString = @"http://image.lajiaou.com:8100/image/dc3bd14e6fbd0ac29ffc517a0d798749.jpg";
    [scrollV addSubview:imageV];
    [imageV release];
    
    startY += 140;
    
    nameLab = [UISubLabel labelWithTitle:@"20元代金券" frame:CGRectMake(10,startY,ViewWidth-20,30) font:[UIFont systemFontOfSize:20] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:nameLab];
    
    startY += 30;
    
    subNameLab = [UISubLabel labelWithTitle:@"满100元可用一张" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:subNameLab];
    
    startY += 40;
    
    
    [scrollV addSubview:[UISubLabel labelWithTitle:@"过期退      随时退" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:15] color:[UIColor greenColor] alignment:NSTextAlignmentLeft autoSize:NO]];
    
    saleCountLab = [UISubLabel labelWithTitle:@"已售：100920000" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentRight autoSize:NO];
    [scrollV addSubview:saleCountLab];
    
    startY += 40;
    
    addressLab = [UISubLabel labelWithTitle:@"北京市延庆县景东路北要乡村东3公里" frame:CGRectMake(10,startY,ViewWidth-20,30) font:[UIFont systemFontOfSize:15] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:addressLab];
    
    startY += 50;
    
    orderDetailLab = [UISubLabel labelWithTitle:@"订单详情\n订单号：2134564121321\n下单时间：2015.01.02 10:10:10\n数量：2\n总价2元" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:YES];
    [scrollV addSubview:orderDetailLab];
    
    startY += orderDetailLab.frame.size.height+30;
    
    desLab = [UISubLabel labelWithTitle:@"有效期：2013-04-27 至 2014-03-31\n右安门店有效期从2014年2月15日开始\n仅限北京：交大东路店、惠新店、通州店、新源里店、方庄店；廊坊：燕郊店使用\n可使用大厅及包间，包间必须提前1天预约\n3桌及3桌以上包桌和宴会不可使用此券，不可分桌结账\n方庄店早餐10：00之前不可使用\n到店仅限堂食，不提供餐前打包；餐后未吃完，可打包（打包费以店内实际为准）\n本次团购不提供外送服务\n包间必须提前1天预约\n除外日期：12月24日、2014年1月1日-3日、1月30日-2月6日、2月14日" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:YES];
    [scrollV addSubview:desLab];
    
    startY += (desLab.frame.size.height +30);
    
    alipayBtn = [UIButton buttonWithTag:0 frame:CGRectMake(0, startY, ViewWidth, 45) target:self action:@selector(alipayBtn:)];
    [alipayBtn setBackgroundImage:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [scrollV addSubview:alipayBtn];
    [scrollV addSubview:[UISubLabel labelWithTitle:@"支付宝" frame:CGRectMake(20, startY, 100, 45) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
    
    startY += 45;
    wxpayBtn = [UIButton buttonWithTag:0 frame:CGRectMake(0, startY, ViewWidth, 45) target:self action:@selector(wxpayBtn:)];
    [wxpayBtn setBackgroundImage:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [scrollV addSubview:wxpayBtn];
    [scrollV addSubview:[UISubLabel labelWithTitle:@"微信支付" frame:CGRectMake(20, startY, 100, 45) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
    
    payModleImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-50, alipayBtn.frame.origin.y+12, 20, 20) image:[UIImage imageNamed:@"已阅读.png"]];
    [scrollV addSubview:payModleImageV];

     startY += 65;
    
    [scrollV addSubview:[CoustomButton buttonWithOrangeColor:CGRectMake(20, startY, 280, 45) target:self action:@selector(payBtn:) title:@"确认支付"]];

    startY += 100;
    
    scrollV.contentSize = CGSizeMake(ViewWidth, startY);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self assignment];
}
-(void)assignment
{
//    imageV.urlString = [self._dataInfo._picUrls objectAtIndex:0];
    
    nameLab.text = self._dataInfo._thePice;
    subNameLab.text = self._dataInfo._note;
    saleCountLab.text = self._dataInfo._sellCount;
    addressLab.text = self._dataInfo._shopAddress;
    orderDetailLab.text = [NSString stringWithFormat:@"订单详情\n订单号：%@\n下单时间：%@\n数量：%@\n总价%@元",self._dataInfo._orderCode,self._dataInfo._time,self._dataInfo._count,self._dataInfo._totalPrice];
    CGSize suggestedSize = [orderDetailLab.text sizeWithFont:orderDetailLab.font constrainedToSize:CGSizeMake(orderDetailLab.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//NSLineBreakByWordWrapping
    CGRect rect = orderDetailLab.frame;
    rect.size.height = suggestedSize.height;
    orderDetailLab.frame = rect;
    
    desLab.frame = CGRectMake(desLab.frame.origin.x, orderDetailLab.frame.origin.y + orderDetailLab.frame.size.height +30, desLab.frame.size.width, desLab.frame.size.height);
    
    desLab.text = self._dataInfo._introduce;
    suggestedSize = [desLab.text sizeWithFont:desLab.font constrainedToSize:CGSizeMake(desLab.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//NSLineBreakByWordWrapping
    rect = desLab.frame;
    rect.size.height = suggestedSize.height;
    desLab.frame = rect;
    scrollV.contentSize = CGSizeMake(ViewWidth, desLab.frame.origin.y + desLab.frame.size.height +80);
}

-(void)alipayBtn:(UIButton *)sender
{
    payMode = 0;
    payModleImageV.frame = CGRectMake(ViewWidth-50, sender.frame.origin.y+10, 20, 20) ;
}
-(void)wxpayBtn:(UIButton *)sender
{
    payMode = 1;
    payModleImageV.frame = CGRectMake(ViewWidth-50, sender.frame.origin.y+10, 20, 20) ;
}

- (void)payBtn:(UIButton *)sender
{
    NSLog(@"支付");
    
    [self onSubmitResult:nil];

}

- (void)onSubmitResult:(NSDictionary *)dic
{
    VoucherPaySuccessfulViewController * successfulVC = [[VoucherPaySuccessfulViewController alloc] init];
    [self.navigationController pushViewController:successfulVC animated:YES];
    [successfulVC release];
}

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

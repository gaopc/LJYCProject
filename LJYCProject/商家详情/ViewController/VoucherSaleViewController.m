//
//  VoucherSaleViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-4-22.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "VoucherSaleViewController.h"
#import "AsyncImageView.h"
#import "VoucherTakeOrderViewController.h"
#import "MemberLoginViewController.h"

@interface VoucherSaleViewController ()
{
    AsyncImageView * imageV;
    UISubLabel * nameLab;
    UISubLabel * subNameLab;
    UISubLabel * moneyLab;
    UISubLabel * saleCountLab;
    UISubLabel * addressLab;
    UISubLabel * desLab;
    
    UIScrollView * scrollV;
}
@end

@implementation VoucherSaleViewController
@synthesize _groupdata, _shopAddress;
- (void)dealloc
{
    self._groupdata = nil;
    self._shopAddress = nil;
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
    [scrollV addSubview:imageV];
    [imageV release];
    
    startY += 140;
    
    nameLab = [UISubLabel labelWithTitle:@"20元代金券" frame:CGRectMake(10,startY,ViewWidth-20,50) font:[UIFont systemFontOfSize:20] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:nameLab];
    [scrollV addSubview:[UISubLabel labelWithTitle:@"¥" frame:CGRectMake(ViewWidth/2,startY+7,20,40) font:[UIFont systemFontOfSize:17] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:NO]];
    moneyLab = [UISubLabel labelWithTitle:@"0.1" frame:CGRectMake(ViewWidth/2+15,startY,100,50) font:[UIFont systemFontOfSize:25] color:[UIColor redColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:moneyLab];
    UIButton * saleBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"购买" frame:CGRectMake(ViewWidth-10-80, startY+12, 70, 25) font:[UIFont systemFontOfSize:14] color:[UIColor orangeColor] target:self action:@selector(saleBtn:)];
    saleBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    saleBtn.layer.borderWidth = 1;
    saleBtn.layer.cornerRadius = 3;
    [scrollV addSubview:saleBtn];
    
    
    startY += 60;
    
    [scrollV addSubview:[UILabel labelWithframe:CGRectMake(10, startY - 12, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    [scrollV addSubview:[UISubLabel labelWithTitle:@"过期退      随时退" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:15] color:[UIColor brownColor] alignment:NSTextAlignmentLeft autoSize:NO]];
    
    saleCountLab = [UISubLabel labelWithTitle:@"已售：100920000" frame:CGRectMake(10,startY,ViewWidth-30,20) font:[UIFont systemFontOfSize:15] color:FontColor454545 alignment:NSTextAlignmentRight autoSize:NO];
    [scrollV addSubview:saleCountLab];
    
    startY += 40;
    
    [scrollV addSubview:[UILabel labelWithframe:CGRectMake(10, startY - 12, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    addressLab = [UISubLabel labelWithTitle:@"北京市延庆县景东路北要乡村东3公里" frame:CGRectMake(10,startY,ViewWidth-20,30) font:[UIFont systemFontOfSize:15] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:addressLab];
    
    startY += 50;
    
    [scrollV addSubview:[UILabel labelWithframe:CGRectMake(10, startY - 15, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    desLab = [UISubLabel labelWithTitle:@"有效期：。。。。。。。。描述" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:YES];
    [scrollV addSubview:desLab];
    
    startY += 100;
    
    scrollV.contentSize = CGSizeMake(ViewWidth, startY);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view_IOS7.backgroundColor = FontColorFFFFFF;
    [self assignment];
}
-(void)assignment
{
//    imageV.urlString = self._detailData._picUrl;
    imageV.image = [UIImage imageNamed:@"首页_广告.png"];
    nameLab.text = [NSString stringWithFormat:@"%@元代金券", self._groupdata._thePice];
    subNameLab.text = self._groupdata._note;
    moneyLab.text = self._groupdata._price;
    saleCountLab.text = [NSString stringWithFormat:@"已售：%@", self._groupdata._sellCount];
    addressLab.text = self._shopAddress;
    
    if (self._groupdata._noTime.length == 0) {
        desLab.text = [NSString stringWithFormat:@"有效期：\n%@ ------ %@\n\n使用规则：\n%@\n\n使用代金券不再同时享受商家其他优惠！", [self getDateFromLong:self._groupdata._startDate], [self getDateFromLong:self._groupdata._endDate], self._groupdata._note];;
    }
    else {
        desLab.text = [NSString stringWithFormat:@"有效期：\n%@ ------ %@\n\n不可使用时间：\n%@\n\n使用规则：\n%@\n\n使用代金券不再同时享受商家其他优惠！", [self getDateFromLong:self._groupdata._startDate], [self getDateFromLong:self._groupdata._endDate], self._groupdata._noTime, self._groupdata._note];
    }
    CGSize suggestedSize = [desLab.text sizeWithFont:desLab.font constrainedToSize:CGSizeMake(desLab.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//NSLineBreakByWordWrapping
    CGRect rect = desLab.frame;
    rect.size.height = suggestedSize.height;
    desLab.frame = rect;
    scrollV.contentSize = CGSizeMake(ViewWidth, desLab.frame.origin.y + desLab.frame.size.height +80);
}
-(void)saleBtn:(UIButton *)sender
{
    if ([self setUserLogin:ShopForTuan] == YES) {
        VoucherTakeOrderViewController *orderVC = [[VoucherTakeOrderViewController alloc] init];
        orderVC.title = self.title;
        orderVC._orderData = self._groupdata;
        orderVC._tuanId = self._groupdata._id;
        [self.navigationController pushViewController:orderVC animated:YES];
        [orderVC release];
    }
}

- (NSString *)getDateFromLong:(NSString *)longDate
{
    long long dataLong = [longDate longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
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

#pragma mark - LoginDelegate
-(void) loginSuccessFul:(ShopClickType)type
{
    if (type == ShopForTuan) {
        [self saleBtn:nil];
    }
}
@end

//
//  VoucherUnusedOrderDetailViewController.m
//  LJYCProject
//
//  Created by 张晓婷 on 15-5-6.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "VoucherUnusedOrderDetailViewController.h"
#import "AsyncImageView.h"
#import "ZBarSDK.h"
#import "QREncoder.h"
#import "VoucherRefundedOrderDetailViewController.h"

@interface VouchersView : UIView // height 135 45 45 45
{
    UIView * qrCodeV;
    UIImageView *pointView;
    UILabel *lineLab;
}
@property (nonatomic,retain)UISubLabel * _nameLab;
@property (nonatomic,retain)UISubLabel * _numLab;
@property (nonatomic,retain)UISubLabel * _stateLab;
@property (nonatomic,retain)UIImageView * _imageV;

@property (nonatomic,assign)id _delegate;

@end

@implementation VouchersView
@synthesize _nameLab,_numLab,_stateLab,_imageV;
@synthesize _delegate;

- (void)dealloc
{
    self._stateLab = nil;
    self._numLab = nil;
    self._nameLab = nil;
    self._imageV = nil;
    self._delegate = nil;
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self._nameLab = [UISubLabel labelWithTitle:@"20元代金券" frame:CGRectMake(10,0,ViewWidth-20,45) font:[UIFont systemFontOfSize:13] color:FontColor333333 alignment:NSTextAlignmentLeft autoSize:NO];
        self._numLab = [UISubLabel labelWithTitle:@"521 212 213 232" frame:CGRectMake(10,0,ViewWidth-20,45) font:[UIFont systemFontOfSize:13] color:FontColor333333 alignment:NSTextAlignmentCenter autoSize:NO];
        self._stateLab = [UISubLabel labelWithTitle:@"未使用" frame:CGRectMake(10,0,ViewWidth-20-30,45) font:[UIFont systemFontOfSize:13] color:FontColor333333 alignment:NSTextAlignmentRight autoSize:NO];
        pointView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 30, 22, 8, 5) image:[UIImage imageNamed:@"arrowsDown.png"]];
        lineLab = [UILabel labelWithframe:CGRectMake(10, 44, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
        self._imageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth/2+15, 10, 80, 80)];
        
        [self addSubview:self._nameLab];
        [self addSubview:self._numLab];
        [self addSubview:self._stateLab];
        [self addSubview:pointView];
        [self addSubview:lineLab];
        [self addSubview:[UIButton buttonWithTag:0 frame:CGRectMake(0, 0, ViewWidth, 45) target:self action:@selector(stretchBtn:)]];
        
        qrCodeV = [[UIView alloc] initWithFrame:CGRectMake(0, 35, ViewWidth, 100)];
        [self addSubview:qrCodeV];
        [qrCodeV release];
        qrCodeV.hidden = YES;
        
        [qrCodeV addSubview:[UISubLabel labelWithTitle:@"扫描二维码" frame:CGRectMake(0,0,ViewWidth/2,90) font:[UIFont systemFontOfSize:15] color:FontColor636363 alignment:NSTextAlignmentRight autoSize:NO]];
        [qrCodeV addSubview:self._imageV];
        
        [qrCodeV addSubview:[UILabel labelWithframe:CGRectMake(10, 99, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];

    }
    return self;
}

-(void)stretchBtn:(UIButton *)sender
{
    CGFloat  changeHeight = 0;
    if (sender.tag ==0) {
        sender.tag = 1;
        qrCodeV.hidden = NO;
        lineLab.hidden = YES;
        changeHeight = 90;
        pointView.image = [UIImage imageNamed:@"arrowsUp.png"];
    }
    else
    {
        sender.tag = 0;
        qrCodeV.hidden = YES;
        lineLab.hidden = NO;
        changeHeight = -90;
        pointView.image = [UIImage imageNamed:@"arrowsDown.png"];
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + changeHeight);
    
    if (self._delegate && [self._delegate respondsToSelector:@selector(changeHeight::)]) {
        [self._delegate performSelector:@selector(changeHeight::) withObject:NSStringFromCGSize(CGSizeMake(0, changeHeight)) withObject:self];
    }

}
-(void)changeHeight:(NSString *)size :(VouchersView *)sender
{
//    CGSize  size1 = CGSizeFromString(size);
}
@end

@interface VoucherUnusedOrderDetailViewController ()<ZBarReaderDelegate>
{
    AsyncImageView * imageV;
    UISubLabel * nameLab;
    UISubLabel * moneyLab;
    UISubLabel * saleCountLab;
    UISubLabel * addressLab;
    UISubLabel * orderDetailLab;
    UISubLabel * desLab;
    
    
    UIScrollView * scrollV;
    UIButton * submitBtn;
    
    CGFloat  voucherViewStartY;
    
}
@property(nonatomic,assign) CGFloat  _vouchersHeight;
@property(nonatomic,retain) NSArray  * _voucherViewsArr;

@end

@implementation VoucherUnusedOrderDetailViewController
@synthesize _vouchersHeight,_voucherViewsArr;
@synthesize _dataInfo;
- (void)dealloc
{
    self._dataInfo = nil;
    _vouchersHeight = 0;
    self._voucherViewsArr = nil;
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
    
    nameLab = [UISubLabel labelWithTitle:@"20元代金券" frame:CGRectMake(10,startY,ViewWidth-20,50) font:[UIFont systemFontOfSize:20] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:nameLab];

    UIButton * saleBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"电话" frame:CGRectMake(ViewWidth-10-80, startY+12, 70, 25) font:[UIFont systemFontOfSize:14] color:FontColor979797 target:self action:@selector(telephoneBtn:)];
    saleBtn.layer.borderColor = FontColor979797.CGColor;
    saleBtn.layer.borderWidth = 1;
    saleBtn.layer.cornerRadius = 3;
    [scrollV addSubview:saleBtn];
    
    
    startY += 60;
    
    [scrollV addSubview:[UILabel labelWithframe:CGRectMake(10, startY - 12, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    [scrollV addSubview:[UISubLabel labelWithTitle:@"过期退      随时退" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:14] color:[UIColor brownColor] alignment:NSTextAlignmentLeft autoSize:NO]];
    
    saleCountLab = [UISubLabel labelWithTitle:@"已售：100920000" frame:CGRectMake(10,startY,ViewWidth-30,20) font:[UIFont systemFontOfSize:14] color:FontColor454545 alignment:NSTextAlignmentRight autoSize:NO];
    [scrollV addSubview:saleCountLab];
    
    startY += 40;
    
    [scrollV addSubview:[UILabel labelWithframe:CGRectMake(10, startY - 12, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    addressLab = [UISubLabel labelWithTitle:@"北京市延庆县景东路北要乡村东3公里" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:14] color:[UIColor blackColor] alignment:NSTextAlignmentLeft autoSize:NO];
    [scrollV addSubview:addressLab];
    
    startY += 30;
    
    [scrollV addSubview:[UILabel labelWithframe:CGRectMake(10, startY - 2, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    voucherViewStartY = startY;
    
    orderDetailLab = [UISubLabel labelWithTitle:@"订单详情\n订单号：2134564121321\n下单时间：2015.01.02 10:10:10\n数量：2\n总价：2元" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:13] color:FontColor959595 alignment:NSTextAlignmentLeft autoSize:YES];
    [scrollV addSubview:orderDetailLab];
    
    startY += orderDetailLab.frame.size.height;
    
//    [scrollV addSubview:[UILabel labelWithframe:CGRectMake(10, startY, ViewWidth - 20, 1) backgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]]];
    
    desLab = [UISubLabel labelWithTitle:@"有效期：2013-04-27 至 2014-03-31\n右安门店有效期从2014年2月15日开始\n仅限北京：交大东路店、惠新店、通州店、新源里店、方庄店；廊坊：燕郊店使用\n可使用大厅及包间，包间必须提前1天预约\n3桌及3桌以上包桌和宴会不可使用此券，不可分桌结账\n方庄店早餐10：00之前不可使用\n到店仅限堂食，不提供餐前打包；餐后未吃完，可打包（打包费以店内实际为准）\n本次团购不提供外送服务\n包间必须提前1天预约\n除外日期：12月24日、2014年1月1日-3日、1月30日-2月6日、2月14日" frame:CGRectMake(10,startY,ViewWidth-20,20) font:[UIFont systemFontOfSize:13] color:FontColor959595 alignment:NSTextAlignmentLeft autoSize:YES];
    [scrollV addSubview:desLab];
    
    startY += (desLab.frame.size.height +80);
    
    submitBtn = [CoustomButton buttonWithOrangeColor:CGRectMake(45, startY, ViewWidth - 90, 40) target:self action:@selector(submitBtn:) title:@"申请退款"];
    submitBtn.hidden = YES;
    [scrollV addSubview:submitBtn];
    
    startY += 80;
    
    scrollV.contentSize = CGSizeMake(ViewWidth, startY);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view_IOS7.backgroundColor = [UIColor whiteColor];
    self.title = self._dataInfo._shopName;
    
    [self assignment];
    [self addVouchersView];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self callTel:self._dataInfo._telephone];
    }
}

-(void)assignment
{
    //    imageV.urlString = [self._dataInfo._picUrls objectAtIndex:0];
    
    nameLab.text = [NSString stringWithFormat:@"%@元代金券", self._dataInfo._thePice];
    saleCountLab.text = [NSString stringWithFormat:@"已售：%@", self._dataInfo._sellCount];
    addressLab.text = self._dataInfo._shopAddress;
    orderDetailLab.text = [NSString stringWithFormat:@"订单详情\n订单号：%@\n下单时间：%@\n购买数量：%@\n订单总价：%@元",self._dataInfo._orderCode, [self getTimeFormString:self._dataInfo._time], self._dataInfo._count,self._dataInfo._totalPrice];
    CGSize suggestedSize = [orderDetailLab.text sizeWithFont:orderDetailLab.font constrainedToSize:CGSizeMake(orderDetailLab.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//NSLineBreakByWordWrapping
    CGRect rect = orderDetailLab.frame;
    rect.size.height = suggestedSize.height;
    orderDetailLab.frame = rect;
    
    desLab.frame = CGRectMake(desLab.frame.origin.x, orderDetailLab.frame.origin.y + orderDetailLab.frame.size.height +30, desLab.frame.size.width, desLab.frame.size.height);
    
    if (self._dataInfo._noTime.length == 0) {
        desLab.text = [NSString stringWithFormat:@"有效期：\n%@ ------ %@\n使用规则：\n%@\n使用代金券不再同时享受商家其他优惠！", [self getDateFromLong:self._dataInfo._startDate], [self getDateFromLong:self._dataInfo._endDate], self._dataInfo._note];;
    }
    else {
        desLab.text = [NSString stringWithFormat:@"有效期：\n%@ ------ %@\n不可使用时间：\n%@\n使用规则：\n%@\n使用代金券不再同时享受商家其他优惠！", [self getDateFromLong:self._dataInfo._startDate], [self getDateFromLong:self._dataInfo._endDate], self._dataInfo._noTime, self._dataInfo._note];
    }
    suggestedSize = [desLab.text sizeWithFont:desLab.font constrainedToSize:CGSizeMake(desLab.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//NSLineBreakByWordWrapping
    rect = desLab.frame;
    rect.size.height = suggestedSize.height;
    desLab.frame = rect;
    
    CGFloat offY = 0;
    if (self._isUse) {
        offY = 80;
        submitBtn.hidden = NO;
        submitBtn.frame = CGRectMake(submitBtn.frame.origin.x, desLab.frame.origin.y + desLab.frame.size.height + 40, submitBtn.frame.size.width, submitBtn.frame.size.height);
    }
    scrollV.contentSize = CGSizeMake(ViewWidth, desLab.frame.origin.y + desLab.frame.size.height +80 + offY);
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info // 扫描二维码代理方法
{
//    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // EXAMPLE: do something useful with the barcode data
//    resultText.text = symbol.data;
}
-(void)addVouchersView
{
    NSMutableArray * mArr = [NSMutableArray array];
    self._voucherViewsArr = mArr;

    int autoCount = [self._dataInfo._groupVouchers count];  //arc4random()%4+3;
    for (int i=0; i<autoCount; i++) {
        VouchersView * voucherV = [[VouchersView alloc] initWithFrame:CGRectMake(0, voucherViewStartY+i*45, ViewWidth, 45)];
        voucherV.tag = i;
        voucherV._delegate = self;
        [scrollV addSubview:voucherV];
        [voucherV release];
        VoucherInfo * info = [self._dataInfo._groupVouchers objectAtIndex:i];
        NSString * encodeStr = info._code; // 不可直接使用汉字，不可太长（不能超过256），否则无法返回图片
        
//        encodeStr = [encodeStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       
        voucherV._imageV.image =  [QREncoder encode:encodeStr];
        voucherV._nameLab.text = [NSString stringWithFormat:@"%@元代金券", self._dataInfo._thePice];
        voucherV._numLab.text = info._code;
        if ([info._state intValue] == 1) {
            voucherV._stateLab.text = @"已使用";
        }
        else if ([info._state intValue] == 2) {
            voucherV._stateLab.text = @"未使用";
        }
        else if ([info._state intValue] == 3) {
            voucherV._stateLab.text = @"已退款";
        }
        else {
            voucherV._stateLab.text = @"";
        }
        
        [mArr addObject:voucherV];
    }
    self._vouchersHeight = autoCount * 45.0+20;
}
-(void)changeHeight:(NSString *)size :(VouchersView *)sender
{
    self._vouchersHeight = CGSizeFromString(size).height;

    for (int i = sender.tag + 1;i<[self._voucherViewsArr count];i++) {
        VouchersView * voucherV = [self._voucherViewsArr objectAtIndex:i];
        voucherV.frame = CGRectMake(voucherV.frame.origin.x, voucherV.frame.origin.y + self._vouchersHeight, voucherV.frame.size.width, voucherV.frame.size.height);
    }
}

-(void)set_vouchersHeight:(CGFloat  )vouchersHeight
{
    _vouchersHeight = vouchersHeight;
    orderDetailLab.frame = CGRectMake(orderDetailLab.frame.origin.x, orderDetailLab.frame.origin.y + vouchersHeight, orderDetailLab.frame.size.width, orderDetailLab.frame.size.height);
    desLab.frame = CGRectMake(desLab.frame.origin.x, desLab.frame.origin.y + vouchersHeight, desLab.frame.size.width, desLab.frame.size.height);
    submitBtn.frame = CGRectMake(submitBtn.frame.origin.x, submitBtn.frame.origin.y + vouchersHeight, submitBtn.frame.size.width, submitBtn.frame.size.height);
    scrollV.contentSize = CGSizeMake(scrollV.frame.size.width, scrollV.contentSize.height + vouchersHeight);
}

- (void)telephoneBtn:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"拨打电话：%@", self._dataInfo._telephone] delegate:self cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确认", nil];
    
    alert.tag = 0;
    [alert show];
    [alert release];
}

- (void)submitBtn:(id)sender
{
    VoucherRefundedOrderDetailViewController *refundVC = [[VoucherRefundedOrderDetailViewController alloc] init];
    refundVC._orderDataInfo = self._dataInfo;
    [self.navigationController pushViewController:refundVC animated:YES];
    [refundVC release];
}

- (NSString *)getTimeFormString:(NSString*)str
{
    long long dataLong = [str longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}


- (NSString *)getDateFromLong:(NSString *)longDate
{
    long long dataLong = [longDate longLongValue];
    double dateDou = dataLong/1000;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    return [formatter stringFromDate:date];
}
@end

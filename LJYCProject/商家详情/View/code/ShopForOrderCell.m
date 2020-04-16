//
//  ShopForOrderCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "ShopForOrderCell.h"

@implementation ShopForOrderCell
@synthesize _contentLab, _priceLab, _countLab, _totalPriceLab;
@synthesize _addBut, _reduceBut;
@synthesize _maxCount;

- (void)dealloc
{
    self._totalPriceLab = nil;
    self._priceLab = nil;
    self._countLab = nil;
    self._contentLab = nil;
    self._reduceBut = nil;
    self._addBut = nil;
    self._delegate = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._orderCount = 1;
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, 180) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        self._contentLab = [UISubLabel labelWithTitle:@"价值100元代金卷1张" frame:CGRectMake(20, 10, 280, 25) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UISubLabel * priceLab = [UISubLabel labelWithTitle:@"单价" frame:CGRectMake(20, 55, 100, 25) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._priceLab = [UISubLabel labelWithTitle:@"¥ 88.00" frame:CGRectMake(140, 55, 165, 25) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentRight];
        
        UISubLabel * countLab = [UISubLabel labelWithTitle:@"数量" frame:CGRectMake(20, 100, 100, 25) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._countLab = [UISubLabel labelWithTitle:@"1" frame:CGRectMake(195, 98, 55, 30) font:FontSize30 color:FontColor959595 alignment:NSTextAlignmentCenter];
        self._countLab.backgroundColor = FontColorDADADA;
        self._countLab.layer.borderColor = FontColorC3C3C3.CGColor;
        self._countLab.layer.borderWidth = 1;
        self._countLab.layer.cornerRadius = 3;
        
        self._reduceBut = [CoustomButton buttonWithOrangeColor:CGRectMake(140, 98, 50, 30) target:self action:@selector(reduceCount:) title:@"—"];
        self._addBut = [CoustomButton buttonWithOrangeColor:CGRectMake(255, 98, 50, 30) target:self action:@selector(addCount:) title:@"+"];
        
        UISubLabel * totalPriceLab = [UISubLabel labelWithTitle:@"总价" frame:CGRectMake(20, 145, 100, 25) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._totalPriceLab= [UISubLabel labelWithTitle:@"¥ 88.00" frame:CGRectMake(140, 145, 165, 25) font:FontSize30 color:[UIColor orangeColor] alignment:NSTextAlignmentRight];
        
        [self addSubview:backView];
        [self addSubview:self._contentLab];
        [self addSubview:priceLab];
        [self addSubview:self._priceLab];
        [self addSubview:countLab];
        [self addSubview:self._countLab];
        [self addSubview:self._addBut];
        [self addSubview:self._reduceBut];
        [self addSubview:totalPriceLab];
        [self addSubview:self._totalPriceLab];
        
        [self addSubview:[UISubLabel labelWithTitle:@"--------------------------------------------------------------------------------------------------------" frame:CGRectMake(20, 45, 300, 3) font:FontSize14 color:FontColorDADADA alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 90, 300, 1) backgroundColor:FontColorDADADA]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 135, 300, 1) backgroundColor:FontColorDADADA]];
//        [self addSubview:[UISubLabel labelWithframe:CGRectMake(20, 180, 300, 1) backgroundColor:FontColorDADADA]];
    }
    return self;
}

- (void)reduceCount:(UIButton *)sender
{
    self._orderCount = self._orderCount -- < 1 ? 1 : self._orderCount --;
    if (self._orderCount == 1) {
        sender.enabled = NO;
        sender.backgroundColor = FontColor959595;
    }
    
    if (self._orderCount < self._maxCount) {
        self._addBut.enabled = YES;
        self._addBut.backgroundColor = [UIColor orangeColor];
    }
    
    if (self._delegate && [self._delegate respondsToSelector:@selector(reloadCell)]) {
        [self._delegate performSelector:@selector(reloadCell)];
    }
}

- (void)setMaxCount:(int)temp withNewTag:(int)tag
{
    self._maxCount = temp;
    
    if (tag == -1) {                        //锁定
        self._reduceBut.enabled = NO;
        self._reduceBut.backgroundColor = FontColor959595;
        self._addBut.enabled = NO;
        self._addBut.backgroundColor = FontColor959595;
        return;
    }
    
    if (tag <= 1) {
        self._reduceBut.enabled = NO;
        self._reduceBut.backgroundColor = FontColor959595;
    }
    
    if (self._maxCount <= tag) {
        self._addBut.enabled = NO;
        self._addBut.backgroundColor = FontColor959595;
    }
}

- (void)addCount:(UIButton *)sender
{
    self._orderCount = self._orderCount ++ >= self._maxCount ? self._maxCount : self._orderCount ++;
    if (self._orderCount == self._maxCount) {
        sender.enabled = NO;
        sender.backgroundColor = FontColor959595;
    }
    
    if (self._orderCount > 1) {
        self._reduceBut.enabled = YES;
        self._reduceBut.backgroundColor = [UIColor orangeColor];
    }
    
    if (self._delegate && [self._delegate respondsToSelector:@selector(reloadCell)]) {
        [self._delegate performSelector:@selector(reloadCell)];
    }
}

- (void)set_noticeView:(BOOL)firstBool with:(BOOL)secondBool
{
    NSArray *noticeArr = [NSArray arrayWithObjects:@"支持随时退", @"支持过期退", nil];
    UIImage *icoImg = [UIImage imageNamed:@"已阅读.png"];
    NSString *contentStr = @"";
    
    for (int i = 0; i < noticeArr.count; i ++) {
        
        if (i == 0) {
            
            if (!firstBool) {
                icoImg = [UIImage imageNamed:@"不支持.png"];
                contentStr = @"不";
            }
            else {
                icoImg = [UIImage imageNamed:@"已阅读.png"];
                contentStr = @"";
            }
        }
        else if (i == 1) {
            
            if (!secondBool) {
                icoImg = [UIImage imageNamed:@"不支持.png"];
                contentStr = @"不";
            }
            else {
                icoImg = [UIImage imageNamed:@"已阅读.png"];
                contentStr = @"";
            }
        }
        
        UIImageView *iconView = [UIImageView ImageViewWithFrame:CGRectMake(20 + 110*i, 196, 10, 10) image:icoImg];
        UISubLabel *noticeLab = [UISubLabel labelWithTitle:[NSString stringWithFormat:@"%@%@", contentStr, [noticeArr objectAtIndex:i]] frame:CGRectMake(34 + 110*i, 188, 80, 25) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft];
        [self addSubview:iconView];
        [self addSubview:noticeLab];
    }
}

@end

@implementation ShopForPhoneCell
@synthesize _phoneBut, _phoneLab, _submitBut, _noticeLab;

- (void)dealloc
{
    self._noticeLab = nil;
    self._submitBut = nil;
    self._phoneLab = nil;
    self._phoneBut = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, 110) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"您的手机号码" frame:CGRectMake(20, 5, 280, 30) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft];
        
        self._phoneBut = [UIButton buttonWithTag:0 frame:CGRectMake(0, 40, 320, 45) target:nil action:nil];
        [self._phoneBut setBackgroundImage:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        UIImageView *pointView = [UIImageView ImageViewWithFrame:CGRectMake(290, 59, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]];
        self._noticeLab = [UISubLabel labelWithTitle:@"修改手机号" frame:CGRectMake(15, 50, 260, 25) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentRight];
        self._phoneLab = [UISubLabel labelWithTitle:@"15810709603" frame:CGRectMake(20, 50, 320, 25) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._submitBut = [CoustomButton buttonWithOrangeColor:CGRectMake(20, 105, 280, 45) target:nil action:nil title:@"提交订单"];
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._phoneBut];
        [self addSubview:pointView];
        [self addSubview:self._noticeLab];
        [self addSubview:self._phoneLab];
//        [self addSubview:self._submitBut];
    }
    return self;
}
@end

@interface ShopForSubmitCell ()
{
    UIImageView * imageV;
    UIButton * alipayBtn;
    UIButton * wxpayBtn;
}
@end

@implementation ShopForSubmitCell
@synthesize _submitBut;
@synthesize delegate;
- (void)dealloc
{
    self._submitBut = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        alipayBtn = [UIButton buttonWithTag:0 frame:CGRectMake(0, 0, ViewWidth, 45) target:self action:@selector(alipayBtn:)];
        wxpayBtn = [UIButton buttonWithTag:0 frame:CGRectMake(0, 45, ViewWidth, 45) target:self action:@selector(wxpayBtn:)];
        [alipayBtn setBackgroundImage:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [wxpayBtn setBackgroundImage:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];

        [self addSubview:alipayBtn];
        [self addSubview:wxpayBtn];
        
        [self addSubview:[UISubLabel labelWithTitle:@"支付宝" frame:CGRectMake(20, 0, 100, 45) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"微信支付" frame:CGRectMake(20, 45, 100, 45) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        
        imageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-50, 12, 20, 20) image:[UIImage imageNamed:@"已阅读.png"]];
        [self addSubview:imageV];
        
        self._submitBut = [CoustomButton buttonWithOrangeColor:CGRectMake(20, 110, 280, 45) target:nil action:nil title:@"提交订单"];
        [self addSubview:self._submitBut];
    }
    return self;
}

-(void)alipayBtn:(UIButton *)sender
{
    imageV.frame = CGRectMake(ViewWidth-50, 12, 20, 20) ;
    if (self.delegate && [self.delegate respondsToSelector:@selector(aliPay)]) {
        [self.delegate performSelector:@selector(aliPay)];
    }
}
-(void)wxpayBtn:(UIButton *)sender
{
    imageV.frame = CGRectMake(ViewWidth-50, 57, 20, 20) ;
    if (self.delegate && [self.delegate respondsToSelector:@selector(wxPay)]) {
        [self.delegate performSelector:@selector(wxPay)];
    }

}


@end
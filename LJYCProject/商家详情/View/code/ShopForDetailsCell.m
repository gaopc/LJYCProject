//
//  ShopForDetailsCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForDetailsCell.h"
#import "CoustomButton.h"

@implementation ShopForDetailsCell
@synthesize _shopImageBut, _certificationView, _shopStateView, _shopImageView ,_submibBut;
@synthesize _titleLab, _distanceLab;

-(void)dealloc
{
    self._shopImageBut = nil;
    self._titleLab = nil;
    self._distanceLab = nil;
    self._certificationView = nil;
    self._shopStateView = nil;
    self._submibBut = nil;
    self._shopImageView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imgView = [UIImageView ImageViewWithFrame:CGRectMake(10, 5, 163, 122) image:[UIImage imageNamed:@"相册框.png"]];
        
        self._shopImageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(14, 10, 155, 111)];
		self._shopImageView.defaultImage = 1;
        self._shopImageView._cutImage = YES;
        
        self._shopImageBut =  [UIButton buttonWithTag:0 frame:CGRectMake(14, 10, 155, 111) target:nil action:nil];
        
        self._certificationView = [UIImageView ImageViewWithFrame:CGRectMake(185, 10, 51, 15.5) image:[UIImage imageNamed:@"店铺认证.png"]];
        
        UIImageView *locationView = [UIImageView ImageViewWithFrame:CGRectMake(185, 52, 9, 14) image:[UIImage imageNamed:@"定位标.png"]];
        
        self._titleLab = [UISubLabel labelWithTitle:@"北京朝阳区惠新东街" frame:CGRectMake(200, 50, 110, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft autoSize:NO];
        self._distanceLab = [UISubLabel labelWithTitle:@"1000km" frame:CGRectMake(200, 66, 105, 20) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentLeft];
        
        self._submibBut = [UIButton buttonWithTag:0 frame:CGRectMake(185, 87, 120, 35) target:nil action:nil];
        [self._submibBut setBackgroundImage:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        [self._submibBut setImage:[UIImage imageNamed:@"电话-00.png"] forState:UIControlStateNormal];
        [self._submibBut setImage:[UIImage imageNamed:@"电话-01.png"] forState:UIControlStateHighlighted];
        self._submibBut.imageEdgeInsets = UIEdgeInsetsMake(2, 32, 3, 32);
        
        [self setStar:3];
        
        self._shopStateView = [UIImageView ImageViewWithFrame:CGRectMake(240, 5, 70, 58.7)];
        
        [self addSubview:imgView];
        [self addSubview:self._shopImageView];
        [self addSubview:self._shopImageBut];
        [self addSubview:self._certificationView];
        [self addSubview:starImg0];
        [self addSubview:starImg1];
        [self addSubview:starImg2];
        [self addSubview:starImg3];
        [self addSubview:starImg4];
        [self addSubview:locationView];
        [self addSubview:self._titleLab];
        [self addSubview:self._distanceLab];
        [self addSubview:self._submibBut];
        [self addSubview:self._shopStateView];
    }
    return self;
}
@end


@implementation ShopForButtonsCell
@synthesize _collectionBut, _signInBut, _telphoneBut;
@synthesize _collectNumLab, _signNumLab;

- (void)dealloc
{
    self._signNumLab = nil;
    self._collectNumLab = nil;
    self._collectionBut = nil;
    self._signInBut = nil;
    self._telphoneBut = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 50) image:[[UIImage imageNamed:@"背景-上.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *lineView1 = [UIImageView ImageViewWithFrame:CGRectMake(160, 8, 1, 34) image:[UIImage imageNamed:@"分割线.png"]];
//        UIImageView *lineView2 = [UIImageView ImageViewWithFrame:CGRectMake(209, 8, 1, 34) image:[UIImage imageNamed:@"分割线.png"]];
        
        self._signNumLab = [UISubLabel labelWithTitle:@"139" frame:CGRectMake(15, 4, 140, 25) font:FontSize28 color:[UIColor greenColor] alignment:NSTextAlignmentCenter];
        self._collectNumLab = [UISubLabel labelWithTitle:@"50" frame:CGRectMake(163, 4, 140, 25) font:FontSize28 color:[UIColor orangeColor] alignment:NSTextAlignmentCenter];
        
        self._signInBut = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"签到" frame:CGRectMake(17, 0, 140, 50) font:FontSize24 color:FontColor454545 colorWithWhite:0.5 target:nil action:nil];
        self._collectionBut = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"收藏" frame:CGRectMake(163, 0, 140, 50) font:FontSize24 color:FontColor454545 colorWithWhite:0.5 target:nil action:nil];
        self._telphoneBut = [UIButton buttonWithTag:0 frame:CGRectMake(212, 0, 90, 50) target:nil action:nil];
        [self._telphoneBut setImage:[UIImage imageNamed:@"电话-00.png"] forState:UIControlStateNormal];
        [self._telphoneBut setImage:[UIImage imageNamed:@"电话-01.png"] forState:UIControlStateHighlighted];

        self._signInBut.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
        self._collectionBut.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
//        self._telphoneBut.imageEdgeInsets = UIEdgeInsetsMake(10, 17, 10, 17);
        
        [self addSubview:backView];
        [self addSubview:lineView1];
//        [self addSubview:lineView2];
        [self addSubview:self._signNumLab];
        [self addSubview:self._collectNumLab];
        [self addSubview:self._signInBut];
        [self addSubview:self._collectionBut];
//        [self addSubview:self._telphoneBut];
    }
    return self;
}

@end


@implementation ShopForAddressCell
@synthesize _addressLab;

- (void)dealloc
{
    self._addressLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *pointView = [UIImageView ImageViewWithFrame:CGRectMake(280, 11, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]];
    
        self._addressLab = [UISubLabel labelWithTitle:@"北京市朝阳区紫光发展大厦B座7层" frame:CGRectMake(25, 0, 250, 30) font:FontSize24 color:FontColor454545  alignment:NSTextAlignmentLeft];
        
        [self addSubview:backView];
        [self addSubview:pointView];
        [self addSubview:self._addressLab];
    }
    return self;
}

@end

@implementation ShopForTypeCell
@synthesize _shopTypeLab;

- (void)dealloc
{
    self._shopTypeLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"店铺类型：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._shopTypeLab = [UISubLabel labelWithTitle:@"农家乐" frame:CGRectMake(85, 0, 220, 30) font:FontSize24 color:FontColor454545  alignment:NSTextAlignmentLeft];
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._shopTypeLab];
    }
    return self;
}
@end


@implementation ShopForServiceCell
@synthesize _serviceLab, _backView;

- (void)dealloc
{
    self._serviceLab = nil;
    self._backView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"特色服务：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._serviceLab = [UISubLabel labelWithTitle:@"垂钓、餐饮、骑马、帐篷、烧烤" frame:CGRectMake(85, 8, 220, 30) font:FontSize24 color:FontColor565656  alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._backView];
        [self addSubview:titleLab];
        [self addSubview:self._serviceLab];
    }
    return self;
}

@end

@implementation ShopForScaleCell
@synthesize _scaleLab;

- (void)dealloc
{
    self._scaleLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"接待规模：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._scaleLab = [UISubLabel labelWithTitle:@"50-100 人" frame:CGRectMake(85, 0, 220, 30) font:FontSize24 color:FontColor565656  alignment:NSTextAlignmentLeft];
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._scaleLab];
    }
    return self;
}

@end

@implementation ShopForDateCell
@synthesize _dateLab;

- (void)dealloc
{
    self._dateLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"营业时间：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._dateLab = [UISubLabel labelWithTitle:@"1-12 月" frame:CGRectMake(85, 0, 220, 30) font:FontSize24 color:FontColor565656  alignment:NSTextAlignmentLeft];
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._dateLab];
    }
    return self;
}

@end

@implementation ShopForIntroduceCell
@synthesize _introduceLab, _backView;

- (void)dealloc
{
    self._introduceLab = nil;
    self._backView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 45) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"商家介绍：" frame:CGRectMake(26, 0, 60, 29) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._introduceLab = [UISubLabel labelWithTitle:@"本店主营虹鳟鱼、烤羊腿、可提供帐篷露营场所，另有骑马、垂钓等娱乐项目。" frame:CGRectMake(85, 8, 220, 43) font:FontSize24 color:FontColor565656  alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._backView];
        [self addSubview:titleLab];
        [self addSubview:self._introduceLab];
    }
    return self;
}

@end


@implementation ShopForNoticeCell
@synthesize _noticeLab;

- (void)dealloc
{
    self._noticeLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"商家公告：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._noticeLab = [UISubLabel labelWithTitle:@"6月垂钓特惠，5元/条，并有更多礼品赠送" frame:CGRectMake(85, 5, 220, 20) font:FontSize22 color:FontColor565656  alignment:NSTextAlignmentLeft];
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._noticeLab];
    }
    return self;
}

@end


@implementation ShopForEvaluationCell
@synthesize _numLab;

- (void)dealloc
{
    self._numLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"评      价：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._numLab = [UISubLabel labelWithTitle:@"共10条" frame:CGRectMake(85, 0, 80, 30) font:FontSize24 color:FontColor565656  alignment:NSTextAlignmentLeft];
        
        UIImageView *pointView = [UIImageView ImageViewWithFrame:CGRectMake(280, 11, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]];
        
        starImg0.frame = CGRectMake(143, 10, 10, 10);
        starImg1.frame = CGRectMake(143 + 15, 10, 10, 10);
        starImg2.frame = CGRectMake(143 + 15*2, 10, 10, 10);
        starImg3.frame = CGRectMake(143 + 15*3, 10, 10, 10);
        starImg4.frame = CGRectMake(143 + 15*4, 10, 10, 10);
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._numLab];
        [self addSubview:starImg0];
        [self addSubview:starImg1];
        [self addSubview:starImg2];
        [self addSubview:starImg3];
        [self addSubview:starImg4];
        [self addSubview:pointView];
    }
    return self;
}
@end


@implementation ShopForEvaluationInfoCell
@synthesize _dateLab, _detailLab, _nameLab;

- (void)dealloc
{
    self._dateLab = nil;
    self._detailLab = nil;
    self._nameLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 78) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];

        self._nameLab = [UISubLabel labelWithTitle:@"喜羊羊的春天" frame:CGRectMake(25, 0, 80, 30) font:FontSize24 color:[UIColor blueColor] alignment:NSTextAlignmentLeft];
        self._dateLab = [UISubLabel labelWithTitle:@"2013.06.24  17：21" frame:CGRectMake(200, 0, 100, 30) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentRight];
        self._detailLab = [UISubLabel labelWithTitle:@"菜口味很好，老板人很好，下次会再来。" frame:CGRectMake(25, 47, 275, 25) font:FontSize24 color:FontColor656565  alignment:NSTextAlignmentLeft];
        
        starImg0.frame = CGRectMake(25, 30, 16, 16);
        starImg1.frame = CGRectMake(25 + 24, 30, 16, 16);
        starImg2.frame = CGRectMake(25 + 24*2, 30, 16, 16);
        starImg3.frame = CGRectMake(25 + 24*3, 30, 16, 16);
        starImg4.frame = CGRectMake(25 + 24*4, 30, 16, 16);
        
        [self setHeartFrame:CGRectMake(110, 11, 10, 10) withView:self];
        [self setHeartCount:0];
        
        [self addSubview:backView];
        [self addSubview:self._nameLab];
        [self addSubview:self._dateLab];
        [self addSubview:self._detailLab];
        [self addSubview:starImg0];
        [self addSubview:starImg1];
        [self addSubview:starImg2];
        [self addSubview:starImg3];
        [self addSubview:starImg4];
    }
    return self;
}
@end


@implementation ShopForQuestionCell
@synthesize _numLab;
@synthesize _questBut;

- (void)dealloc
{
    self._numLab = nil;
    self._questBut = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"问      答：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._numLab = [UISubLabel labelWithTitle:@"共10条" frame:CGRectMake(85, 0, 80, 30) font:FontSize24 color:FontColor565656  alignment:NSTextAlignmentLeft];
        self._questBut = [UIButton buttonWithTag:0 image:[UIImage imageNamed:@"提问.png"] title:@"我要提问" imageEdge:UIEdgeInsetsMake(9, 8, 9, 50) frame:CGRectMake(230, 0, 70, 30) font:FontSize20 color:FontColorBlue target:nil action:nil];
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._numLab];
        [self addSubview:self._questBut];
    }
    return self;
}
@end


@implementation ShopForQuestionInfoCell
@synthesize _detailLab, _nameLab, _dateLab;

- (void)dealloc
{
    self._detailLab = nil;
    self._nameLab = nil;
    self._dateLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 50) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        self._nameLab = [UISubLabel labelWithTitle:@"喜羊羊的春天" frame:CGRectMake(25, 0, 80, 30) font:FontSize24 color:[UIColor blueColor] alignment:NSTextAlignmentLeft];
        self._detailLab = [UISubLabel labelWithTitle:@"请问一共可以容纳多少人住宿，谢谢！" frame:CGRectMake(25, 20, 275, 25) font:FontSize24 color:FontColor656565  alignment:NSTextAlignmentLeft];
        self._dateLab = [UISubLabel labelWithTitle:@"2013.06.24  17：21" frame:CGRectMake(200, 0, 100, 30) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentRight];
        selectView = [UIImageView ImageViewWithFrame:CGRectMake(98, 10, 10, 10) image:[UIImage imageNamed:@"钩.png"]];
        
        [self addSubview:backView];
        [self addSubview:self._nameLab];
        [self addSubview:self._detailLab];
        [self addSubview:self._dateLab];
//        [self addSubview:selectView];
    }
    return self;
}

- (void)isSelectedImg:(BOOL)boolean
{
    if (boolean) {
        selectView.image = [UIImage imageNamed:@"钩.png"];
    }
    else {
        selectView.image = nil;
    }
}
@end


@implementation ShopForRecommendCell
@synthesize _but1, _but2, _but3, _but4;

- (void)dealloc
{
    self._but1 = nil;
    self._but2 = nil;
    self._but3 = nil;
    self._but4 = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 55) image:[[UIImage imageNamed:@"背景-下.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"推荐周边：" frame:CGRectMake(25, 0, 60, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];

        self._but1 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"农家乐" frame:CGRectMake(13, 18, 74, 30) font:FontSize24 color:FontColor565656 colorWithWhite:0.5 target:nil action:nil];
        self._but2 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"采摘园" frame:CGRectMake(87, 18, 73, 30) font:FontSize24 color:FontColor565656 colorWithWhite:0.5 target:nil action:nil];
        self._but3 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"娱乐" frame:CGRectMake(160, 18, 73, 30) font:FontSize24 color:FontColor565656 colorWithWhite:0.5 target:nil action:nil];
        self._but4 = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"其他" frame:CGRectMake(233, 18, 74, 30) font:FontSize24 color:FontColor565656 colorWithWhite:0.5 target:nil action:nil];
        
        [self addSubview:backView];
        [self addSubview:titleLab];
        [self addSubview:self._but1];
        [self addSubview:self._but2];
        [self addSubview:self._but3];
        [self addSubview:self._but4];
    }
    return self;
}
@end

@implementation ShopForOnlineCell
@synthesize _contentLab, _enterBut, _iconView, _priceLab;
@synthesize _subContentLab;
- (void)dealloc
{
    self._priceLab = nil;
    self._iconView = nil;
    self._enterBut = nil;
    self._contentLab = nil;
    self._subContentLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];//50
    if (self) {
        
        self._contentLab = [UISubLabel labelWithTitle:@"20元代金券" frame:CGRectMake(30, 0, 320-30, 30) font:FontSize24 color:[UIColor blackColor]  alignment:NSTextAlignmentLeft];
        self._subContentLab = [UISubLabel labelWithTitle:@"仅售75元代金券1张" frame:CGRectMake(30, 25, ViewWidth - 145, 20) font:FontSize22 color:FontColor454545  alignment:NSTextAlignmentLeft];
        self._priceLab = [UISubLabel labelWithTitle:@"75" frame:CGRectMake(ViewWidth - 110 + 15, 0, 100, 50) font:FontSize40 color:[UIColor redColor] alignment:NSTextAlignmentLeft];
        
        self._enterBut = [UIButton buttonWithTag:1 frame:CGRectMake(13, 0, 294, 49) target:nil action:nil];
        [self._enterBut setBackgroundImage:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        
        [self addSubview:self._enterBut];
        [self addSubview:self._contentLab];
        [self addSubview:self._subContentLab];
        [self addSubview:[UISubLabel labelWithTitle:@"¥" frame:CGRectMake(ViewWidth - 110, 12, 20, 30) font:FontSize20 color:[UIColor grayColor] alignment:NSTextAlignmentCenter]];
        [self addSubview:self._priceLab];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(280, 21, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]]];
    }
    return self;
}
@end


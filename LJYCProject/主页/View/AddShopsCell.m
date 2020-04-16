//
//  AddShopsCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-29.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "AddShopsCell.h"
#import "ServiceTag.h"
#import "PicModel.h"
#import "DataClass.h"

@implementation AddShopsCell
@synthesize _shopNameField;

- (void)dealloc
{
    self._shopNameField = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 5, 294, 40) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(90, 10, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(100, 23, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"店铺名称" frame:CGRectMake(20, 5, 80, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._shopNameField = [UITextField TextFieldWithFrame:CGRectMake(110, 10, 180, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入店铺名称" font:FontSize24];

        
        [self addSubview:backView];
        [self addSubview:textView];
        [self addSubview:shopTitle];
        [self  addSubview:logoView];
        [self addSubview:self._shopNameField];
    }
    return self;
}

@end


@implementation AddShopAddressCell
@synthesize _shopLocationLab;
@synthesize _locationBut;
@synthesize activityIV;
- (void)dealloc
{
    self._shopLocationLab = nil;
    self._locationBut = nil;
	self.activityIV = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"店铺位置" frame:CGRectMake(25, 0, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
	self.activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	self.activityIV.frame = CGRectMake(220, 10,15, 15);
	[self addSubview:self.activityIV];
	    
        self._locationBut = [UIButton buttonWithTag:0 frame:CGRectMake(260, 0, 30, 30) target:nil action:nil];
        [self._locationBut setImage:[UIImage imageNamed:@"定位按钮.png"] forState:UIControlStateNormal];
        
        self._shopLocationLab = [UISubLabel labelWithTitle:@"" frame:CGRectMake(80, 4, 200, 20) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentLeft];
        
        UISubLabel *textLab = [UISubLabel labelWithTitle:@"为了保证店铺的真实性，需在店铺当前位置定位后，上传店铺才能通过审核。" frame:CGRectMake(25, 30, 277, 30) font:FontSize20 color:FontColorRed alignment:NSTextAlignmentLeft];
        
        [self addSubview:shopTitle];
        [self addSubview:self._locationBut];
        [self addSubview:textLab];
        [self addSubview:self._shopLocationLab];
        
    }
    return self;
}
@end

@implementation AddShopPhotoCell
@synthesize _imgArray;
@synthesize _addImgBut0, _addImgBut1;

- (void)dealloc
{
    self._imgArray = nil;
    self._addImgBut0 = nil;
    self._addImgBut1 = nil;
    [scrollView release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"上传照片" frame:CGRectMake(25, 0, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 120) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(20, 30, 280, 93)];
        scrollView.backgroundColor = [UIColor clearColor];
        
        self._addImgBut0 = [UIButton buttonWithTag:99 image:[UIImage imageNamed:@"相片标识.png"] title:nil imageEdge:UIEdgeInsetsMake(34, 34, 34, 34) frame:CGRectMake(0, 0, 90, 90) font:nil color:nil target:nil action:nil];
        [self._addImgBut0 setBackgroundImage:[[UIImage imageNamed:@"默认图.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        
        self._addImgBut1 = [UIButton buttonWithTag:99 image:[UIImage imageNamed:@"相片标识.png"] title:nil imageEdge:UIEdgeInsetsMake(34, 34, 34, 34) frame:CGRectMake(95, 0, 90, 90) font:nil color:nil target:nil action:nil];
        [self._addImgBut1 setBackgroundImage:[[UIImage imageNamed:@"默认图.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        
        [scrollView addSubview:self._addImgBut0];
        [scrollView addSubview:self._addImgBut1];
        
        UISubLabel *titleLab = [UISubLabel labelWithTitle:@"请上传2至5张照片" frame:CGRectMake(25, 120, 277, 25) font:FontSize20 color:FontColor454545 alignment:NSTextAlignmentLeft];
        
        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:scrollView];
        [self addSubview:titleLab];
        [scrollView release];
    }
    return self;
}

- (void)set_imgArray:(NSArray *)array
{
    float width = 95;
    int imgNum = [array count];
    
    NSArray *imgArr = [scrollView subviews];
    for (UIView *suView in imgArr) {
        [suView removeFromSuperview];
    }
    if ([array count] == 0) {
        [scrollView addSubview:self._addImgBut0];
        [scrollView addSubview:self._addImgBut1];
        return;
    }
    for (int i = 0; i<imgNum; i++) {
        
        PicModel *model = [array objectAtIndex:i];
        UIImage * img = model._image;
        
        UIButton * buton = [UIButton buttonWithTag:i image:nil title:nil imageEdge:UIEdgeInsetsMake(13, 42, 13, 42) frame:CGRectMake(i * width, 0, 90, 90) font:nil color:nil target:nil action:nil];
        [buton setBackgroundImage:img forState:UIControlStateNormal];
        
        [scrollView addSubview:buton];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    scrollView.contentSize = CGSizeMake(width * imgNum, 90);
    
    if (width * imgNum > 280) {
        scrollView.contentOffset = CGPointMake(width * imgNum - 280, 0);
    }
    
    [UIView commitAnimations];
}

@end

@implementation AddShopTypeCell
@synthesize delegate;
@synthesize _preBtn,_btnArr;
- (void)dealloc
{
    self.delegate = nil;
    self._preBtn = nil;
    self._btnArr = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"店铺类型" frame:CGRectMake(25, 2, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 100) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(25, 37, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
        
        UISubLabel *textLab = [UISubLabel labelWithTitle:@"请选择以下店铺经营类型" frame:CGRectMake(32, 29, 270, 20) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:logoView];
        [self addSubview:textLab];
        
        UIScrollView * scroollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
        [self addSubview:scroollV];
        [scroollV release];
        
        NSMutableArray * _mArr = [NSMutableArray array];
        NSArray *typeArr = [DataClass selectShopType] ;
        for (int i = 0; i < [typeArr count]; i++) {
            UIButton * btn =[UIButton buttonWithTag:i image:[UIImage imageNamed:@"单选-01.png"] title:nil imageEdge:UIEdgeInsetsMake(0, 0, 0, 0) frame:CGRectMake(22+i*60, 60, 35, 35) font:nil color:nil target:self action:@selector(clickBut:)];
            [scroollV addSubview:btn];
            [_mArr addObject:btn];
            ShopType * type = [typeArr objectAtIndex:i];
            [scroollV addSubview:[UISubLabel labelWithTitle:type._Type_name frame:CGRectMake(9.5+i*60, 95, 60, 30) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentCenter]];
            
            scroollV.contentSize = CGSizeMake(9.5+i*60+60, 130);
        }
        self._btnArr = _mArr;
        
    }
    return self;
}

- (void)selectType:(NSInteger)index
{
    if (index == -1) {
        if (self._preBtn) {
            [self._preBtn setImage:[UIImage imageNamed:@"单选-01.png"] forState:UIControlStateNormal];
        }
        return;
    }
    UIButton * btn = [self._btnArr objectAtIndex:index];
    [btn setImage:[UIImage imageNamed:@"单选-00.png"] forState:UIControlStateNormal];
    self._preBtn = btn;
}

- (void)clickBut:(UIButton *)sender
{
    [self._preBtn setImage:[UIImage imageNamed:@"单选-01.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"单选-00.png"] forState:UIControlStateNormal];
    self._preBtn = sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedBut:)]) {
        [self.delegate performSelector:@selector(selectedBut:) withObject:sender];
    }
}
@end


@implementation AddShopServiceCell
@synthesize _serviceArr;

- (void)dealloc
{
    self._serviceArr = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"服务类型" frame:CGRectMake(25, 2, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 60) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(25, 37, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
        
        UISubLabel *textLab = [UISubLabel labelWithTitle:@"请从右侧按钮选择服务类型" frame:CGRectMake(32, 29, 270, 20) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *pointView = [UIImageView ImageViewWithFrame:CGRectMake(280, 37, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]];
        
        UIImageView *lineView = [UIImageView ImageViewWithFrame:CGRectMake(22, 52, 276, 1) image:[[UIImage imageNamed:@"横向分割线.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:1]];
        
        scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(20, 52, 280, 35)];
        scrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:logoView];
        [self addSubview:textLab];
        [self addSubview:lineView];
        [self addSubview:pointView];
        [self addSubview:scrollView];
    }
    return self;
}

- (void)set_serviceArr:(NSArray *)array
{
    NSArray *scrllArr = [scrollView subviews];
    for (int i = 0; i < [scrllArr count]; i ++) {
        
        UIView *subView = [scrllArr objectAtIndex:i];
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i<[array count]; i++) {
        
        float width = 70;
        
        ServiceTag *sTag = [array objectAtIndex:i];
        NSString * string = sTag._tag_name;
        
        UIImageView *serverView = [UIImageView ImageViewWithFrame:CGRectMake(2 + width * i, 8, 15, 15) image:[UIImage imageNamed:@"服务标识.png"]];
        UISubLabel *shopItemLab = [UISubLabel labelWithTitle:string frame:CGRectMake(18 + width * i, 3, 55, 25) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        scrollView.contentSize = CGSizeMake(width * i + 70, 35);
        
        [scrollView addSubview:serverView];
        [scrollView addSubview:shopItemLab];
        
        [self addSubview:scrollView];
    }
}
@end


@implementation AddShopScaleCell
@synthesize _shopScaleLab, _unwindBut;

- (void)dealloc
{
    self._shopScaleLab = nil;
    self._unwindBut = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"接待规模" frame:CGRectMake(25, 2, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 40) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(25, 30, 270, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(35, 43, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
        
//        self._unwindBut = [UIButton buttonWithTag:10 frame:CGRectMake(45, 30, 250, 30) target:nil action:nil];
//        
//        self._shopScaleLab = [UISubLabel labelWithTitle:@"请选择人数" frame:CGRectMake(45, 30, 250, 30) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentLeft];

        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:textView];
        [self addSubview:logoView];
        [self addSubview:self._shopScaleLab];
        [self addSubview:self._unwindBut];
    }
    return self;
}

@end


@implementation AddShopDateCell
@synthesize _shopDateLab, _unwindBut;

- (void)dealloc
{
    self._unwindBut = nil;
    self._shopDateLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"营业周期" frame:CGRectMake(25, 2, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 40) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(25, 30, 120, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(35, 43, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
        
        
        UIImageView *textView2 = [UIImageView ImageViewWithFrame:CGRectMake(175, 30, 120, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *logoView2 = [UIImageView ImageViewWithFrame:CGRectMake(185, 43, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
        
        
        UISubLabel *middleLab = [UISubLabel labelWithTitle:@"至" frame:CGRectMake(145, 30, 30, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentCenter];
        
        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:textView];
        [self addSubview:logoView];
        [self addSubview:self._unwindBut];
        [self addSubview:textView2];
        [self addSubview:logoView2];
        [self addSubview:middleLab];
    }
    return self;
}

@end


@implementation AddShopPhoneCell
@synthesize _phoneField;

- (void)dealloc
{
    self._phoneField = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"商家手机" frame:CGRectMake(25, 2, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 40) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(25, 30, 270, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(35, 43, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
        
        self._phoneField  = [UITextField TextFieldWithFrame:CGRectMake(45, 30, 250, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入正确的11位手机号码" font:FontSize24];
        self._phoneField.keyboardType = UIKeyboardTypeNumberPad;
        
        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:textView];
        [self addSubview:logoView];
        [self addSubview:self._phoneField];
    }
    return self;
}

@end


@implementation AddShopIntroduceCell
@synthesize _textView, _endLab;

- (void)dealloc
{
    self._textView = nil;
    self._endLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"店铺简介" frame:CGRectMake(25, 2, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 90) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(25, 35, 270, 62) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        self._textView = [UITextView TextViewWithFrame:CGRectMake(25, 37, 270, 58) font:FontSize24 textColor:FontColor000000];
//        self._textView.placeholder = @"例：百年老店，祖传秘方，欢迎各界驴友前来，经营项目垂钓、旅游景点、虹鳟鱼等";
        
        self._endLab = [UISubLabel labelWithTitle:@"您还需要输入9个字" frame:CGRectMake(45, 95, 250, 20) font:FontSize24 color:FontColor565656 alignment:NSTextAlignmentRight];
        
        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:textView];
        [self addSubview:self._textView];
        [self addSubview:self._endLab];
    }
    return self;
}

@end


@implementation AddShopNoticeCell
@synthesize _textView, _endLab;

- (void)dealloc
{
    self._textView = nil;
    self._endLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"店铺公告" frame:CGRectMake(25, 2, 50, 25) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 25, 294, 80) image:[[UIImage imageNamed:@"上传商家-框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(25, 35, 270, 50) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        self._textView = [UIPlaceHolderTextView TextViewWithFrame:CGRectMake(25, 35, 270, 50) font:FontSize24 textColor:FontColor000000];
        self._textView.placeholder = @"请输入店铺最近活动的相关信息，例：樱桃采摘30元一斤";
        
        self._endLab = [UISubLabel labelWithTitle:@"您还可以输入20个字" frame:CGRectMake(45, 85, 250, 20) font:FontSize24 color:FontColor565656 alignment:NSTextAlignmentRight];
        
        [self addSubview:backView];
        [self addSubview:shopTitle];
        [self addSubview:textView];
        [self addSubview:self._textView];
        [self addSubview:self._endLab];
    }
    return self;
}

@end
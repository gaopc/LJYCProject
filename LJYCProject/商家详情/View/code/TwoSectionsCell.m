//
//  TwoSectionsCell.m
//  LJYCProject
//
//  Created by z1 on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "TwoSectionsCell.h"


@implementation TSectionsOneCell
@synthesize title,simpleDesc,buyCount,time;
@synthesize anyTimeGView,anyTimeRView,expTimeGView,expTimeRView,anyTimeL,expTimeL;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 140.0f) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
		[self addSubview:backView];
		
		self.title = [UISubLabel labelWithTitle:@"太熟悉家常菜" frame:CGRectMake(15.0f, 5.0f, 290.0f, 25.0f) font:FontBlodSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
		[self addSubview:self.title];
		
		NSString *desc = @"仅售41元,价值50元代金券1张!川粤美菜做主打,新派菜肴引佳话!情意浓厚道家常,香飘四溢惹分享!";
		
		self.simpleDesc = [UISubLabel labelWithTitle:desc frame:CGRectMake(15.0f, 30.0f, 290.0f, 40.0f) font:FontSize24 color:FontColor656565 alignment:NSTextAlignmentLeft];
		self.simpleDesc.numberOfLines = 3;
		self.simpleDesc.lineBreakMode = UILineBreakModeTailTruncation;
		[self addSubview:self.simpleDesc];
		
		
		self.anyTimeGView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 83.0f, 10.0f, 10.0f) image:[UIImage imageNamed:@"已阅读.png"]];
		self.anyTimeGView.hidden = YES;
		[self addSubview:self.anyTimeGView];
		
		self.anyTimeRView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 83.0f, 10.0f, 10.0f) image:[UIImage imageNamed:@"不支持.png"]];
		self.anyTimeRView.hidden = YES;
		[self addSubview:self.anyTimeRView];
		
		self.anyTimeL = [UISubLabel labelWithTitle:@"支持随时退" frame:CGRectMake(34.0f, 83.0f, 100.0f, 12.0f) font:FontSize24 color:FontColor656565 alignment:NSTextAlignmentLeft];
		[self addSubview:self.anyTimeL];
		
		self.expTimeGView = [UIImageView ImageViewWithFrame:CGRectMake(136.0f, 83.0f, 10.0f, 10.0f) image:[UIImage imageNamed:@"已阅读.png"]];
		self.expTimeGView.hidden = YES;
		[self addSubview:self.expTimeGView];
		
		self.expTimeRView = [UIImageView ImageViewWithFrame:CGRectMake(136.0f, 83.0f, 10.0f, 10.0f) image:[UIImage imageNamed:@"不支持.png"]];
		self.expTimeRView.hidden = YES;
		[self addSubview:self.expTimeRView];
		
		//[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(136.0f, 83.0f, 10.0f, 10.0f) image:[UIImage imageNamed:@"不支持.png"]]];
		
		self.expTimeL = [UISubLabel labelWithTitle:@"支持随时退" frame:CGRectMake(150.0f, 83.0f, 100.0f, 12.0f) font:FontSize24 color:FontColor656565 alignment:NSTextAlignmentLeft];
		[self addSubview:self.expTimeL];
		
		//[self addSubview:[UISubLabel labelWithTitle:@"支持过期退" frame:CGRectMake(150.0f, 83.0f, 100.0f, 12.0f) font:FontSize24 color:FontColor656565 alignment:NSTextAlignmentLeft]];
		
		UIImageView *lineView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 110.0f, 280.0f, 0.5f) image:nil];
		lineView.backgroundColor = FontColor656565;
		[self addSubview:lineView];
	
		self.buyCount = [UISubLabel labelWithTitle:@"9987 人购买" frame:CGRectMake(15.0f, 120.0f, 100.0f, 10.0f) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentLeft];
		[self addSubview:self.buyCount];
		
		
		self.time = [UISubLabel labelWithTitle:@"3天以上" frame:CGRectMake(245.0f, 120.0f, 60.0f, 10.0f) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentRight];
		[self addSubview:self.time];
		
		
	
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

- (void) dealloc {
	
	self.title = nil;
	self.simpleDesc = nil;
	self.anyTimeGView = nil;
	self.anyTimeRView = nil;
	self.expTimeGView = nil;
	self.expTimeRView = nil;
	self.anyTimeL = nil;
	self.expTimeL = nil;
	[super dealloc];
}

@end

@implementation TSectionsTwoCell
@synthesize title,desc;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		backView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 0.0f) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
		[self addSubview:backView];
		
		[self addSubview: [UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 30) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
		
		[self addSubview:[UISubLabel labelWithTitle:@"团购详情" frame:CGRectMake(25, 0, 250, 30) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft]];
		
		//self.title = [UISubLabel labelWithTitle:@"凭大众点评网团购券可享受以下内容：" frame:CGRectMake(15.0f, 35.0f, 290.0f, 15.0f) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
		//[self addSubview:self.title];
		
				
	}
	return self;
}

- (void)initWithContent:(NSString *)content
{
	//NSString *content = @" - 代金券（1张，仅售41元，价值50元）\n - 代金券（1张，仅售41元，价值50元）";
	
	self.desc = [UISubLabel labelWithTitle:content frame:CGRectMake(10.0f, 35.0f, 300.0f, 60.0f) font:FontSize24 color:FontColor656565 alignment:NSTextAlignmentLeft];
	self.desc.numberOfLines = 50 ;
	self.desc.lineBreakMode = UILineBreakModeTailTruncation;
	CGSize contentSize = [content sizeWithFont:FontSize28 constrainedToSize:CGSizeMake(self.desc.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
	CGRect verFrame = self.desc.frame;
	verFrame.size.height =  contentSize.height;
	self.desc.frame = verFrame;
	[self addSubview:self.desc];
	
	CGRect backFrame = backView.frame;
	backFrame.size.height =  contentSize.height+45;
	backView.frame = backFrame;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

+ (int)height:(NSString *)content{
	
	//NSString *content = @" - 代金券（1张，仅售41元，价值50元）\n - 代金券（1张，仅售41元，价值50元）";
	CGSize contentSize = [content sizeWithFont:FontSize28 constrainedToSize:CGSizeMake(300.0f, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
	return contentSize.height + 45.0f ;
}

- (void) dealloc {
	
	self.desc = nil;
	[super dealloc];
}

@end

@implementation TSectionsThreeCell
@synthesize desc;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		
		backView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 0.0f) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
		[self addSubview:backView];
		
		[self addSubview: [UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 30) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
		[self addSubview:[UISubLabel labelWithTitle:@"特别提示" frame:CGRectMake(25, 0, 250, 30) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft]];
		

		
	}
	return self;
}

- (void)initWithContent:(NSString *)content
{
	//NSString *content = @"有效期：2013-04-27 至 2014-03-31\n右安门店有效期从2014年2月15日开始\n仅限北京：交大东路店、惠新店、通州店、新源里店、方庄店；廊坊：燕郊店使用\n可使用大厅及包间，包间必须提前1天预约\n3桌及3桌以上包桌和宴会不可使用此券，不可分桌结账\n方庄店早餐10：00之前不可使用\n到店仅限堂食，不提供餐前打包；餐后未吃完，可打包（打包费以店内实际为准）\n本次团购不提供外送服务\n包间必须提前1天预约\n除外日期：12月24日、2014年1月1日-3日、1月30日-2月6日、2月14日";
	self.desc = [UISubLabel labelWithTitle:content frame:CGRectMake(15.0f, 35.0f, 290.0f, 0.0f) font:FontSize24 color:FontColor656565 alignment:NSTextAlignmentLeft];
	self.desc.numberOfLines = 100 ;
	self.desc.lineBreakMode = UILineBreakModeTailTruncation;
	CGSize contentSize = [content sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(self.desc.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
	CGRect verFrame = self.desc.frame;
	verFrame.size.height =  contentSize.height;
	self.desc.frame = verFrame;
	[self addSubview:self.desc];
	
	CGRect backFrame = backView.frame;
	backFrame.size.height =  contentSize.height+45;
	backView.frame = backFrame;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

+ (int)height:(NSString *)content{
	
	//NSString *content = @"有效期：2013-04-27 至 2014-03-31\n右安门店有效期从2014年2月15日开始\n仅限北京：交大东路店、惠新店、通州店、新源里店、方庄店；廊坊：燕郊店使用\n可使用大厅及包间，包间必须提前1天预约\n3桌及3桌以上包桌和宴会不可使用此券，不可分桌结账\n方庄店早餐10：00之前不可使用\n到店仅限堂食，不提供餐前打包；餐后未吃完，可打包（打包费以店内实际为准）\n本次团购不提供外送服务\n包间必须提前1天预约\n除外日期：12月24日、2014年1月1日-3日、1月30日-2月6日、2月14日";
	CGSize contentSize = [content sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(294.0f, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
	return contentSize.height + 45.0f ;
	//return 120 ;
}

- (void) dealloc {
	
	self.desc = nil;
	[super dealloc];
}


@end

@implementation TSectionsFourCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		[self addSubview: [UIImageView ImageViewWithFrame:CGRectMake(10, 10, 300, 40) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
		[self addSubview: [UIImageView ImageViewWithFrame:CGRectMake(280, 25, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]]];
		[self addSubview: [UISubLabel labelWithTitle:@"更多详情" frame:CGRectMake(25, 13, 250, 30) font:FontSize24 color:FontColor454545  alignment:NSTextAlignmentLeft]];
		
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

@end


@implementation TwoSectionsCell

@synthesize webView;


- (void) dealloc {
	
	
	self.webView = nil;
	
	[super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
	    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, ViewHeight - 120.0f) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
	    [self addSubview:backView];
	    
	    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
	    [self.webView  setUserInteractionEnabled:YES];
	    [self.webView  setBackgroundColor:[UIColor clearColor]];
	    [self.webView  setDelegate:self];
	    [self.webView  setOpaque:NO];//使网页透明
	    self.webView .scalesPageToFit = YES;
	    self.webView .autoresizesSubviews = YES;
	    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	    
	    [self addSubview:self.webView];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

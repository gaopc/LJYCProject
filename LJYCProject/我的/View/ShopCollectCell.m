//
//  ShopCollectCell.m
//  LJYCProject
//
//  Created by z1 on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopCollectCell.h"

@implementation ShopCollectCell

@synthesize shopImageView;
@synthesize area,distance,name,rating,serviceTags,phoneButton,notice,delegate,locate,check,bgImageView,shopClose,phoneNoButton,shopRest;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		
		
		self.bgImageView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 5.0f, 300.0f, 86.0f) image:[UIImage imageNamed:@"ShopListCellBg.png"]];
		[self addSubview:self.bgImageView];
		
		self.shopImageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(13.0f, 8.0f, 125.0f, 80.0f)];
		self.shopImageView.defaultImage = 1;
		self.shopImageView._cutImage = YES;
		[self addSubview:self.shopImageView];
		
		self.name =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(142.0f, 7.0f, 138.0f, 17.0f) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
		[self addSubview:self.name];
		
		self.notice = [UIImageView ImageViewWithFrame:CGRectMake(288.0f, 5.0f, 16.5f, 38.5f) image:[UIImage imageNamed:@"Notice.png"]];
		[self addSubview:self.notice];
		
		self.shopClose = [UIImageView ImageViewWithFrame:CGRectMake(288.0f, 5.0f, 16.5f, 38.5f) image:[UIImage imageNamed:@"ShopClose.png"]];
		self.shopClose.hidden = YES;
		[self addSubview:self.shopClose];
		
		self.shopRest = [UIImageView ImageViewWithFrame:CGRectMake(288.0f, 5.0f, 16.5f, 38.5f) image:[UIImage imageNamed:@"ShopRest.png"]];
		self.shopRest.hidden = YES;
		[self addSubview:self.shopRest];
		
		self.locate = [UIImageView ImageViewWithFrame:CGRectMake(147.0f, 37.0f, 6.0f, 9.0f) image:[UIImage imageNamed:@"LocateIcon.png"]];
		[self addSubview:self.locate];
		
		
		self.area =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(160.0f, 36.0f, 60.0f, 14.0f) font:FontSize22 color:[UIColor grayColor] alignment:NSTextAlignmentLeft];
		[self addSubview:self.area];
		
		
		self.distance =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(220.0f, 36.0f, 80, 12.0f) font:FontSize20 color:FontColorFFADAD alignment:NSTextAlignmentLeft];
		//[self.contentView addSubview:self.distance];
		
		self.check = [UIImageView ImageViewWithFrame:CGRectMake(145.0f, 52.0f, 9.0f, 9.0f) image:[UIImage imageNamed:@"Check.png"]];
		//[self.contentView addSubview:self.check];
		
		
		self.rating =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(160.0f, 52.0f, 100.0f, 12.0f) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentLeft];
		self.rating.text = @"服务项目";
		[self addSubview:self.rating];
		
	        
		self.serviceTags =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(160.0f, 63.0f, 100.0f, 28.0f) font:FontSize22 color:FontColor9CBAC6 alignment:NSTextAlignmentLeft];
		self.serviceTags.numberOfLines = 2;
		self.serviceTags.lineBreakMode = UILineBreakModeTailTruncation;
		[self addSubview:self.serviceTags];
		
		
		self.phoneButton = [UIButton buttonWithType:UIButtonTypeCustom tag:201 title:@"" frame:CGRectMake(275.0f, 57.0f,  32.0f,  31.5f) backImage:[UIImage imageNamed:@"Phone.png"] target:self action:@selector(phoneClick:)];
		[self.phoneButton setImage:[UIImage imageNamed:@"PhoneClick.png"] forState:UIControlStateHighlighted];
		[self addSubview:self.phoneButton];
		
		self.phoneNoButton = [UIImageView ImageViewWithFrame:CGRectMake(275.0f, 57.0f,  32.0f,  31.5f) image:[UIImage imageNamed:@"PhoneClose.png"]];
		self.phoneNoButton.hidden = YES;
		[self addSubview:self.phoneNoButton];
		
		
		
		
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
}


- (void)phoneClick:(UIButton *)sender
{
	if (self.delegate)
	{
		[self.delegate phoneClick:sender];
	}
}

-(void)drawStarCodeView:(float) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(145, 25, 75, 14)];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*11, 0, 9.5, 9)];
			starGreenImg.image = [UIImage imageNamed:@"Star_Golden.png"]; //选中
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			if (markValue>=0.5) {
				UIImageView *starHalfImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*11, 0, 9.5, 9)];
				starHalfImg.image = [UIImage imageNamed:@"Star_Half.png"];
				[self.markValueView addSubview:starHalfImg];
				[starHalfImg release];
				markValue = markValue - 0.5;
				
			}else{
				UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*11, 0, 9.5, 9)];
				starWhiteImg.image = [UIImage imageNamed:@"Star_Gray.png"];
				[self.markValueView addSubview:starWhiteImg];
				[starWhiteImg release];
			}
			
		}
	}
	[self addSubview:self.markValueView];
	[self.markValueView release];
	
}



- (void) dealloc {
	
	self.shopImageView = nil;
	self.distance = nil;
	self.name = nil;
	self.rating = nil;
	self.serviceTags = nil;
	self.markValueView = nil;
	self.phoneButton = nil;
	self.notice = nil;
	self.delegate = nil;
	self.locate = nil;
	self.check = nil;
	self.bgImageView = nil;
	self.shopClose =nil;
	self.phoneNoButton =nil;
	self.shopRest =nil;
	[super dealloc];
	
}


@end

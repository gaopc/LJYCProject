//
//  TitleSectionsView.m
//  LJYCProject
//
//  Created by z1 on 14-3-11.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "TitleSectionsView.h"
#import "ShopForOrderViewController.h"

@implementation TitleSectionsView
@synthesize nprice,oprice,carBtn;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = [UIColor clearColor];
		[self addSubview: [UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 70) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
		
		
		self.nprice = [UISubLabel labelWithTitle:@"¥120" frame:CGRectMake(25.0f, 12.0f, 105.0f, 40.0f) font:FontBlodSize42 color:FontColor000000 alignment:NSTextAlignmentLeft];
		[self addSubview:self.nprice];
		
		

		
		self.oprice = [UISubLabel labelWithTitle:@"¥220" frame:CGRectMake(65.0f, 25.0f, 60.0f, 15.0f) font:FontSize30 color:FontColor656565 alignment:NSTextAlignmentLeft];
		[self addSubview:self.oprice];
		
		
		
		lineView = [UIImageView ImageViewWithFrame:CGRectMake(65, 33.0f, 60.0f, 1.0f) image:nil];
		lineView.backgroundColor = FontColor656565;
		[self addSubview:lineView];
		
		
		self.carBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"立即抢购" backImage:[UIImage imageNamed:@"CarButton.png"] frame:CGRectMake(210, 15, 85, 40) font:FontBlodSize30 color:FontColorFFFFFF target:self action:@selector(carClick:)];
//		[self.carBtn setBackgroundImage:[UIImage imageNamed:@"CarButton.png"] forState:UIControlStateHighlighted];
		[self addSubview:self.carBtn];
		
	}
	
	return self;
}

-(void) setContentSize
{
	CGSize contentSize = [self.nprice.text sizeWithFont:FontBlodSize42 constrainedToSize:CGSizeMake(MAXFLOAT, self.nprice.frame.size.height) lineBreakMode:NSLineBreakByTruncatingTail];
	CGRect verFrame = self.nprice.frame;
	verFrame.size.width =  contentSize.width;
	self.nprice.frame = verFrame;
	
	
	contentSize = [self.oprice.text sizeWithFont:FontSize30 constrainedToSize:CGSizeMake(MAXFLOAT, self.oprice.frame.size.height) lineBreakMode:NSLineBreakByTruncatingTail];
	verFrame = self.oprice.frame;
	verFrame.size.width =  contentSize.width;
	verFrame.origin.x =self.nprice.frame.size.width+60.0f;
	self.oprice.frame = verFrame;
	
	CGRect verFrameLine  = lineView.frame;
	verFrameLine.origin.x =self.oprice.frame.origin.x;
	verFrameLine.size.width = self.oprice.frame.size.width+3.0f;
	lineView.frame = verFrameLine;
}
- (void)carState:(int)state
{
	if (state==1) {
		self.carBtn.enabled = NO;
		[self.carBtn setTitle:@"已售完" forState:UIControlStateNormal];
	}else{
		self.carBtn.enabled = YES;
		[self.carBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
	}
}

- (void)carClick:(UIButton *)sender
{
	if (self.delegate)
	{
		[self.delegate carClick:sender];
	}
}


- (void) dealloc {
	
	self.carBtn = nil;
	self.oprice = nil;
	self.nprice = nil;
	self.delegate = nil;
	[super dealloc];
}


@end


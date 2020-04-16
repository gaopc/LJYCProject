//
//  CustomAnnotationCell.m
//  LJYCProject
//
//  Created by z1 on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "CustomAnnotationCell.h"

@implementation CustomAnnotationCell
@synthesize imgeView,titleLabel,shopButton;


- (void) dealloc {
	
	self.imgeView = nil;
	self.titleLabel = nil;
	self.shopButton = nil;
	
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		
		
		self.imgeView = [[AsyncImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 75)];
		self.imgeView._cutImage = YES;
		[self addSubview:self.imgeView];
		
		self.titleLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 5, 120, 50) font:FontSize30 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
		self.titleLabel.numberOfLines = 2;
		[self addSubview:self.titleLabel];
				
	}
	return self;
}




-(void)drawStarCodeView:(float) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(100, 55, 95, 15 )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14, 0, 12.5, 12)];
			starGreenImg.image = [UIImage imageNamed:@"Star_Golden.png"]; //选中
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			if (markValue>=0.5) {
				UIImageView *starHalfImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14, 0, 12.5, 12)];
				starHalfImg.image = [UIImage imageNamed:@"Star_Half.png"];
				[self.markValueView addSubview:starHalfImg];
				[starHalfImg release];
				markValue = markValue - 0.5;
				
			}else{
				UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14, 0, 12.5, 12)];
				starWhiteImg.image = [UIImage imageNamed:@"Star_Gray.png"];
				[self.markValueView addSubview:starWhiteImg];
				[starWhiteImg release];
			}
			
		}
	}
	[self addSubview:self.markValueView];
	[self.markValueView release];
	
}




@end

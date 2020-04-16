//
//  CustomMKAnnotationView.m
//  LJYCProject
//
//  Created by z1 on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "CustomMKAnnotationView.h"

@interface CustomMKAnnotationView() {
	
}

-(void)drawBackground:(CGContextRef)context;

- (void)drawArrowBoundPath:(CGContextRef)context;

@end


@implementation CustomMKAnnotationView
@synthesize contentView,cell;

- (void)dealloc

{
	
	self.contentView = nil;
	self.cell =nil;
	[super dealloc];
	
}

- (id)initWithFrame:(CGRect)rct  Annotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier

{
	
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	
	if (self) {
		
		self.backgroundColor = [UIColor clearColor];
		
		self.canShowCallout = NO;
		
		self.frame = rct;
		
		self.centerOffset = CGPointMake(0, -(self.frame.size.height/2.0 + 30));
		
		if (self.contentView) {
			
			[self.contentView removeFromSuperview];
		}
		
		self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 15)];
		
		self.contentView.backgroundColor   = [UIColor clearColor];
		
		[self addSubview:self.contentView];
		
		
		 self.cell = [[CustomAnnotationCell alloc] initWithFrame:CGRectMake(0, 0, 293, 98)];
		[self.contentView addSubview:self.cell];
		
	}
	
	return self;
	
}

- (void)drawBackground:(CGContextRef)context

{
	
	CGContextSetLineWidth(context, 2.0);
	
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1].CGColor);
	
	[self drawArrowBoundPath:context];
	
	CGContextFillPath(context);
	
	
	
}

- (void)drawArrowBoundPath:(CGContextRef)context

{
	
	CGRect rrect = self.bounds;
	
	CGFloat radius = 6.0;
	
	
	
	CGFloat minx = CGRectGetMinX(rrect),
	
	midx = CGRectGetMidX(rrect),
	
	maxx = CGRectGetMaxX(rrect);
	
	CGFloat miny = CGRectGetMinY(rrect),
	
	maxy = CGRectGetMaxY(rrect)-15;
	
	CGContextMoveToPoint(context, midx+15, maxy);
	
	CGContextAddLineToPoint(context,midx, maxy+15);
	
	CGContextAddLineToPoint(context,midx-15, maxy);
	
	
	
	CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
	
	CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
	
	CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
	
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	
	CGContextClosePath(context);
	
}


- (void)drawRect:(CGRect)rect

{
	
	[self drawBackground:UIGraphicsGetCurrentContext()];
	
	
	
	self.layer.shadowColor = [[UIColor blackColor] CGColor];
	
	self.layer.shadowOpacity = 1.0;
	
	self.layer.shadowOffset = CGSizeMake(-0.5f, 0.5f);
	
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  CoustomScrollerView.m
//  LJYCProject
//
//  Created by z1 on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "CoustomScrollerView.h"
#import "AsyncImageView.h"
@implementation CoustomScrollerView

@synthesize delegate;

- (void)dealloc {
	
	[scrollView release];
	[noteTitle release];
	delegate=nil;
	if (pageControl) {
		[pageControl release];
	}
	if (imageArray) {
		[imageArray release];
		imageArray=nil;
	}
	if (titleArray) {
		[titleArray release];
		titleArray=nil;
	}
	[super dealloc];
}
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr
{
	
	if ((self=[super initWithFrame:rect])) {
		self.userInteractionEnabled=YES;
		titleArray=[titArr retain];
		NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
		if (tempArray.count>0){
			[tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
			[tempArray addObject:[imgArr objectAtIndex:0]];
			imageArray=[[NSArray arrayWithArray:tempArray] retain];
		}else{
			imageArray=[[NSArray arrayWithArray:tempArray] retain];
		}
		
		viewSize=rect;
		NSUInteger pageCount=[imageArray count];
		scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
		scrollView.pagingEnabled = YES;
		scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.showsVerticalScrollIndicator = NO;
		scrollView.scrollsToTop = NO;
		scrollView.delegate = self;
		if (pageCount==0) {
			AsyncImageView *imgView = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
			imgView.defaultImage = 2;
			[scrollView addSubview:imgView];
			[imgView release];
		}else{
			for (int i=0; i<pageCount; i++) {
				NSString *imgURL=[imageArray objectAtIndex:i];
				
				AsyncImageView *imgView=[[[AsyncImageView alloc] init] autorelease];
				imgView.defaultImage = 2;
				[imgView setUrlString:imgURL];
				[imgView setFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
				imgView.tag=i;
				UITapGestureRecognizer *Tap =[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)] autorelease];
				[Tap setNumberOfTapsRequired:1];
				[Tap setNumberOfTouchesRequired:1];
				imgView.userInteractionEnabled=YES;
				[imgView addGestureRecognizer:Tap];
				[scrollView addSubview:imgView];
			}
			[scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
		}

		
		[self addSubview:scrollView];
		
		
		
		//说明文字层
//		UIView *noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
//		[noteView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5]];
		
		float pageControlWidth=(pageCount-2)*10.0f+40.f;
		float pagecontrolHeight=20.0f;
		pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth),180, pageControlWidth, pagecontrolHeight)];
		pageControl.currentPage=0;
		pageControl.numberOfPages=(pageCount-2);
		[self addSubview:pageControl];
		
//		noteTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.frame.size.width-pageControlWidth-15, 20)];
//		[noteTitle setText:[titleArray objectAtIndex:0]];
//		[noteTitle setBackgroundColor:[UIColor clearColor]];
//		[noteTitle setFont:[UIFont systemFontOfSize:13]];
//		[noteView addSubview:noteTitle];
		
//		[self addSubview:noteView];
//		[noteView release];
	}
	return self;
}





- (void)scrollViewDidScroll:(UIScrollView *)sender
{
	CGFloat pageWidth = scrollView.frame.size.width;
	int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	currentPageIndex=page;
	
	pageControl.currentPage=(page-1);
	int titleIndex=page-1;
	if (titleIndex==[titleArray count]) {
		titleIndex=0;
	}
	if (titleIndex<0) {
		titleIndex=[titleArray count]-1;
	}
	[noteTitle setText:[titleArray objectAtIndex:titleIndex]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
	if (currentPageIndex==0) {
		
		[_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
	}
	if (currentPageIndex==([imageArray count]-1)) {
		
		[_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
		
	}
	
}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{
	
	if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
		[delegate CScrollerViewDidClicked:sender.view.tag];
	}
}

@end

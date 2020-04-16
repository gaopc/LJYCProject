//
//  CoustomScrollerView.h
//  LJYCProject
//
//  Created by z1 on 14-3-10.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CScrollerViewDelegate <NSObject>
@optional
-(void)CScrollerViewDidClicked:(NSUInteger)index;
@end

@interface CoustomScrollerView : UIView<UIScrollViewDelegate>{
	CGRect viewSize;
	UIScrollView *scrollView;
	NSArray *imageArray;
	NSArray *titleArray;
	UIPageControl *pageControl;
	id<CScrollerViewDelegate> delegate;
	int currentPageIndex;
	UILabel *noteTitle;
}
@property(nonatomic,retain)id<CScrollerViewDelegate> delegate;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr;
@end




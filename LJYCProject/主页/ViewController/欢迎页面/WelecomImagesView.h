//
//  WelecomImagesView.h
//  FlightProject
//
//  Created by longcd on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ImageCount 2

@protocol WelecomImagesViewDelegate <NSObject>

-(void)scrollViewFinished;

@end

@interface WelecomImagesView : UIView<UIScrollViewDelegate>
{
    NSInteger currentPageIndex;
    UIScrollView *_scrollView ;
    UIPageControl * pageC;
    UIButton * showMainButton;
}
@property (nonatomic,assign) id delegate;
+ (BOOL) isFirstShow;
+ (BOOL) isShowGrade;
@end

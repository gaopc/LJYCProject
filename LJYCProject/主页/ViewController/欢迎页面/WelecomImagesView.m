//
//  WelecomImagesView.m
//  FlightProject
//
//  Created by longcd on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WelecomImagesView.h"

@implementation WelecomImagesView
@synthesize delegate;
-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

+ (BOOL) isFirstShow {
	NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:FIRSTINALERT_ThreeDemain];
	if ([tempStr intValue] < MyVersionCode) {
		return YES;
	}
	return NO;
}
//是否显示评分 崔立东 2013年3月5日添加
+ (BOOL) isShowGrade {
	NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:keyShowGrade];
	if ([tempStr isEqualToString:@"1"]) {
		return YES;
	}
	return NO;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        if (_scrollView == nil) {
            _scrollView = [[UIScrollView alloc]initWithFrame:frame];
            [_scrollView setDelegate:self];
            [self addSubview:_scrollView];
            _scrollView.scrollEnabled = YES;
            _scrollView.pagingEnabled = YES;
            _scrollView.showsHorizontalScrollIndicator=NO; //水平滚动条隐藏
            _scrollView.showsVerticalScrollIndicator=NO;//垂直滚动条隐藏
        }
        
        [_scrollView setContentSize:CGSizeMake(frame.size.width*ImageCount,frame.size.height)];
        
        for (int i=0; i<ImageCount; i++) {
            UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height)];
             if (frame.size.height > 480)
             {
                 imgView.image = [UIImage imageNamed: [NSString stringWithFormat:@"ImageArray0%d.png",i+1]];
             }
             else {
                 imgView.image = [UIImage imageNamed: [NSString stringWithFormat:@"ImageArray%d.png",i+1]];
             }
            
            [_scrollView addSubview:imgView];       
            [imgView release];
            if (i == ImageCount -1) {
                if (frame.size.height > 480)
                {
                    [_scrollView addSubview: [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"beginRegist.png"] frame:CGRectMake(frame.size.width*i+(frame.size.width - 145*2)/3, frame.size.height - 65 + (65-38)/2, 145, 38) font:nil color:nil target:self action:@selector(showRegist:)]];
                    [_scrollView addSubview: [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"beginShowMain.png"] frame:CGRectMake(frame.size.width*i+(frame.size.width - 145*2)/3*2+145, frame.size.height - 65 + (65-38)/2, 145, 38) font:nil color:nil target:self action:@selector(showMain:)]];
                }
                else {
                    [_scrollView addSubview: [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"beginRegist.png"] frame:CGRectMake(frame.size.width*i+(frame.size.width - 145*2)/3, frame.size.height - 57 + (57-38)/2, 145, 38) font:nil color:nil target:self action:@selector(showRegist:)]];
                    [_scrollView addSubview: [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"beginShowMain.png"] frame:CGRectMake(frame.size.width*i+(frame.size.width - 145*2)/3*2+145, frame.size.height - 57 + (57-38)/2, 145, 38) font:nil color:nil target:self action:@selector(showMain:)]];
                }
            }
        }
        pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 50, frame.size.width, 50)];
        pageC.numberOfPages = ImageCount;
        [self addSubview:pageC];
        [pageC release];
    }
    return self;
}
-(void) showRegist:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",MyVersionCode]  forKey:FIRSTINALERT_ThreeDemain];
	//是否显示评分 崔立东 2013年3月5日添加
	NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:FIRSTINALERT_ThreeDemain];
	if([tempStr intValue] == MyVersionCode){
		[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:keyShowGrade];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
    if (self.delegate && [self.delegate respondsToSelector:@selector(showRegister)]) {
        [self.delegate performSelector:@selector(showRegister)];
    }
}
-(void) showMain:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",MyVersionCode]  forKey:FIRSTINALERT_ThreeDemain];
    //是否显示评分 崔立东 2013年3月5日添加
	NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:FIRSTINALERT_ThreeDemain];
	if([tempStr intValue] == MyVersionCode){
		[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:keyShowGrade];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewFinished)]) {
        [self.delegate performSelector:@selector(scrollViewFinished)];
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if ([scrollView isKindOfClass:[UITableView class]]) {
		return;
	}
    int index = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 4) / scrollView.frame.size.width) + 1;
	currentPageIndex = index;
    pageC.currentPage = currentPageIndex;    
	if (currentPageIndex >= ImageCount-1 ) {
        pageC.hidden = YES;
    }
    else {
        pageC.hidden = NO;
    }
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

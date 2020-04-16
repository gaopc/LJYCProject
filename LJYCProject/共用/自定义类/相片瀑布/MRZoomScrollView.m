//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface MRZoomScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRZoomScrollView

@synthesize imageView;
@synthesize _selfImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        
//        [self initImageView];
    }
    return self;
}

- (void)showView:(UIImage *)reImage
{
    imageView = [[UIImageView alloc]init];
    
    // The imageView can be zoomed largest size
    imageView.frame = [self returnImageFrame:reImage withWidth:MRScreenWidth withHeight:MRScreenHeight];
    imageView.image = reImage;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    [imageView release];
    
    // Add gesture,double tap zoom imageView.
//    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                action:@selector(handleDoubleTap:)];
//    [doubleTapGesture setNumberOfTapsRequired:2];
//    [imageView addGestureRecognizer:doubleTapGesture];
//    
//    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                       action:@selector(handleSingleTap:)];
//    [singleTapGesture setNumberOfTapsRequired:1];
//    [imageView addGestureRecognizer:singleTapGesture];
//    
//    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
//    [doubleTapGesture release];
//    [singleTapGesture release];
    
    float minimumScale = 0.4;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
}


#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    float newScale = self.zoomScale * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
    [self zoomToRect:zoomRect animated:YES];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gesture
{
    NSLog(@"单击");
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    if (isHeight) {
//        if (view.frame.size.width < MRScreenWidth) {
            CGRect scrFrame = view.frame;
            scrFrame.origin.x = (MRScreenWidth - view.frame.size.width)/2 < 0 ? 0 : (MRScreenWidth - view.frame.size.width)/2;
            view.frame = scrFrame;
//        }
    }
    else {
//        if (view.frame.size.height < MRScreenHeight) {
            CGRect scrFrame = view.frame;
            scrFrame.origin.y = (MRScreenHeight - view.frame.size.height)/2 < 0 ? 0 : (MRScreenHeight - view.frame.size.height)/2;
            view.frame = scrFrame;
//        }
    }

    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark - View cycle
- (void)dealloc
{
    self._selfImage = nil;
    [super dealloc];
}

- (CGRect)returnImageFrame:(UIImage *)image withWidth:(int)viewWidth withHeight:(int)viewHeight
{
    int width = 0;
	int height = 0;
    
    isHeight = NO;
	width = viewWidth;
    height =  viewWidth * image.size.height / image.size.width;
    
    if (height > viewHeight) {
        isHeight = YES;
        height = viewHeight;
        width = viewHeight * image.size.width / image.size.height;
    }
	
	int imageQidianX = (viewWidth - width) / 2;
	int imageQidianY = (viewHeight - height) / 2;
    
    CGRect imgFrame;
    imgFrame.size.width = width*2.5;
    imgFrame.size.height = height*2.5;
    imgFrame.origin.x = imageQidianX;
    imgFrame.origin.y = imageQidianY;
    
    return imgFrame;
}
@end

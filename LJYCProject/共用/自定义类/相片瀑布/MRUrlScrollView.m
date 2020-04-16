//
//  MRUrlScrollView.m
//  LJYCProject
//
//  Created by gaopengcheng on 14-11-18.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "MRUrlScrollView.h"

//#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
//#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface MRUrlScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRUrlScrollView
@synthesize bigImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.frame = frame;
    }
    return self;
}

- (void)showView:(NSString *)imageUrl
{
    CGRect imgFrame;
    imgFrame.size.width = 800;
    imgFrame.size.height = 450;
    imgFrame.origin.x = 0;
    imgFrame.origin.y = 84;
    
    self.bigImageView = [[[AsyncImageView alloc]initWithFrame:imgFrame] autorelease];
    self.bigImageView.userInteractionEnabled = YES;
    self.bigImageView._delegate = self;
    self.bigImageView.defaultImage = 1;
    [self.bigImageView setUrlString:imageUrl];
    
    [self addSubview:self.bigImageView];
    
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
    return self.bigImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    if (isHeight) {
        CGRect scrFrame = view.frame;
        scrFrame.origin.x = (self.frame.size.width - view.frame.size.width)/2 < 0 ? 0 : (self.frame.size.width - view.frame.size.width)/2;
        view.frame = scrFrame;
    }
    else {
        CGRect scrFrame = view.frame;
        scrFrame.origin.y = (self.frame.size.height - view.frame.size.height)/2 < 0 ? 0 : (self.frame.size.height - view.frame.size.height)/2;
        view.frame = scrFrame;
    }
    
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark - View cycle
- (void)dealloc
{
    self.bigImageView = nil;
    [super dealloc];
}

- (CGRect)returnImageFrame:(UIImage *)image withWidth:(int)viewWidth withHeight:(int)viewHeight withType:(BOOL)type
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
    if (type) {
        imgFrame.size.width = width;
        imgFrame.size.height = height;
    }
    else {
        imgFrame.size.width = width*2.5;
        imgFrame.size.height = height*2.5;
    }
    imgFrame.origin.x = imageQidianX;
    imgFrame.origin.y = imageQidianY;
    
    NSLog(@"%f,%f", imgFrame.size.width, imgFrame.size.height);
    
    return imgFrame;
}

- (void)changeImageFrame:(UIImage *)sender :(NSString *)temp
{
    [self performSelector:@selector(changeImageFr:) withObject:sender afterDelay:0.2];
}

- (void)changeImageFr:(UIImage *)image
{
    self.bigImageView.frame = [self returnImageFrame:image withWidth:self.frame.size.width withHeight:self.frame.size.height withType:YES];
}
@end

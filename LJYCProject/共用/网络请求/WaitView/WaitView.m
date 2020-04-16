//
//  WaitView.m
//  TestProject
//
//  Created by  on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WaitView.h"

@implementation LoadingView
@synthesize _cancelButton, _titleLab;
@synthesize imageIndex;
@synthesize loadImgView;
@synthesize timer;
- (void)dealloc
{
    self._cancelButton = nil;
    self._titleLab = nil;
    self.loadImgView = nil;
    self.timer = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, 297, 120) image:[UIImage imageNamed:@"loading背景.png"]]];
        
        self._titleLab = [UISubLabel labelWithTitle:@"请稍等，正在为您加载..." frame:CGRectMake(90, 0, 170, 120) font:FontSize30 color:FontColor333333 alignment:UITextAlignmentLeft ];
       
        self._cancelButton =  [UIButton customButtonTitle:nil tag:0 image:[UIImage imageNamed:@"loading关闭.png"] frame:CGRectMake(250, 7, 30, 30) target:nil action:nil];
        self._cancelButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        
        loadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 30, 52, 52)];
        loadImgView.image = [UIImage imageNamed:@"载入0.png"];
        imageIndex = 1;
        //        NSMutableArray *imgArray = [NSMutableArray array];
        //        for (int i = 0; i < 10; i ++) {
        //            [imgArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"载入%d.png", i]]];
        //        }
        //        loadImgView.animationImages = imgArray;
        //        [loadImgView setImage:[UIImage imageNamed:@"载入9.png"]];
        //
        //        loadImgView.animationDuration=3.0;
        //        loadImgView.animationRepeatCount=10;
        //        [loadImgView startAnimating];
        
        [self addSubview:loadImgView];
        [self addSubview:self._cancelButton];
        [self addSubview:self._titleLab];
        [loadImgView release];
        self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(replaceImage) userInfo:nil repeats:YES];
    }
    return self;
    
}
-(void)temp
{
    loadImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"载入%d.png", imageIndex++]];
    if (imageIndex == 60) {
        imageIndex = 0;
    }
}
-(void) replaceImage
{
    [self performSelectorInBackground:@selector(temp) withObject:nil];
}
@end


@implementation WaitView
@synthesize delegate,loadingView;
-(void)dealloc
{
    self.loadingView = nil;
    [super dealloc];
}
+(WaitView *)shareWaitView
{
    static WaitView * instance = nil;
    if (instance == nil) {
        instance = [[WaitView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    }
    return instance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView * imageV = [UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"loading蒙版.png"]];
        [self addSubview:imageV];
        
        loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(11, (frame.size.height - 44 - 120)/2, 297, 120)];
        [loadingView._cancelButton addTarget:[self class] action:@selector(cancelConnection) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loadingView];
        [loadingView release];
        self.loadingView = loadingView;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+(void)cancelConnection
{
    if ([WaitView shareWaitView].delegate && [[WaitView shareWaitView].delegate respondsToSelector:@selector(cancelRequst)]) {
        [[WaitView shareWaitView].delegate performSelector:@selector(cancelRequst)];
    }
}
+(void)showWaitView
{
    if (![[WaitView shareWaitView].loadingView.timer isValid]) {
        [WaitView shareWaitView].loadingView.timer =  [NSTimer scheduledTimerWithTimeInterval:0.01 target:[WaitView shareWaitView].loadingView selector:@selector(replaceImage) userInfo:nil repeats:YES];
    }
    [WaitView shareWaitView].loadingView.imageIndex = 0;
    [WaitView shareWaitView].loadingView.loadImgView.image = [UIImage imageNamed:@"载入0.png"];
    [WaitView shareWaitView].hidden = NO;
    [[[(AppDelegate *)[UIApplication sharedApplication] delegate] window] addSubview:[WaitView shareWaitView]];
}
+(void)hiddenWaitView
{
    [WaitView shareWaitView].hidden = YES;
    if ([[WaitView shareWaitView].loadingView.timer isValid]) {
        [[WaitView shareWaitView].loadingView.timer invalidate];
        [WaitView shareWaitView].loadingView.timer = nil;
    }
    [[WaitView shareWaitView] removeFromSuperview];
}

+ (void)hiddenLoadingButton:(BOOL)state
{
    [WaitView shareWaitView].loadingView._cancelButton.hidden = state;
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

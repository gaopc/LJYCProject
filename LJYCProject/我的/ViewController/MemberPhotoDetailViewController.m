    //
//  MemberPhotoDetailViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MemberPhotoDetailViewController.h"
#import "AppDelegate.h"
#import "MemberPhotoEditViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

#define kDetail_ClickImageWidth 320
#define kDetail_ClickImageHeight ViewHeight - 44 - 5 - 62


@interface MemberPhotoDetailViewController ()

@end

@implementation MemberPhotoDetailViewController
@synthesize _detailData, _isMember;
@synthesize library;
@synthesize _delegate;
@synthesize _picArray, _picIndex;

- (void)dealloc
{
    self._detailData = nil;
    [library release];
    self.library = nil;
    self._delegate = nil;
    self._picArray = nil;
    self._picIndex = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"照片详情";
    self.library = [[ALAssetsLibrary alloc] init];
    
    UIImageView *backgroundView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 320, ViewHeight)];
    backgroundView.backgroundColor = [UIColor blackColor];
    [self.view_IOS7 addSubview:backgroundView];
    
    if (self._isMember) {
        UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(editPhoto) title:@"编辑"];
        UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
        self.navigationItem.rightBarButtonItem = rightBar;
        [rightBar release];
    }
    else {
        
        UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(savePhoto) title:@"保存"];
        UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
        self.navigationItem.rightBarButtonItem = rightBar;
        [rightBar release];
    }
    
    mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, ViewWidth, ViewHeight - 44)];
    mainView.directionalLockEnabled = YES;
    mainView.pagingEnabled = YES;
    mainView.backgroundColor = [UIColor blackColor];
    mainView.showsVerticalScrollIndicator = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.delegate = self;
    
    CGSize newSize = CGSizeMake(ViewWidth * [self._picArray count],  0);
    [mainView setContentSize:newSize];
    
    [mainView setContentOffset:CGPointMake(ViewWidth * [self._picIndex intValue], 0) animated:NO];
    
    [self.view_IOS7 addSubview:mainView];
    [mainView release];
    
    for (int i = 0; i < [self._picArray count]; i ++) {
        
        PicModel *picData = [self._picArray objectAtIndex:i];
        
        MRUrlScrollView *zoomScrollView = [[MRUrlScrollView alloc] initWithFrame:CGRectMake(0 + i * ViewWidth, 0, kDetail_ClickImageWidth, kDetail_ClickImageHeight)];
        zoomScrollView.tag = 1000 + i;
        [zoomScrollView showView:picData._largeUrl];
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:zoomScrollView
                                                                                           action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [zoomScrollView addGestureRecognizer:doubleTapGesture];
        [doubleTapGesture release];
        
        UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0 + i * ViewWidth, ViewHeight - 44 - 5 - 62, 320, 30)];
        UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0 + i * ViewWidth, ViewHeight - 44 - 5 - 30, 320, 30)];
        backView1.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        backView2.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        
        long long dataLong = [picData._uploadTime longLongValue];
        double dateDou = dataLong/1000;
        NSDate* date = [NSDate dateWithTimeIntervalSince1970: dateDou];
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString* str = [formatter stringFromDate:date];
        
        UISubLabel *picNamelab = [UISubLabel labelWithTitle:picData._imgName frame:CGRectMake(10, 0, 160, 30) font:FontSize22 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        UISubLabel *updatePhotolab = [UISubLabel labelWithTitle:str frame:CGRectMake(150, 0, 160, 30) font:FontSize20 color:FontColorFFFFFF alignment:NSTextAlignmentRight];
        UISubLabel *userNamelab = [UISubLabel labelWithTitle:picData._uploader frame:CGRectMake(10, 0, 160, 30) font:FontSize22 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        if (self._isMember) {
            userNamelab.text = [NSString stringWithFormat:@"@%@", picData._shopName];
        }
        [backView1 addSubview:picNamelab];
        [backView1 addSubview:updatePhotolab];
        [backView2 addSubview:userNamelab];
        
        [mainView addSubview:zoomScrollView];
        [mainView addSubview:backView1];
        [mainView addSubview:backView2];
        
        [zoomScrollView release];
        [backView1 release];
        [backView2 release];
    }
}

- (CGRect)returnImageFrame:(UIImage *)image withWidth:(int)viewWidth withHeight:(int)viewHeight
{
    int width = 0;
	int height = 0;
	if (image.size.width > viewWidth)
	{
		width = viewWidth;
		height =  viewWidth * image.size.height / image.size.width;
		
		if (height > viewHeight) {
			height = viewHeight;
			width = viewHeight * image.size.width / image.size.height;
		}
		
	}else if (image.size.height > viewHeight) {
		height = viewHeight;
		width = viewHeight * image.size.width / image.size.height;
	}
	else
	{
		width = image.size.width;
		height = image.size.height;
	}
	
	int imageQidianX = (viewWidth - width) / 2;
	int imageQidianY = (viewHeight - height) / 2;
    
    CGRect imgFrame;
    imgFrame.size.width = width;
    imgFrame.size.height = height;
    imgFrame.origin.x = imageQidianX;
    imgFrame.origin.y = imageQidianY;
    
    return imgFrame;
}

- (void)clickImage:(UIButton *)sender
{
    if (!myImage) {
        return;
    }
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    fullView = [[UIView alloc] initWithFrame:CGRectMake(0, -600, ViewWidth, ViewHeight)];
    fullView.backgroundColor = [UIColor blackColor];
    
    MRZoomScrollView *zoomScrollView = [[MRZoomScrollView alloc] initWithFrame:CGRectMake(0, 20, ViewWidth, ViewHeight)];
    zoomScrollView.imageView.image = myImage;
    [zoomScrollView showView:myImage];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:zoomScrollView
                                                                                       action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [fullView addGestureRecognizer:doubleTapGesture];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(closeImage)];
    [singleTapGesture setNumberOfTapsRequired:1];
    [fullView addGestureRecognizer:singleTapGesture];
    
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [doubleTapGesture release];
    [singleTapGesture release];
    
    
    [fullView addSubview:zoomScrollView];
    [zoomScrollView release];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    fullView.frame = CGRectMake(0, 20, ViewWidth, ViewHeight);
    [app.window addSubview:fullView];
    [UIView commitAnimations];
    
    [fullView release];
}

- (void)closeImage
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    fullView.frame = CGRectMake(0, -600, ViewWidth, ViewHeight);
    [UIView setAnimationDidStopSelector:@selector(closeView)];
    [UIView setAnimationDidStopSelector:@selector(closeView)];
    [UIView commitAnimations];
}

- (void)closeView
{
    [fullView removeFromSuperview];
}

- (void)editPhoto
{
    int pageIndex = mainView.contentOffset.x/ViewWidth;
    MRUrlScrollView *urlScrollView = (MRUrlScrollView *)[mainView viewWithTag:(1000 + pageIndex)];
    
    if (!urlScrollView.bigImageView.isImage) {
        return;
    }
    else {
        myImage = urlScrollView.bigImageView.image;
    }
    MemberPhotoEditViewController *editVC = [[MemberPhotoEditViewController alloc] init];
    editVC._delegate = self._delegate;
    editVC._editImage = myImage;
    editVC._picData = [self._picArray objectAtIndex:pageIndex];
    [self.navigationController pushViewController:editVC animated:YES];
    [editVC release];
}

- (void)savePhoto
{
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    fullView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight + 30)];
    fullView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [app.window addSubview:fullView];
    [fullView release];
    
    int pageIndex = mainView.contentOffset.x/ViewWidth;
    MRUrlScrollView *urlScrollView = (MRUrlScrollView *)[mainView viewWithTag:(1000 + pageIndex)];
    
    
    if (!urlScrollView.bigImageView.isImage) {
        [fullView removeFromSuperview];
        return;
    }
    else {
        myImage = urlScrollView.bigImageView.image;
    }
    
    [self.library saveImage:myImage toAlbum:@"辣郊游" withCompletionBlock:^(NSError *error) {
        if (error!=nil) {
            [fullView removeFromSuperview];
            NSLog(@"保存图片失败: %@", [error description]);
        }
        else {
            [fullView removeFromSuperview];
            [self saveImage];
        }
    }];
}

- (void)saveImage {
    
    [UIAlertView alertViewWithMessage:@"保存成功！"];
}

- (void)changeImageFrame:(UIImage *)sender :(NSString *)temp
{
    bigImageView.frame = [self returnImageFrame:sender withWidth:kDetail_ClickImageWidth withHeight:kDetail_ClickImageHeight];
    if ([temp boolValue]) {
        myImage = sender;
    }
    else {
        myImage = nil;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"停止");
    
}
@end

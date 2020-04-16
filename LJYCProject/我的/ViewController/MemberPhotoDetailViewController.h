//
//  MemberPhotoDetailViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"
#import "MRUrlScrollView.h"
#import "PicModel.h"
#import "AsyncImageView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MemberPhotoDetailViewController : RootViewController <UIScrollViewDelegate>
{
    NSString *userName;
    NSString *updateDate;
    NSString *shopName;
//    MRZoomScrollView  *_zoomScrollView;
    UIView *fullView;
    AsyncImageView *bigImageView;
    UIImage *myImage;
    UIScrollView *mainView;
}
@property (nonatomic, retain) NSArray *_picArray;
@property (nonatomic, retain) NSString *_picIndex;
@property (nonatomic ,retain) PicModel *_detailData;
@property (nonatomic, assign) BOOL _isMember;
@property (strong, atomic) ALAssetsLibrary * library;
@property (nonatomic, assign) id _delegate;
@end

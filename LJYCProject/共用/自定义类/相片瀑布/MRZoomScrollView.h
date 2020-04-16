//
//  MRZoomScrollView.h
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MRZoomScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
    BOOL isHeight;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage *_selfImage;
- (void)showView:(UIImage *)reImage;
@end

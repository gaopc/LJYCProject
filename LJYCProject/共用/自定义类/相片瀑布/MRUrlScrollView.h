//
//  MRUrlScrollView.h
//  LJYCProject
//
//  Created by gaopengcheng on 14-11-18.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MRUrlScrollView : UIScrollView <UIScrollViewDelegate>
{
//    AsyncImageView *bigImageView;
    BOOL isHeight;
}
@property (atomic, retain) AsyncImageView *bigImageView;

- (void)showView:(NSString *)imageUrl;
@end

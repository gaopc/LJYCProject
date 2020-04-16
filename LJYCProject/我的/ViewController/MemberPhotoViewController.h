//
//  MemberPhotoViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLWaterFlowView.h"

@interface MemberPhotoViewController : RootViewController <LLWaterFlowViewDelegate, UIScrollViewDelegate>
{
    UIButton *but1;
    UIButton *but2;
    UIButton *but3;
    UIButton *but4;
    
    LLWaterFlowView *flowView1;
    LLWaterFlowView *flowView2;
    LLWaterFlowView *flowView3;
    LLWaterFlowView *flowView4;
    
    NSArray *imgArr;
}

@end

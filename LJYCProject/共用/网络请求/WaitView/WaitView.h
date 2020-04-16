//
//  WaitView.h
//  TestProject
//
//  Created by  on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于显示等待页面 */
#import <UIKit/UIKit.h>
@interface LoadingView : UIView

@property (nonatomic, retain) UISubLabel *_titleLab;
@property (nonatomic, retain) UIButton *_cancelButton;
@property (nonatomic, assign)NSInteger imageIndex;
@property (nonatomic, retain) UIImageView *loadImgView;
@property (nonatomic, retain) NSTimer * timer;

@end

@protocol WaitViewDelegate;

@interface WaitView : UIView
{
    UIActivityIndicatorView * activityIV;
    UIView * aView;
    
}
@property(nonatomic,assign) id <WaitViewDelegate> delegate;
@property(nonatomic,retain) LoadingView *loadingView;
+(WaitView *)shareWaitView;
+(void)showWaitView;
+(void)hiddenWaitView;
+(void)cancelConnection;
+ (void)hiddenLoadingButton:(BOOL)state;
@end

@protocol WaitViewDelegate <NSObject>
-(void)cancelRequst;
@end
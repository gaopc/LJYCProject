//
//  ZXT_NavigationController.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXT_NavigationController : UINavigationController
//** 打开后将可以滑动返回, Defalt is NO. */
@property (nonatomic,assign) BOOL canDragBack;
@property (nonatomic,assign) BOOL isMoving;

-(void) setBarTitleTextColor:(UIColor *)color shadowColor:(UIColor *)shadowColor;

-(void) setBarBackgroundImage:(UIImage *)image;
@end

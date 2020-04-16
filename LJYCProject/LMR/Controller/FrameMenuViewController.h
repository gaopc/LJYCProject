//
//  FrameMenuViewController.h
//  Traffic
//
//  Created by zhangtie on 13-5-14.
//  Copyright (c) 2013年 zhangtie. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FrameMenuControllerLeftControllerDidShowNotification       @"FrameMenuControllerLeftControllerDidShowNotification"
#define FrameMenuControllerRightControllerDidShowNotification      @"FrameMenuControllerRightControllerDidShowNotification"
#define kMenuFullWidth 320.0f
#define kMenuDisplayedWidth 260

#define IMGFROMBUNDLE( X )	 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"" ]]
#define IMGNAMED( X )	     [UIImage imageNamed:X]

typedef enum
{
    FrameMenuPanDirectionLeft = 0,
    FrameMenuPanDirectionRight,
} FrameMenuPanDirectionE;

typedef enum
{
    FrameMenuPanCompletionLeft = 0,
    FrameMenuPanCompletionRight,
    FrameMenuPanCompletionRoot,
} FrameMenuPanCompletionE;

@class FrameMenuViewController;

@protocol FrameMenuControllerDelegate <NSObject>
@optional
- (void)menuController:(FrameMenuViewController*)menuController willShowViewController:(UIViewController*)controller;

@end

@interface FrameMenuViewController : UIViewController<UIGestureRecognizerDelegate>
{
    CGFloat _panOriginX;
    CGPoint _panVelocity;
    
    FrameMenuPanDirectionE _panDirection;
    
    struct {
        unsigned int respondsToWillShowViewController:1;
        unsigned int showingLeftView:1;
        unsigned int showingRightView:1;
        unsigned int canShowRight:1;
        unsigned int canShowLeft:1;
    } _menuFlags;
}

@property(nonatomic, assign) id <FrameMenuControllerDelegate> delegate;
@property(nonatomic, retain) UIViewController *leftViewController;
@property(nonatomic, retain) UIViewController *rightViewController;
@property(nonatomic, retain) UIViewController *rootViewController;
@property(nonatomic, retain) NSMutableArray * viewControllers;
@property(nonatomic, retain) NSMutableArray * rootNavControllers;

- (id)initWithRootViewController:(UIViewController*)controller;

- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated; // used to push a new controller on the stack
- (void)showRootController:(BOOL)animated; // reset to "home" view controller
- (void)showRightController:(BOOL)animated;  // show right
- (void)showLeftController:(BOOL)animated;  // show left

@end

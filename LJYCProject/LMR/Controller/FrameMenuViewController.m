//
//  FrameMenuViewController.m
//  Traffic
//
//  Created by zhangtie on 13-5-14.
//  Copyright (c) 2013年 zhangtie. All rights reserved.
//

#import "FrameMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kMenuOverlayWidth (self.view.bounds.size.width - kMenuDisplayedWidth)
#define kMenuBounceOffset 10.0f
#define kMenuBounceDuration .3f
#define kMenuSlideDuration .3f
#define kMenuDeltaX    10.0f

@interface FrameMenuViewController ()

@property (nonatomic, retain)     UITapGestureRecognizer  *tapGesture;
@property (nonatomic, retain)     UIPanGestureRecognizer  *panGesture;
@property (nonatomic, retain)     UIButton     *leftButton;
@property (nonatomic, retain)     UIButton     *rightButton;


- (void)resetNavButtons;
@end

@implementation FrameMenuViewController
@synthesize rootViewController = _rootViewController;
@synthesize tapGesture = _tapGesture;
@synthesize panGesture = _panGesture;
@synthesize delegate = _delegate;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize viewControllers,rootNavControllers;
- (void)dealloc
{
    _delegate = nil;
    [_leftViewController release], _leftViewController = nil;
    [_rightViewController release], _rightViewController = nil;
    [_rootViewController release], _rootViewController = nil;
    [_tapGesture release], _tapGesture = nil;
    [_leftButton release], _leftButton = nil;
    [_rightButton release], _rightButton = nil;
    self.viewControllers = nil;
    self.rootNavControllers = nil;
    [super dealloc];
}

- (id)initWithRootViewController:(UIViewController*)controller {
    if ((self = [super init])) {
        self.rootViewController = controller;
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
    self.viewControllers = [NSMutableArray array];
    self.rootNavControllers = [NSMutableArray array];
    [self.view addGestureRecognizer:self.tapGesture];
}


- (void)resetNavButtons
{
//    if (!_rootViewController) return;
//    
//    UIViewController *topController = nil;
//    if ([_rootViewController isKindOfClass:[UINavigationController class]])
//    {
//        
//        UINavigationController *navController = (UINavigationController*)_rootViewController;
//        if ([[navController viewControllers] count] > 0)
//        {
//            topController = [[navController viewControllers] objectAtIndex:0];
//        }
//        
//    }
//    else if ([_rootViewController isKindOfClass:[UITabBarController class]])
//    {
//        
//        UITabBarController *tabController = (UITabBarController*)_rootViewController;
//        
//        UINavigationController *navController = (UINavigationController*)[tabController selectedViewController];
//        if ([[navController viewControllers] count] > 0)
//        {
//            topController = [[navController viewControllers] objectAtIndex:0];
//        }
//    }
//    else
//    {
//        topController = _rootViewController;
//    }
//    
//    if (_menuFlags.canShowLeft)
//    {
//        UIImage  *img = IMGNAMED(@"侧栏1");
//        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.leftButton.exclusiveTouch = YES;
//        self.leftButton.frame = CGRectMake(0, 0, 25, 23);
//        [self.leftButton setImage:img forState:UIControlStateNormal];
//        [self.leftButton setImage:IMGNAMED(@"侧栏2") forState:UIControlStateHighlighted];
//        [self.leftButton addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
//        topController.navigationItem.leftBarButtonItem = leftItem;
//        [leftItem release];
//    }
//    else
//    {
//        topController.navigationItem.leftBarButtonItem = nil;
//    }
//    
//    if (_menuFlags.canShowRight)
//    {
//        UIImage  *img = IMGNAMED(@"侧栏1");
//        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.rightButton.frame = CGRectMake(0, 0, 25, 23);
//        [self.rightButton setExclusiveTouch:YES];
//        [self.rightButton setImage:img forState:UIControlStateNormal];
//        [self.rightButton setImage:IMGNAMED(@"侧栏2") forState:UIControlStateHighlighted];
//        [self.rightButton addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
//        topController.navigationItem.rightBarButtonItem = leftItem;
//        [leftItem release];
//        
//    }
//    else
//    {
//        topController.navigationItem.rightBarButtonItem = nil;
//    }
}

- (BOOL)panGestureRecognized
{
    if ([_rootViewController isKindOfClass:[UINavigationController class]])
    {
        
        UINavigationController *navController = (UINavigationController*)_rootViewController;
        return [[navController viewControllers] count]<2;
        
    }
    else if ([_rootViewController isKindOfClass:[UITabBarController class]])
    {
        
        UITabBarController *tabController = (UITabBarController*)_rootViewController;
        
        UINavigationController *navController = (UINavigationController*)[tabController selectedViewController];
        return [[navController viewControllers] count]<2;
        
    }
    else
    {
        return [[_rootViewController.navigationController viewControllers] count]<2;
        
    }
    return NO;
}

- (void)showShadow:(BOOL)val
{
    if (!_rootViewController) return;
    
    _rootViewController.view.layer.shadowOpacity = val ? 0.8f : 0.0f;
    if (val) {
        _rootViewController.view.layer.cornerRadius = 4.0f;
        _rootViewController.view.layer.shadowOffset = CGSizeZero;
        _rootViewController.view.layer.shadowRadius = 4.0f;
        _rootViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
}

- (void)setSubViewUserInteractionEnabled:(BOOL)enabled
{
    [_rootViewController.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        view.userInteractionEnabled = enabled;
    }];
}

- (void)showRootController:(BOOL)animated
{
    [self.tapGesture setEnabled:NO];
    [_rootViewController.view endEditing:YES];
    _rootViewController.view.userInteractionEnabled = YES;
    [self setSubViewUserInteractionEnabled:YES];
    
    CGRect frame = _rootViewController.view.frame;
    frame.origin.x = 0.0f;
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
    _leftViewController.view.userInteractionEnabled = NO;
    _rightViewController.view.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:.3
                     animations:^{
                         _rootViewController.view.frame = frame;
                         
                     } completion:^(BOOL finished) {
                         
                         if (_leftViewController && _leftViewController.view.superview) {
                             [_leftViewController.view removeFromSuperview];
                             _leftViewController.view.userInteractionEnabled = YES;
                         }
                         
                         if (_rightViewController && _rightViewController.view.superview) {
                             [_rightViewController.view removeFromSuperview];
                             _rightViewController.view.userInteractionEnabled = YES;
                         }
                         
                         _menuFlags.showingLeftView = NO;
                         _menuFlags.showingRightView = NO;
                         
                         [self showShadow:NO];
                         self.leftButton.selected = NO;
                     }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
    
}

- (void)showLeftController:(BOOL)animated
{
    if (!_menuFlags.canShowLeft) return;
    
    if (_rightViewController && _rightViewController.view.superview)
    {
        [_rightViewController.view removeFromSuperview];
        _menuFlags.showingRightView = NO;
    }
    
    if (_menuFlags.respondsToWillShowViewController)
    {
        [self.delegate menuController:self willShowViewController:self.leftViewController];
    }
    _menuFlags.showingLeftView = YES;
    [self showShadow:YES];
    
    UIView *view = self.leftViewController.view;
	CGRect frame = self.view.bounds;
	frame.size.width = kMenuFullWidth;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    
    frame = _rootViewController.view.frame;
    frame.origin.x = CGRectGetMaxX(view.frame) - (kMenuFullWidth - kMenuDisplayedWidth);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated)
    {
        [UIView setAnimationsEnabled:NO];
    }
    
    [self setSubViewUserInteractionEnabled:NO];
    [UIView animateWithDuration:.3 animations:^{
        _rootViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.tapGesture setEnabled:YES];
    }];
    
    if (!animated)
    {
        [UIView setAnimationsEnabled:_enabled];
    }
    
}

- (void)showRightController:(BOOL)animated
{
    if (!_menuFlags.canShowRight) return;
    
    if (_leftViewController && _leftViewController.view.superview)
    {
        [_leftViewController.view removeFromSuperview];
        _menuFlags.showingLeftView = NO;
    }
    
    if (_menuFlags.respondsToWillShowViewController)
    {
        [self.delegate menuController:self willShowViewController:self.rightViewController];
    }
    _menuFlags.showingRightView = YES;
    [self showShadow:YES];
    
    UIView *view = self.rightViewController.view;
    CGRect frame = self.view.bounds;
	frame.origin.x += frame.size.width - kMenuFullWidth;
	frame.size.width = kMenuFullWidth;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    
    frame = _rootViewController.view.frame;
    frame.origin.x = -(frame.size.width - kMenuOverlayWidth);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated)
    {
        [UIView setAnimationsEnabled:NO];
    }
    
    [self setSubViewUserInteractionEnabled:NO];
    [UIView animateWithDuration:.3 animations:^{
        _rootViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.tapGesture setEnabled:YES];
    }];
    
    if (!animated)
    {
        [UIView setAnimationsEnabled:_enabled];
    }
}



#pragma mark - GestureRecognizers
- (void)pan:(UIPanGestureRecognizer*)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [_rootViewController.view endEditing:YES];
        [self setSubViewUserInteractionEnabled:NO];
        
        [self showShadow:YES];
        _panOriginX = _rootViewController.view.frame.origin.x;
        _panVelocity = CGPointMake(0.0f, 0.0f);
        
        if([gesture velocityInView:self.view].x > 0)
        {
            _panDirection = FrameMenuPanDirectionRight;
        }
        else
        {
            _panDirection = FrameMenuPanDirectionLeft;
        }
        
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        
        CGPoint velocity = [gesture velocityInView:self.view];
        
        if((velocity.x*_panVelocity.x + velocity.y*_panVelocity.y) < 0)
        {
            _panDirection = (_panDirection == FrameMenuPanDirectionRight) ? FrameMenuPanDirectionLeft : FrameMenuPanDirectionRight;
        }
        
        _panVelocity = velocity;
        CGPoint translation = [gesture translationInView:self.view];
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = _panOriginX + translation.x;
        
        if (frame.origin.x > 0.0f && !_menuFlags.showingLeftView )
        {
            
            if(_menuFlags.showingRightView)
            {
                _menuFlags.showingRightView = NO;
                [_rightViewController.view removeFromSuperview];
            }
            
            //when left view controller is exist
            if (_menuFlags.canShowLeft)
            {
                _menuFlags.showingLeftView = YES;
                CGRect f = self.view.bounds;
				f.size.width = kMenuFullWidth;
                self.leftViewController.view.frame = f;
                [self.view insertSubview:self.leftViewController.view atIndex:0];
            }
            
        }
        else if (frame.origin.x < 0.0f && !_menuFlags.showingRightView)
        {
            
            if(_menuFlags.showingLeftView)
            {
                _menuFlags.showingLeftView = NO;
                [_leftViewController.view removeFromSuperview];
            }
            
            //when right view controller is exist
            if (_menuFlags.canShowRight)
            {
                _menuFlags.showingRightView = YES;
                CGRect f = self.view.bounds;
				f.origin.x += f.size.width - kMenuFullWidth;
				f.size.width = kMenuFullWidth;
                self.rightViewController.view.frame = f;
                [self.view insertSubview:self.rightViewController.view atIndex:0];
            }
            
        }
        
        //越界判断
        if (_leftViewController.view.superview)
        {
            if (frame.origin.x <= 0)
            {
                frame.origin.x = 0;
            }
            else if (frame.origin.x >= kMenuDisplayedWidth)
            {
                frame.origin.x = kMenuDisplayedWidth;
            }
        }
        else if (_rightViewController.view.superview)
        {
            if (frame.origin.x >= 0)
            {
                frame.origin.x = 0;
            }
            else if (frame.origin.x <= -kMenuDisplayedWidth)
            {
                frame.origin.x = -kMenuDisplayedWidth;
            }
        }
        else if (!_leftViewController.view.superview || !_rightViewController.view.superview)
        {
            frame.origin.x = 0;
            
        }
        
        _rootViewController.view.frame = frame;
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded
               ||gesture.state == UIGestureRecognizerStateRecognized
               ||gesture.state == UIGestureRecognizerStateCancelled
               ||gesture.state == UIGestureRecognizerStateFailed)
    {
        
        FrameMenuPanCompletionE completion = FrameMenuPanCompletionRoot; // by default animate back to the root
        
        CGRect frame = _rootViewController.view.frame;
        CGFloat deltaX = frame.origin.x - _panOriginX;
        
        if (_panDirection == FrameMenuPanDirectionRight && _menuFlags.showingLeftView)
        {
            completion = FrameMenuPanCompletionLeft;
            
            if (fabs(deltaX)>kMenuDeltaX)
            {
                frame.origin.x = deltaX>0?kMenuDisplayedWidth:0;
            }
            else
            {
                frame.origin.x = _panOriginX;
            }
            
        }
        else if (_panDirection == FrameMenuPanDirectionLeft && _menuFlags.showingRightView)
        {
            completion = FrameMenuPanCompletionRight;
            if (fabs(deltaX)>kMenuDeltaX)
            {
                frame.origin.x = deltaX<0?-kMenuDisplayedWidth:0;
            }
            else
            {
                frame.origin.x = _panOriginX;
            }
        }
        else
        {
            frame.origin.x = 0;
        }
        _rootViewController.view.frame = frame;
        if (_leftButton) {
            self.leftButton.selected = (_rootViewController.view.frame.origin.x>0);
            [self.tapGesture setEnabled:self.leftButton.selected];
            
        }
        
        if (_rightButton) {
            self.rightButton.selected = (_rootViewController.view.frame.origin.x<0);
            [self.tapGesture setEnabled:self.leftButton.selected];
        }
        
        if (completion == FrameMenuPanCompletionRoot) {
            [self setSubViewUserInteractionEnabled:YES];
        }

//        [UIView animateWithDuration:kMenuSlideDuration
//                              delay:0.0f
//                            options:UIViewAnimationOptionCurveEaseIn
//                         animations:^{
//                             _rootViewController.view.frame = frame;
//                         } completion:^(BOOL finished) {
////                             for (UIView * view in [self.view subviews]) {
////                                 if (view == self.leftViewController.view) {
////                                     [view removeFromSuperview];
////                                 }
////                             }
//                             if (_leftButton) {
//                                 self.leftButton.selected = (_rootViewController.view.frame.origin.x>0);
//                                 [self.tapGesture setEnabled:self.leftButton.selected];
//                                 
//                             }
//                             
//                             if (_rightButton) {
//                                 self.rightButton.selected = (_rootViewController.view.frame.origin.x<0);
//                                 [self.tapGesture setEnabled:self.leftButton.selected];
//                             }
//                             
//                             if (completion == FrameMenuPanCompletionRoot) {
//                                 [self setSubViewUserInteractionEnabled:YES];
//                             }
//                             
//                             
//                         }];
//        
        
    }
    
}

- (void)tap:(UITapGestureRecognizer*)gesture
{
    [gesture setEnabled:NO];
    [self showRootController:YES];
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // Check for horizontal pan gesture
    if (gestureRecognizer == _panGesture)
    {
        return [self panGestureRecognized];
        
    }
    
    if (gestureRecognizer == _tapGesture)
    {
        
        if (_rootViewController && (_menuFlags.showingRightView || _menuFlags.showingLeftView))
        {
            return CGRectContainsPoint(_rootViewController.view.frame, [gestureRecognizer locationInView:self.view]);
        }
        return NO;
    }
    
    return YES;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == _tapGesture)
    {
        return YES;
    }
    return NO;
}

#pragma mark - setter
- (void)setPanGesture:(UIPanGestureRecognizer *)panGesture
{
    if (_panGesture != panGesture)
    {
        [_panGesture release], _panGesture = nil;
        _panGesture = [panGesture retain];
    }
}

- (void)setDelegate:(id<FrameMenuControllerDelegate>)delegate
{
    _delegate = delegate;
    _menuFlags.respondsToWillShowViewController = [(id)self.delegate respondsToSelector:@selector(menuController:willShowViewController:)];
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    if (_rightViewController != rightViewController)
    {
        [_rightViewController release],_rightViewController = nil;
        _rightViewController = [rightViewController retain];
    }
    _menuFlags.canShowRight = (_rightViewController!=nil);
    [self resetNavButtons];
    
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if (_leftViewController != leftViewController)
    {
        [_leftViewController release],_leftViewController = nil;
        _leftViewController = [leftViewController retain];
    }
    _menuFlags.canShowLeft = (_leftViewController!=nil);
    [self resetNavButtons];
    
}


- (void)setRootViewController:(UIViewController *)rootViewController
{
    if (_rootViewController != rootViewController)
    {
        UIViewController  *tempRoot = [_rootViewController retain];
        
        [_rootViewController release],_rootViewController = nil;
        _rootViewController = [rootViewController retain];
        
        if (_rootViewController)
        {
            if (tempRoot)
            {
                [tempRoot.view removeFromSuperview];
                [tempRoot release],tempRoot = nil;
            }
            
            UIView *v = _rootViewController.view;
            v.frame = self.view.bounds;
            [self.view addSubview:v];
            
            [v addGestureRecognizer:self.panGesture];
            
        }
        else
        {
            if (tempRoot)
            {
                [tempRoot.view removeFromSuperview];
                [tempRoot release],tempRoot = nil;
            }
        }
        if ([self.navigationController.viewControllers count]>1) {
            self.navigationController.viewControllers = [NSArray arrayWithObject:[self.navigationController.viewControllers objectAtIndex:0]];
        }
        [self resetNavButtons];
    }
}

- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated
{
    
    if (!controller)
    {
        [self setRootViewController:controller];
        return;
    }
    
    if (_menuFlags.showingLeftView)
    {
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        // slide out then come back with the new root
        __block FrameMenuViewController *selfRef = self;
        __block UIViewController *rootRef = _rootViewController;
        CGRect frame = rootRef.view.frame;
        //        frame.origin.x = rootRef.view.bounds.size.width;
        
        [UIView animateWithDuration:.0 animations:^{
            rootRef.view.frame = frame;
            
        } completion:^(BOOL finished) {
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            [selfRef setRootViewController:controller];
            _rootViewController.view.frame = frame;
            [selfRef showRootController:animated];
            
        }];
        
    }
    else
    {
        
        // just add the root and move to it if it's not center
        [self setRootViewController:controller];
        [self showRootController:animated];
        
    }
    
}

#pragma mark - getter
- (UIPanGestureRecognizer *)panGesture
{
    if (!_panGesture)
    {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.panGesture setMaximumNumberOfTouches:2];
        _panGesture.delegate = self;
        _panGesture.cancelsTouchesInView = NO;
    }
    return _panGesture;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture)
    {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

#pragma mark - Actions
- (void)showLeft:(id)sender
{
    [_rootViewController.view endEditing:YES];
    if (self.leftButton.selected)
    {
        [self showRootController:YES];
        return;
    }
    self.leftButton.selected = YES;
    [self showLeftController:YES];
    
}

- (void)showRight:(id)sender
{
    [_rootViewController.view endEditing:YES];
    if (self.rightButton.selected)
    {
        [self showRootController:YES];
        return;
    }
    
    self.rightButton.selected = YES;
    [self showRightController:YES];
    
}


@end

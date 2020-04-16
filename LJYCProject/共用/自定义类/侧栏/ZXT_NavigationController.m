//
//  ZXT_NavigationController.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ZXT_NavigationController.h"

@interface ZXT_NavigationController ()<UIGestureRecognizerDelegate>
{
    CGPoint startTouch;
    UIImageView *lastScreenShotView;
    UIView * blackMask;
    UIView * top_view;
}
@property (nonatomic,retain) UIView * backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;
@end

@implementation ZXT_NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.screenShotsList = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
        self.canDragBack = NO;
    }
    return self;
}
- (void)dealloc
{
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    [super dealloc];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL)animated];
    
    if (self.screenShotsList.count == 0) {
        
        UIImage * capturedImage = [self capture];
        
        if (capturedImage) {
            [self.screenShotsList addObject:capturedImage];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setBarTitleTextColor:[UIColor colorWithRed:101/255.0 green:104/255.0 blue:107/255.0 alpha:1]
                   shadowColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0]];
    
    [self.navigationBar setNeedsDisplay1];
    
    UIPanGestureRecognizer * recognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(paningGestureReceive:)] autorelease];
    recognizer.delegate = self;
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];

}
-(void) setBarTitleTextColor:(UIColor *)color shadowColor:(UIColor *)shadowColor
{
    NSMutableDictionary * dictText = [NSMutableDictionary dictionaryWithObjectsAndKeys:color,UITextAttributeTextColor,shadowColor,UITextAttributeTextShadowColor,nil];
    [self.navigationBar setTitleTextAttributes:dictText];
}

-(void) setBarBackgroundImage:(UIImage *)image
{
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIImage * capturedImage = [self capture];
    
    if (capturedImage) {
        [self.screenShotsList addObject:capturedImage];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.screenShotsList.count) {
        [self.screenShotsList removeLastObject];
    }
    
    return [super popViewControllerAnimated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)capture
{
    top_view =  [[UIApplication sharedApplication]keyWindow].rootViewController.view;
    UIGraphicsBeginImageContextWithOptions(top_view.bounds.size, top_view.opaque, 0.0);
    [top_view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)moveViewWithX:(float)x
{
    top_view =  [[UIApplication sharedApplication]keyWindow].rootViewController.view;

    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = top_view.frame;
    frame.origin.x = x;
    top_view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.viewControllers.count <= 1 || !self.canDragBack) return NO;
    
    return YES;
}
#pragma mark -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    CGPoint touchPoint = [recoginzer locationInView:((UIView*)[UIApplication sharedApplication].keyWindow)];
    top_view =  [[UIApplication sharedApplication]keyWindow].rootViewController.view;

    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame = top_view.frame;
            
            self.backgroundView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)]autorelease];
            [top_view.superview insertSubview:self.backgroundView belowSubview:top_view];
            
            blackMask = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)]autorelease];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage * lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[[UIImageView alloc] initWithImage:lastScreenShot] autorelease];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = top_view.frame;
                frame.origin.x = 0;
                top_view.frame = frame;
                
                _isMoving = NO;
                self.backgroundView.hidden = YES;
                
            }];
            
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

- (void)setLayer3D:(CALayer *)layer YRotation:(CGFloat)degrees anchorPoint:(CGPoint)point perspectiveCoeficient:(CGFloat)m34
{
	CATransform3D transfrom = CATransform3DIdentity;
	transfrom.m34 = 1.0 / m34;
    CGFloat radiants = degrees / 360.0 * 2 * M_PI;
	transfrom = CATransform3DRotate(transfrom, radiants, 0.0f, 1.0f, 0.0f);
	layer.anchorPoint = point;
	layer.transform = transfrom;
}

@end

//
//  CustomUISwitch.m
//  TestSwitch
//
//  Created by Roy on 11-9-17.
//  Copyright 2011年 Roy. All rights reserved.
//

#import "CustomUISwitch.h"


@interface CustomUISwitch ()
@property (nonatomic ,retain ,readwrite) UIImageView *backgroundImage;
@property (nonatomic ,retain ,readwrite) UIImageView *switchImage;
- (void)setupUserInterface;
- (void)toggle;
- (void)animateSwitch:(BOOL)toOn;
@end

@implementation CustomUISwitch
@synthesize backgroundImage=_backgroundImage;
@synthesize switchImage=_switchImage;
@synthesize delegate=_delegate;
@synthesize on=_on;

- (void)dealloc
{
	[_backgroundImage release];
	[_switchImage release];
	
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
	if (self == [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)]) 
	{
		_on=YES;
		_hitCount=0;
		
		self.backgroundColor=[UIColor clearColor];
		self.clipsToBounds=YES;
		self.autoresizesSubviews=NO;
		self.autoresizingMask=0;
		self.opaque=YES;
		
		[self setupUserInterface];
	}
	return self;
}

- (void)setupUserInterface
{
	UIImageView *bg=[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 56.0f, 22.0f)];
	bg.image=[UIImage imageNamed:@"SwitchA.png"];
	bg.backgroundColor=[UIColor clearColor];
	self.backgroundImage=bg;
	[bg release];
	
	UIImageView *foreground=[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 22.0f)];
	foreground.image=[UIImage imageNamed:@"SwitchB.png"];
	self.switchImage=foreground;
	[foreground release];
	
	
	[self addSubview:self.backgroundImage];
	[self.backgroundImage addSubview:self.switchImage];
	
	[self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];	
	
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
	_on = on;
	NSLog(@"setOn:%d",_on);
	if (!_on) {
		self.switchImage.frame=CGRectMake(0.0f, 0.0f, 30.0f, 22.0f);;
		self.backgroundImage.image=[UIImage imageNamed:@"SwitchA.png"];
	}
	else
	{
		self.switchImage.frame=CGRectMake(27.0f, 0.0f, 30.0f, 22.0f);;
		self.backgroundImage.image=[UIImage imageNamed:@"SwitchA.png"];
	}
}

- (BOOL)isOn
{
	return _on;
}

- (void)buttonPressed:(id)target
{
	if (_hitCount == 0) {
		_hitCount++;
		[self toggle];
	}
	else
	{
		_hitCount++;
		//        _on=!_on;
	}
	
}

- (void)toggle
{
	_on=!_on;
	[self animateSwitch:_on];
}

- (void)animateSwitch:(BOOL)toOn
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	
	self.switchImage.frame=CGRectMake(27.0f, 0.0f, 30.0f, 22.0f);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animateHasFinished:finished:context:)];
	
	if (!toOn) 
	{
		self.switchImage.frame=CGRectMake(0.0f, 0.0f, 30.0f, 22.0f);
		self.backgroundImage.image=[UIImage imageNamed:@"SwitchA.png"];
	}
	else
	{
		self.switchImage.frame=CGRectMake(27.0f, 0.0f, 30.0f, 22.0f);
		self.backgroundImage.image=[UIImage imageNamed:@"SwitchA.png"];
	}
	
	[UIView commitAnimations];
	
	[UIView commitAnimations];
}
- (void)animateHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
	if (_delegate) {
		[_delegate valueChangedInView:self];
	}
	
	if (_hitCount>1) {
		_hitCount--;
		[self toggle];
		
	}
	else
	{
		_hitCount--;
	}
	//NSLog(@"animateHasFinished:%d",_on);
}

@end

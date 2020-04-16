//
//  CustomUISwitch.h
//  TestSwitch
//
//  Created by Roy on 11-9-17.
//  Copyright 2011年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol CustomUISwitchDelegate;

@interface CustomUISwitch : UIControl {
	id<CustomUISwitchDelegate> _delegate;
	BOOL _on;
	
	NSInteger _hitCount;
	UIImageView *_backgroundImage;
	UIImageView *_switchImage;
}
@property (nonatomic ,assign , readwrite) id delegate;
@property (nonatomic ,getter = isOn) BOOL on;

- (id)initWithFrame:(CGRect)frame;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (BOOL)isOn;
@end

@protocol CustomUISwitchDelegate

@optional
- (void)valueChangedInView:(CustomUISwitch *)view;

@end
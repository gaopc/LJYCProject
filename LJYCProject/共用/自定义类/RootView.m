//
//  RootView.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "RootView.h"

@implementation RootView
@synthesize _delegate;
- (void)dealloc
{
    self._delegate = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 色值转换成图片 调取实例
 [UIColor colorWithRed:18/255.0f green:188/255.0f blue:230/255.0f alpha:1.0] 色值
 CGRectMake(0.0f, 0.0f, 300, 30).size 图片位置与尺寸
 UIImage* imgBg = [self imageWithColor:[UIColor colorWithRed:18/255.0f green:188/255.0f blue:230/255.0f alpha:1.0] size:CGRectMake(0.0f, 0.0f, 300, 30).size];
 
 */
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
	
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
	
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, fillRect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

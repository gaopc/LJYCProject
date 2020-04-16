//
//  CoustomButton.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
@interface CoustomButton : NSObject
+(UIButton *) buttonWithBlueArrow : (CGRect) frame target:(id)target action:(SEL)selector ;
+(UIButton *) buttonWithBlueBorder : (CGRect) frame target:(id)target action:(SEL)selector title:(NSString *)title;
+(UIButton *) buttonWithOrangeColor : (CGRect) frame target:(id)target action:(SEL)selector title:(NSString *)title;
@end

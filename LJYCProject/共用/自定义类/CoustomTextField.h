//
//  CoustomTextField.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CoustomTextField : UIView
@property(nonatomic,retain)UISubTextField *textFiled;
+(CoustomTextField *) coustomTextFieldWithFrame:(CGRect)frame leftImage:(UIImage *) image isMustFillIn:(BOOL) isMFI placeholder:(NSString *)placeholder delegate:(id)delegate;
@end

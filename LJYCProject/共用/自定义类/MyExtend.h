//
//  MyExtend.h
//  MyMobileBank
//
//  Created by  on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于生成常用类的类方法，方便调用 */
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface MyExtend : NSObject

@end

@interface UIButton (constructor) 
+(UIButton *)buttonWithType:(UIButtonType)buttonType tag:(NSInteger)tag title:(NSString *)title frame:(CGRect)frame backImage:(UIImage*) image  target:(id)target action:(SEL)action;

+(UIButton *)roundedRectButtonTitle:(NSString *)title tag:(NSInteger)tag frame:(CGRect)frame target:(id)target action:(SEL)action;
+(UIButton *)customButtonTitle:(NSString *)title  tag:(NSInteger)tag image:(UIImage *)image frame:(CGRect)frame target:(id)target action:(SEL)action;
+(UIButton *)buttonWithType:(UIButtonType)buttonType  tag:(NSInteger)tag title:(NSString *)title frame:(CGRect)frame font:(UIFont*) font  color:(UIColor*) color target:(id)target action:(SEL)action;
+(UIButton *)buttonWithType:(UIButtonType)buttonType  tag:(NSInteger)tag title:(NSString *)title backImage:(UIImage *)image frame:(CGRect)frame font:(UIFont*) font  color:(UIColor*) color target:(id)target action:(SEL)action;
+(UIButton *)buttonWithType:(UIButtonType)buttonType  tag:(NSInteger)tag title:(NSString *)title frame:(CGRect)frame font:(UIFont*) font  color:(UIColor*) color colorWithWhite:(CGFloat)white target:(id)target action:(SEL)action;

// 左边图，右边汉字描述 zxt
+(UIButton *) buttonWithTag:(NSInteger)tag image:(UIImage*)image title:(NSString *)title imageEdge:(UIEdgeInsets) imageEdge  frame:(CGRect)frame font:(UIFont*) font  color:(UIColor*) color target:(id)target action:(SEL)action;

+(UIButton *) buttonWithTag:(NSInteger)tag  frame:(CGRect)frame  target:(id)target action:(SEL)action;
@end

@interface UILabel  (constructor)  
+(id)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font alignment:(NSTextAlignment)alignment;
+(id)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font  color:(UIColor *)color alignment:(NSTextAlignment)alignment;
+(id)labelWithframe:(CGRect)frame backgroundColor:(UIColor *)color;

+ (id)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font  color:(UIColor *)color alignment:(NSTextAlignment)alignment autoSize:(BOOL)autosize;
@end

@interface UITextView (constructor)  
+(id) TextViewWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color;
@end

@interface UITextField (constructor)
+(id) TextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment placeholder:(NSString*)placeholder;

+(id) TextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment placeholder:(NSString*)placeholder font:(UIFont *)font;
@end

@interface UIAlertView (constructor)  
+(void)alertViewWithMessage:(NSString *)massage;
+(void)alertViewWithMessage:(NSString *)massage tag:(NSInteger)tag delegate:(id)delegate;
+(void)alertViewWithMessage:(NSString *)massage Title:(NSString *)title;
+(UIAlertView *)alertViewWithMessage:(NSString *)massage addSure:(NSString *)sure addCancle:(NSString *)cancle ;
@end

@interface UIImageView  (constructor) 
+(UIImageView *)ImageViewWithFrame:(CGRect )frame;
+(UIImageView *)ImageViewWithFrame:(CGRect )frame image:(UIImage *)image;
+ (UIImage *)stretchImage:(UIImage *)image
            withCapInsets:(UIEdgeInsets)capInsets
             resizingMode:(UIImageResizingMode)resizingMode;
@end

@interface UINavigationBar (constructor)
-(void)setNeedsDisplay1;
@end

@interface TerminalId : NSObject
+(NSString *)TerminalId;
@end

@interface UIView  (constructorAnimation)
-(void) insertSubview: (UIView  *)view atIndex:(NSInteger)index animated : (BOOL)animated;
-(void) addSubview: (UIView  *)view animated : (BOOL)animated;
-(void) removeFromSuperviewWithAnimated : (BOOL) animated;
@end


@interface UISubLabel : UILabel

@end

@interface UISubTextField : UITextField

@end

@interface UISubTextView : UITextView

@end


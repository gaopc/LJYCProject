//
//  CoustomTextField.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "CoustomTextField.h"

@implementation CoustomTextField
@synthesize textFiled;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

+(CoustomTextField *)coustomTextFieldWithFrame:(CGRect)frame leftImage:(UIImage *)image isMustFillIn:(BOOL)isMFI placeholder:(NSString *)placeholder delegate:(id)delegate
{
    CoustomTextField * view = [[CoustomTextField alloc] initWithFrame:frame];
    UIColor * color =[UIColor colorWithRed:0x33/255.0 green:0xb5/255.0 blue:0xe5/255.0 alpha:1];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 1;//边境宽度
    view.layer.cornerRadius = 3;//圆角半径
    UIView * leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.height, view.bounds.size.height)];
    [view addSubview:leftV];
    [leftV release];
    leftV.backgroundColor = color;
    leftV.layer.borderWidth = view.layer.borderWidth;
    leftV.layer.cornerRadius = view.layer.cornerRadius;
    leftV.layer.borderColor = view.layer.borderColor;
    UIView * tempV = [[UIView alloc] initWithFrame:CGRectMake(leftV.bounds.size.width - view.layer.cornerRadius, 0, view.layer.cornerRadius, leftV.bounds.size.height)];
    [leftV addSubview:tempV];
    [tempV release];
    tempV.backgroundColor = color;
    float x = leftV.bounds.size.width;
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(x/9.0*3, x/9.0*3, x/9.0*3, x/9.0*3)];
    [leftV addSubview:imageV];
    [imageV release];
    imageV.image = image;
    
    if (isMFI) {
        x = x + 10;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake( x , 0, 10, leftV.bounds.size.height)];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        [label release];
        label.text = @"*";
        label.textColor = [UIColor redColor];
    }
    UISubTextField * textF = [[UISubTextField alloc] initWithFrame:CGRectMake(x + 10, (view.bounds.size.height - 25)/2, view.bounds.size.width - x - 10, 25)];
    textF.font = FontSize30;
    textF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    view.textFiled = textF;
    [textF release];
    view.textFiled.delegate = delegate;
    [view addSubview:view.textFiled];
    view.textFiled.clearButtonMode = YES;
    view.textFiled.placeholder = placeholder;

    return [view autorelease];
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

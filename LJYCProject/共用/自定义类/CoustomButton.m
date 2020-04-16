//
//  CoustomButton.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "CoustomButton.h"

@implementation CoustomButton
+(UIButton *) buttonWithBlueArrow : (CGRect) frame target:(id)target action:(SEL)selector
{
    UIColor * color =[UIColor colorWithRed:0x33/255.0 green:0xb5/255.0 blue:0xe5/255.0 alpha:1];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"<" forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:25]];
    [[button titleLabel] setTextAlignment:NSTextAlignmentLeft ];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self  action:@selector(clickChangeTitleColor:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchUpOutside];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchDragOutside];//// 保持按下,在按钮外面拖动
    return button;
}
+(UIButton *) buttonWithBlueBorder : (CGRect) frame target:(id)target action:(SEL)selector title:(NSString *)title
{
    UIColor * color =[UIColor colorWithRed:0x33/255.0 green:0xb5/255.0 blue:0xe5/255.0 alpha:1];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (frame.size.height <30) {
        button.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30);
    }
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self  action:@selector(clickChangeColor:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchUpOutside];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchDragOutside];//// 保持按下,在按钮外面拖动
    button.layer.borderColor = color.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 3;
    return button;
}
+(UIButton *) buttonWithOrangeColor : (CGRect) frame target:(id)target action:(SEL)selector title:(NSString *)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = frame;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self  action:@selector(clickChangeColor:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchUpOutside];
    [button addTarget:self  action:@selector(clickBackColor:) forControlEvents:UIControlEventTouchDragOutside];//// 保持按下,在按钮外面拖动
    button.layer.cornerRadius = 3;
    return button;

}
+(void) clickChangeTitleColor:(UIButton *)sender
{
    if ([sender viewWithTag:100] == nil) {
        UILabel * label = [[UILabel alloc] initWithFrame:sender.titleLabel.frame];
        label.text = sender.titleLabel.text;
        label.textColor = [UIColor blackColor];
        [label setFont:sender.titleLabel.font];
        label.tag = 100;
        label.alpha = 0.2;
        [sender addSubview:label];
        [label release];
    }
}
+(void) clickChangeColor:(UIButton *)sender
{
    if ([sender viewWithTag:100] == nil) {
        UIView * view = [[UIView alloc] initWithFrame:sender.bounds];
        view.layer.borderWidth = sender.layer.borderWidth;
        view.layer.cornerRadius = sender.layer.cornerRadius;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.2;
        view.tag = 100;
        
        [sender addSubview:view];
        [view release];
    }
}
+(void) clickBackColor:(UIButton *)sender
{
    UIView * view = [sender viewWithTag:100];
    if (view)
    {
        [view removeFromSuperview];
    }
}

@end

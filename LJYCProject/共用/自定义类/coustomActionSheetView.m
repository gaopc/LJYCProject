//
//  coustomActionSheetView.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "coustomActionSheetView.h"

#define kDuration 0.3
@implementation coustomActionSheetView
@synthesize _selectStr;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSMutableArray *)array
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 260)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [imgView setImage:[UIImage imageNamed:@"bg_023@2x.png"]];
    
    locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    locatePicker.showsSelectionIndicator = YES;
    
    titleLabel = [[UISubLabel alloc] initWithFrame:imgView.frame];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"btn_021@2x.png"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"btn_021.press@2x.png"] forState:UIControlStateHighlighted];
    leftButton.frame = CGRectMake(10, 1, 42, 42);
    [leftButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"btn_020@2x.png"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"btn_020.press@2x.png"] forState:UIControlStateHighlighted];
    rightButton.frame = CGRectMake(268, 1, 42, 42);
    [rightButton addTarget:self action:@selector(locate:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:imgView];
    [self addSubview:titleLabel];
    [self addSubview:leftButton];
    [self addSubview:rightButton];
    [self addSubview:locatePicker];
    
    
    self.delegate = delegate;
    locatePicker.dataSource = self;
    locatePicker.delegate = self;
    
    dataArray = [[NSArray alloc] initWithArray:array];
    
    [imgView release];
    return self;
}

- (void)showInView:(UIView *) view
{
    
    //    for (int i = 0; i < 2; i ++) {
    //        NSString *selectId = [NSString stringWithFormat:@"%d", 0];
    //        [selectArray replaceObjectAtIndex:i withObject:selectId];
    //    }
    
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataArray count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *printString;
    printString = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 45)];
    printString.textColor = FontColor000000;
    printString.text = [dataArray objectAtIndex:row];
    [printString autorelease];
    printString.backgroundColor = [UIColor clearColor];
    printString.textAlignment = UITextAlignmentCenter;
    
    return printString;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self._selectStr = [dataArray objectAtIndex:row];
}

#pragma mark - Button lifecycle

- (void)cancel:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (void)locate:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
}

- (void)dealloc
{
    [titleLabel release];
    [locatePicker release];
    [dataArray release];
    
    self._selectStr = nil;
    [super dealloc];
}

@end

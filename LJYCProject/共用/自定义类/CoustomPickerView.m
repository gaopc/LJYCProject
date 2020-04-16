//
//  CoustomPickerView.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-1.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "CoustomPickerView.h"

#define componentWidth 244

@implementation CustomPickerView
@synthesize _majorNames, _selectedLine, _selectedMajor;

-(void)dealloc
{
    self._majorNames = nil;
    self._selectedMajor = nil;
    self._selectedLine = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self._majorNames = [[NSArray alloc]initWithObjects:@"111", @"222", @"333", @"444", @"555", nil];
        selectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        selectPicker.backgroundColor = [UIColor clearColor];
        selectPicker.showsSelectionIndicator = YES;
        selectPicker.delegate = self;
        selectPicker.dataSource = self;
        selectPicker.opaque = YES;
        
        [self addSubview:selectPicker];
    }
    return self;
}

- (void)set_majorNames:(NSArray *)arry
{
    if (_majorNames != arry) {
        [_majorNames release];
        _majorNames = [arry retain];
    
        self._selectedMajor = [self._majorNames objectAtIndex:0];
        self._selectedLine = @"0";
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self._majorNames count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *printString;
    printString = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, componentWidth, 45)];
    printString.textColor = FontColor000000;
    printString.text = [self._majorNames objectAtIndex:row];
    [printString autorelease];
    printString.backgroundColor = [UIColor clearColor];
    printString.textAlignment = UITextAlignmentCenter;
    
    return printString;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return componentWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    selectedMajor = [pickerView selectedRowInComponent:component];
    self._selectedMajor = [self._majorNames objectAtIndex:row];
    self._selectedLine = [NSString stringWithFormat:@"%d", row];
}

- (void)setFrame:(CGRect)rect {
    [super setFrame:CGRectMake(0, 0, rect.size.width, 330)];
    self.center = CGPointMake(ViewWidth/2, ViewHeight/2);
}

- (void)layoutSubviews {
    selectPicker.frame = CGRectMake(10, 45, self.frame.size.width - 20, self.frame.size.height - 50);
    for (UIView *view in self.subviews) {
        NSLog(@"%@", [[view class] description]);
        if ([[[view class] description] isEqualToString:@"UIAlertButton"]) {
            view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 15, view.frame.size.width, view.frame.size.height); 
        } 
    } 
} 
@end
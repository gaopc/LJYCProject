//
//  CoustormPullDownMenuView.m
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

@interface CoustormPullDownMenuView()
@property (nonatomic,retain) UILabel * label;
@property (nonatomic,retain) UIScrollView * scrollV;
@end

#import "CoustormPullDownMenuView.h"


@implementation CoustormPullDownMenuView

@synthesize  delegate,array,placeStr,selectedString,selectedIndex,label,scrollV;
- (void)dealloc
{
    self.array = nil;
    self.placeStr = nil;
    self.label = nil;
    self.scrollV = nil;
    self.delegate = nil;
    [selectedString release];
    selectedString = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        selectedString = nil;
        selectedIndex = -1;
        self.backgroundColor = [UIColor clearColor];
        self.label = [UILabel labelWithTitle:@"请选择" frame:CGRectMake(20, 0, frame.size.width-20, frame.size.height) font:FontSize24 alignment:UITextAlignmentLeft];
        self.label.textColor = [UIColor grayColor];
        [self addSubview:self.label];
        UIButton * button = [UIButton buttonWithTag:0 frame:self.label.frame target:self action:@selector(selectClick)];
        [self addSubview:button];
    }
    return self;
}
-(void)setPlaceStr:(NSString *)str
{
    if (placeStr != str) {
        [placeStr release];
        placeStr = [str retain];
        self.label.text = str;
    }
}

-(void)setArray:(NSArray *)_array
{
    if (array != _array) {
        [array release];
        array = [_array retain];
        self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 120)] ;
        scrollV.backgroundColor = [UIColor whiteColor];
        scrollV.layer.borderColor = [UIColor colorWithRed:0xEF/255.0 green:0xEF/255.0 blue:0xEF/255.0 alpha:1].CGColor;
        scrollV.layer.borderWidth = 1;
        scrollV.layer.cornerRadius = 3;
        
        for (int i = 0; i<[array count]; i++) {
            NSString * string = [array objectAtIndex:i];
            float height = 30;
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom tag:i title:string backImage:Nil frame:CGRectMake(0, i * height, self.frame.size.width, height) font:FontSize24 color:[UIColor blackColor] target:self action:@selector(click:)];
            [scrollV addSubview:button];
            scrollV.contentSize = CGSizeMake(self.frame.size.width, i * height + 30);
            
            if (i < [array count] -1) {
                UILabel * labelg =[UILabel labelWithframe:CGRectMake(10, i * height+height, self.frame.size.width-20, 1) backgroundColor:[UIColor grayColor]];
                labelg.alpha = 0.3;
                [scrollV addSubview:labelg];
            }
        }
    }
}
-(void)selectClick
{
    if ([self.scrollV superview]) {
        [self closeView];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedSelf:)]) {
            [self.delegate performSelector:@selector(selectedSelf:) withObject:self];
        }
        
        float height =self.frame.size.height;
        height += self.scrollV.frame.size.height;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        [self addSubview:self.scrollV];
    }
}
-(void)click:(UIButton *)sender
{
    self.selectedString = sender.titleLabel.text ;
    selectedIndex = sender.tag;
    self.label.text = selectedString;
    self.label.textColor = [UIColor blackColor];
    [self closeView];
}
-(void)setSelectedString:(NSString *)_selectedString
{
    if (selectedString != _selectedString) {
        [selectedString release];
        selectedString = [_selectedString retain];
        if (_selectedString) {
            self.label.text = selectedString;
            self.label.textColor = [UIColor blackColor];
            selectedIndex = [self.array indexOfObject:selectedString];
        }
        else
        {
            self.label.text = self.placeStr;
            self.label.textColor = [UIColor grayColor];
            selectedIndex = -1;
        }
    }
}
-(void ) closeView
{
    if (self.scrollV.superview) {
        float height =self.frame.size.height;
        height -= self.scrollV.frame.size.height;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        [self.scrollV removeFromSuperview];
    }
}
@end

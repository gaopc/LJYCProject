//
//  SingInCell.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "SingInCell.h"

@implementation SingInCell
@synthesize leftView,leftName,leftDate,leftBtn;
@synthesize rightView,rightName,rightDate,rightBtn;
@synthesize delegate;

- (void)dealloc
{
    self.leftView = nil;
    self.leftName = nil;
    self.leftDate = nil;
    self.leftBtn = nil;
    
    self.rightView = nil;
    self.rightName = nil;
    self.rightDate = nil;
    self.rightBtn = nil;
    
    self.delegate = nil;
    
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth/2, 65)];
        self.leftView = view1;
        [view1 release];
        
        self.leftName = [UISubLabel labelWithTitle:@"小兔子贝贝" frame:CGRectMake(5, 0, ViewWidth/2-10, 30) font:FontBlodSize36 color:FontColor000000 alignment:NSTextAlignmentCenter];
        self.leftDate = [UISubLabel labelWithTitle:@"10-13 12：20" frame:CGRectMake(0, 30, ViewWidth/2, 30) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
        self.leftBtn = [UIButton customButtonTitle:nil tag:1 image:nil frame:CGRectMake(0, 5, ViewWidth/2, 65) target:self.delegate action:@selector(click:)];
        [self.leftView addSubview:self.leftName];
        [self.leftView addSubview:self.leftDate];
        [self.leftView addSubview:self.leftBtn];
        
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth/2,10, ViewWidth/2, 65)];
        self.rightView = view2;
        [view2 release];
        
        self.rightName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(5, 0, ViewWidth/2 - 10, 30) font:FontBlodSize36 color:FontColor000000 alignment:NSTextAlignmentCenter];
        self.rightDate = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0, 30, ViewWidth/2, 30) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
        self.rightBtn = [UIButton customButtonTitle:nil tag:2 image:nil frame:CGRectMake(0, 5, ViewWidth/2, 65) target:self.delegate action:@selector(click:)];
        [self.rightView addSubview:self.rightName];
        [self.rightView addSubview:self.rightDate];
        [self.rightView addSubview:self.rightBtn];
        
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
    }
    return self;
}

-(void)click:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(click:)])
    {
        [self.delegate performSelector:@selector(click:) withObject:self];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

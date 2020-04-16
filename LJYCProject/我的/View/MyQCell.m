//
//  MyQCell.m
//  LJYCProject
//
//  Created by xiemengyue on 14-1-16.
//  Copyright (c) 2014年 longcd. All rights reserved.
//

#import "MyQCell.h"

@implementation MyQCell

@synthesize _content, _date;
@synthesize _imageView;

- (void)dealloc
{
    self._content = nil;
    self._date = nil;
    self._imageView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 50) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        self._imageView = backView;

        UISubLabel *questionLab = [UISubLabel labelWithTitle:@"问：" frame:CGRectMake(25, 0, 30, 25) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentLeft];
        self._content = [UISubLabel labelWithTitle:@"请问一共可以容纳多少人住宿，谢谢！" frame:CGRectMake(45, 6, 275, 25) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentLeft];
        
        self._date = [UISubLabel labelWithTitle:@"2013-06-24  17：21" frame:CGRectMake(195, 25, 100, 15) font:FontSize18 color:FontColor333333  alignment:NSTextAlignmentRight];
        
        
        [self addSubview:self._imageView];
        [self addSubview:self._content];
        [self addSubview:self._date];
        [self addSubview:questionLab];
    }
    return self;
}

@end



@implementation MyACell
@synthesize _content, _date;
@synthesize _imageView;

- (void)dealloc
{
    self._content = nil;
    self._date = nil;
    self._imageView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 50) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        self._imageView = backView;
        
        
        UISubLabel *answerLab = [UISubLabel labelWithTitle:@"商家回复：" frame:CGRectMake(25, 0, 55, 25) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentLeft];
        
        self._content = [UISubLabel labelWithTitle:@"我这边住宿条件非常好，12个房间、48个床位。" frame:CGRectMake(75, 6, 275, 25) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentLeft];
        self._date = [UISubLabel labelWithTitle:@"2013-06-25  17：21" frame:CGRectMake(195, 25, 100, 15) font:FontSize18 color:FontColor333333  alignment:NSTextAlignmentRight];
        
        [self addSubview:self._imageView];
        [self addSubview:self._content];
        [self addSubview:self._date];
        [self addSubview:answerLab];
    }
    return self;
}
@end


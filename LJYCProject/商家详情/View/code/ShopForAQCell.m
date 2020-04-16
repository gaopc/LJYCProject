//
//  ShopForAQCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForAQCell.h"

@implementation ShopForQCell
@synthesize _content, _date, _name;
@synthesize _imageView;

- (void)dealloc
{
    self._content = nil;
    self._date = nil;
    self._name = nil;
    self._imageView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 50) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        self._imageView = backView;
        
        self._name = [UISubLabel labelWithTitle:@"喜羊羊的春天" frame:CGRectMake(25, 0, 100, 30) font:FontSize24 color:[UIColor purpleColor] alignment:NSTextAlignmentLeft];
        self._date = [UISubLabel labelWithTitle:@"2013-06-24  17：21" frame:CGRectMake(195, 0, 100, 30) font:FontSize18 color:FontColor333333  alignment:NSTextAlignmentRight];
        self._content = [UISubLabel labelWithTitle:@"请问一共可以容纳多少人住宿，谢谢！" frame:CGRectMake(45, 25, 275, 25) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentLeft];
        
        UISubLabel *questionLab = [UISubLabel labelWithTitle:@"问：" frame:CGRectMake(25, 25, 30, 25) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._imageView];
        [self addSubview:self._name];
        [self addSubview:self._content];
        [self addSubview:self._date];
        [self addSubview:questionLab];
    }
    return self;
}
@end


@implementation ShopForACell
@synthesize _content, _date, _name;
@synthesize _imageView;

- (void)dealloc
{
    self._content = nil;
    self._date = nil;
    self._name = nil;
    self._imageView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 50) image:[[UIImage imageNamed:@"背景-中.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        self._imageView = backView;
        
        self._name = [UISubLabel labelWithTitle:@"农家乐老板" frame:CGRectMake(25, 0, 100, 30) font:FontSize24 color:[UIColor brownColor] alignment:NSTextAlignmentLeft];
        self._date = [UISubLabel labelWithTitle:@"2013-06-25  17：21" frame:CGRectMake(195, 0, 100, 30) font:FontSize18 color:FontColor333333  alignment:NSTextAlignmentRight];
        self._content = [UISubLabel labelWithTitle:@"我这边住宿条件非常好，12个房间、48个床位。" frame:CGRectMake(55, 31, 275, 25) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentLeft];
        
        UISubLabel *answerLab = [UISubLabel labelWithTitle:@"回复：" frame:CGRectMake(25, 25, 40, 25) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._imageView];
        [self addSubview:self._name];
        [self addSubview:self._content];
        [self addSubview:self._date];
        [self addSubview:answerLab];
    }
    return self;
}
@end


@implementation ShopStarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 30) image:[[UIImage imageNamed:@"白条.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        
        self._name = [UISubLabel labelWithTitle:@"渔家农家乐" frame:CGRectMake(25, 2, 100, 30) font:FontSize24 color:FontColor000000  alignment:NSTextAlignmentLeft];
        UIImageView * cellArrowImageView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 30, 10, 7, 10) image:[UIImage imageNamed:@"CellArrow.png"]];
        
        starImg0.frame = CGRectMake(143, 10, 10, 10);
        starImg1.frame = CGRectMake(143 + 15, 10, 10, 10);
        starImg2.frame = CGRectMake(143 + 15*2, 10, 10, 10);
        starImg3.frame = CGRectMake(143 + 15*3, 10, 10, 10);
        starImg4.frame = CGRectMake(143 + 15*4, 10, 10, 10);
        
        [self addSubview:backView];
        [self addSubview:self._name];
        [self addSubview:starImg0];
        [self addSubview:starImg1];
        [self addSubview:starImg2];
        [self addSubview:starImg3];
        [self addSubview:starImg4];
        
        [self addSubview:cellArrowImageView];

    }
    return self;
}


@end

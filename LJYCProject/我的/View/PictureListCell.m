//
//  PictureListCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-22.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "PictureListCell.h"

@implementation PictureListCell
@synthesize _shopImageLeftView, _shopImageRightView;
@synthesize _leftBut, _rightBut;
@synthesize _rightLab;
@synthesize _leftView, _rightView;

- (void)dealloc
{
    self._shopImageRightView = nil;
    self._shopImageLeftView = nil;
    self._rightBut = nil;
    self._leftBut = nil;
    self._rightLab = nil;
    self._rightView = nil;
    self._leftView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UISubLabel *leftLab = [UISubLabel labelWithframe:CGRectMake(22, 3, 128, 128) backgroundColor:FontColorFFFFFF];
        leftLab.layer.borderWidth = 1;
        leftLab.layer.cornerRadius = 3;
        leftLab.layer.borderColor = [UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xFF/255.0 alpha:1].CGColor;
        [self addSubview:leftLab];
        
        self._shopImageLeftView = [[AsyncImageView alloc]initWithFrame:CGRectMake(24, 5, 124, 124)];
        self._shopImageLeftView.imageView.clipsToBounds = YES;
		self._shopImageLeftView.defaultImage = 2;
        self._shopImageLeftView._cutImage = YES;
		[self addSubview:self._shopImageLeftView];
        
        self._leftView = [UIImageView ImageViewWithFrame:CGRectMake(128, 0, 25, 25) image:[UIImage imageNamed:@"商.png"]];
        self._leftView.hidden = YES;
        [self addSubview:self._leftView];
        
        self._rightLab = [UISubLabel labelWithframe:CGRectMake(170, 3, 128, 128) backgroundColor:FontColorFFFFFF];
        self._rightLab.layer.borderWidth = 1;
        self._rightLab.layer.cornerRadius = 3;
        self._rightLab.layer.borderColor = [UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xFF/255.0 alpha:1].CGColor;
        [self addSubview:self._rightLab];
        
        self._shopImageRightView = [[AsyncImageView alloc]initWithFrame:CGRectMake(172, 5, 124, 124)];
        self._shopImageRightView._cutImage = YES;
        self._shopImageRightView.imageView.contentMode = UIViewContentModeScaleAspectFill;
		self._shopImageRightView.defaultImage = 2;
		[self addSubview:self._shopImageRightView];
        
        self._rightView = [UIImageView ImageViewWithFrame:CGRectMake(276, 0, 25, 25) image:[UIImage imageNamed:@"商.png"]];
        self._rightView.hidden = YES;
        [self addSubview:self._rightView];
        
        self._leftBut = [UIButton buttonWithTag:0 frame:CGRectMake(22, 3, 128, 128) target:nil action:nil];
        self._rightBut = [UIButton buttonWithTag:1 frame:CGRectMake(170, 3, 128, 128) target:nil action:nil];
        
        [self addSubview:self._leftBut];
        [self addSubview:self._rightBut];
    }
    return self;
}
@end

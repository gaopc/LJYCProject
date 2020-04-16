//
//  ShopForCommentCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForCommentCell.h"

@implementation ShopForCommentCell
@synthesize _content, _date, _name;
@synthesize _horizontalView, _verticalView;

- (void)dealloc
{
    self._name = nil;
    self._content = nil;
    self._date = nil;
    self._horizontalView = nil;
    self._verticalView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UIImageView *iconView = [UIImageView ImageViewWithFrame:CGRectMake(10, 5, 30, 30) image:[UIImage imageNamed:@"lv.png"]];
        self._verticalView = [UIImageView ImageViewWithFrame:CGRectMake(25, 0, 1, 85) image:[UIImage imageNamed:@"分割线.png"]];
        self._horizontalView = [UIImageView ImageViewWithFrame:CGRectMake(25, 80, 253, 1) image:[UIImage imageNamed:@"横向分割线.png"]];
        
        self._name = [UISubLabel labelWithTitle:@"好吃的吃货" frame:CGRectMake(50, 5, 75, 20) font:FontSize24 color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        self._date = [UISubLabel labelWithTitle:@"2013.06.24  17：21" frame:CGRectMake(175, 2, 103, 30) font:FontSize18 color:FontColor333333  alignment:NSTextAlignmentRight];
        self._content = [UISubLabel labelWithTitle:@"菜口味很好，老板人很好，下次会再来。服务一流、量给的非常大，很满意" frame:CGRectMake(50, 50, 220, 30) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentLeft];
        
        starImg0.frame = CGRectMake(50, 30, 16, 16);
        starImg1.frame = CGRectMake(50 + 24, 30, 16, 16);
        starImg2.frame = CGRectMake(50 + 24*2, 30, 16, 16);
        starImg3.frame = CGRectMake(50 + 24*3, 30, 16, 16);
        starImg4.frame = CGRectMake(50 + 24*4, 30, 16, 16);
        
        [self setHeartFrame:CGRectMake(115, 11, 10, 10) withView:self];
        [self setHeartCount:0];
        
        
        [self addSubview:self._verticalView];
        [self addSubview:self._horizontalView];
        [self addSubview:iconView];
        [self addSubview:self._name];
        [self addSubview:self._date];
        [self addSubview:self._content];
        [self addSubview:starImg0];
        [self addSubview:starImg1];
        [self addSubview:starImg2];
        [self addSubview:starImg3];
        [self addSubview:starImg4];
    }
    return self;
}

@end


@implementation ShopForReplyCell
@synthesize _shopContent, _shopDate;
@synthesize _verticalView, _horizontalView, _imageView;

- (void)dealloc
{
    self._shopContent = nil;
    self._shopDate = nil;
    self._imageView = nil;
    self._horizontalView = nil;
    self._verticalView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._verticalView = [UIImageView ImageViewWithFrame:CGRectMake(25, 0, 1, 75) image:[UIImage imageNamed:@"分割线.png"]];
        self._horizontalView = [UIImageView ImageViewWithFrame:CGRectMake(25, 65, 253, 1) image:[UIImage imageNamed:@"横向分割线.png"]];
        
        UISubLabel *replyName = [UISubLabel labelWithTitle:@"商家回复" frame:CGRectMake(50, 7, 228, 30) font:FontSize24 color:[UIColor brownColor] alignment:NSTextAlignmentLeft];
        self._shopDate = [UISubLabel labelWithTitle:@"2013.06.24  17：21" frame:CGRectMake(170, 8, 103, 30) font:FontSize18 color:FontColor333333  alignment:NSTextAlignmentRight];
        self._shopContent = [UISubLabel labelWithTitle:@"欢迎再来啊！" frame:CGRectMake(50, 35, 220, 30) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentLeft];
        
        self._imageView = [UIImageView ImageViewWithFrame:CGRectMake(40, 0, 238, 55) image:[[UIImage imageNamed:@"商家回复.png"] stretchableImageWithLeftCapWidth:55 topCapHeight:30]];
        
        [self addSubview:self._imageView];
        [self addSubview:self._verticalView];
        [self addSubview:self._horizontalView];
        [self addSubview:replyName];
        [self addSubview:self._shopDate];
        [self addSubview:self._shopContent];
    }
    return self;
}

@end


//
//  UserReviewCell.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "UserReviewCell.h"

@implementation UserReviewCell
@synthesize _content, _date, _name;
@synthesize verticalView1,horizontalView1,verticalView2,horizontalView2,imageView,label,reViewContentLabel,reViewTimeLabel;

- (void)dealloc
{
    self._name = nil;
    self._content = nil;
    self._date = nil;
    
    self.verticalView1 = nil;
    self.horizontalView1 = nil;
    self.verticalView2 = nil;
    self.horizontalView2 = nil;
    self.imageView = nil;
    self.label = nil;
    self.reViewContentLabel = nil;
    self.reViewTimeLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *iconView = [UIImageView ImageViewWithFrame:CGRectMake(17, 5, 30, 30) image:[UIImage imageNamed:@"lv.png"]];
        
        self.verticalView1 = [UIImageView ImageViewWithFrame:CGRectMake(32, 0, 1, 85) image:[UIImage imageNamed:@"分割线.png"]];
        self.horizontalView1 = [UIImageView ImageViewWithFrame:CGRectMake(32, 80, 270, 1) image:[UIImage imageNamed:@"横向分割线.png"]];
        
        self._name = [UISubLabel labelWithTitle:@"测试" frame:CGRectMake(50, 5, 75, 20) font:FontSize24 color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        
        self._date = [UISubLabel labelWithTitle:@"2013.06.24  17：21" frame:CGRectMake(175, 2, 103, 30) font:FontSize20 color:FontColor333333  alignment:NSTextAlignmentRight];
        self._content = [UISubLabel labelWithTitle:@"测试测试测试" frame:CGRectMake(50, 50, 220, 30) font:FontSize20 color:FontColor656565  alignment:NSTextAlignmentLeft];
        
        starImg0.frame = CGRectMake(50, 30, 16, 16);
        starImg1.frame = CGRectMake(50 + 24, 30, 16, 16);
        starImg2.frame = CGRectMake(50 + 24*2, 30, 16, 16);
        starImg3.frame = CGRectMake(50 + 24*3, 30, 16, 16);
        starImg4.frame = CGRectMake(50 + 24*4, 30, 16, 16);
        
        
        [self addSubview:self.verticalView1];
        [self addSubview:self.horizontalView1];
        [self addSubview:iconView];
        [self addSubview:self._name];
        [self addSubview:self._date];
        [self addSubview:self._content];
        [self addSubview:starImg0];
        [self addSubview:starImg1];
        [self addSubview:starImg2];
        [self addSubview:starImg3];
        [self addSubview:starImg4];

        self.verticalView2 = [UIImageView ImageViewWithFrame:CGRectMake(32, 70, 1, 70) image:[UIImage imageNamed:@"分割线.png"]];
        self.horizontalView2 = [UIImageView ImageViewWithFrame:CGRectMake(32, 130, 270, 1) image:[UIImage imageNamed:@"横向分割线.png"]];
        self.imageView = [UIImageView ImageViewWithFrame:CGRectMake(47, 65, 252, 55) image:[[UIImage imageNamed:@"商家回复.png"] stretchableImageWithLeftCapWidth:55 topCapHeight:30]];
        self.label = [UISubLabel labelWithTitle:@"商家回复:" frame:CGRectMake(50, 70, 228, 15) font:FontSize18 color:FontColor1F7EBF alignment:NSTextAlignmentLeft];
        self.reViewContentLabel = [UISubLabel labelWithTitle:@"谢谢惠顾，下次再来" frame:CGRectMake(50, 86, 250, 30) font:FontSize20 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.reViewTimeLabel = [UISubLabel labelWithTitle:@"2013.06.24  17：40" frame:CGRectMake(190, 70, 103, 30) font:FontSize20 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        [self addSubview:self.verticalView2];
        [self addSubview:self.horizontalView2];
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        [self addSubview:self.reViewContentLabel];
        [self addSubview:self.reViewTimeLabel];
        [self setStar:3];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

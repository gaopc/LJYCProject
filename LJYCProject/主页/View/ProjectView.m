//
//  ProjectView.m
//  LJYCProject
//
//  Created by xiemengyue on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ProjectView.h"

@implementation ProjectView
@synthesize imageView,titleLabel,detailsLabel;
//@synthesize subjectImageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) image:[UIImage imageNamed:@"白背景.png"]]];
        self.imageView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 155, self.frame.size.height) image:nil];
        self.titleLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(165, 0, 150, 30) font:FontSize20 color:FontColor1B77C3 alignment:NSTextAlignmentLeft];
//        self.subjectImageView = [UIImageView ImageViewWithFrame:CGRectMake(self.frame.size.width-32, 5, 30, 15) image:nil];
        self.detailsLabel = [UISubLabel labelWithTitle:@"当用选择自动登录从否到是的时候，给出确认：“开启自动登录功能，在每次启动辣郊游时会自动登录您的账号。本公司对于在自动登录情况下由于手机丢失而导致的客户信息泄露不承担法律责任，请你谅解。" frame:CGRectMake(165, 30, 135, self.frame.size.height-35) font:FontSize14 color:FontColor1B77C3 alignment:NSTextAlignmentLeft autoSize:YES];
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
//        [self addSubview:self.subjectImageView];
        [self addSubview:self.detailsLabel];
    }
    return self;
}

- (void)dealloc
{
    self.imageView = nil;
    self.titleLabel = nil;
//    self.subjectImageView = nil;
    self.detailsLabel = nil;
    
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  HelpCell.m
//  LJYCProject
//
//  Created by xiemengyue on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "HelpCell.h"

@implementation HelpCell
@synthesize bakgroundImageView,imageView1,imageView2,titleLabel,numLabel;

- (void)dealloc
{
    self.bakgroundImageView = nil;
    self.imageView1 = nil;
    self.imageView2 = nil;
    self.titleLabel = nil;
    self.numLabel = nil;
    
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.bakgroundImageView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) image:[UIImage imageNamed:@"使用帮助_22.png"]];
        self.imageView1 = [UIImageView ImageViewWithFrame:CGRectMake(50, 40-5, 12, 5) image:[UIImage imageNamed:@"使用帮助_25.png"]];
        self.imageView2 = [UIImageView ImageViewWithFrame:CGRectMake(self.frame.size.width-30, 15, 9, 6) image:[UIImage imageNamed:@"使用帮助_15.png"]];
        
        self.numLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 10, 15, 20) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentCenter];
        self.titleLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(45, 12, 80, 15) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.bakgroundImageView];
        [self addSubview:self.imageView1];
        [self addSubview:self.imageView2];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(7, 10, 20, 20) image:[UIImage imageNamed:@"使用帮助_07.png"]]];
        [self addSubview:self.numLabel];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

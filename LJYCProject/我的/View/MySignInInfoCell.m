//
//  MySignInInfoCell.m
//  LJYCProject
//
//  Created by xiemengyue on 13-12-3.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MySignInInfoCell.h"

@implementation MySignInInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView * cellImageView = [UIImageView ImageViewWithFrame:CGRectMake(10, 3, ViewWidth-20, 45) image:[UIImage imageNamed:@"个人中心cell.png"]];
        UIImageView * cellArrowImageView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 20, 19, 7, 10) image:[UIImage imageNamed:@"CellArrow.png"]];
        
        self.shopNameLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20, 5, ViewWidth-40, 35) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.timeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-130, 8, 100, 30) font:FontSize24 color:FontColor565656 alignment:NSTextAlignmentRight];
        
        starImg0.frame = CGRectMake(20, 35, 10, 10);
        starImg1.frame = CGRectMake(20 + 12, 35, 10, 10);
        starImg2.frame = CGRectMake(20 + 12*2, 35, 10, 10);
        starImg3.frame = CGRectMake(20 + 12*3, 35, 10, 10);
        starImg4.frame = CGRectMake(20 + 12*4, 35, 10, 10);
        
        [self addSubview:cellImageView];
        [self addSubview:cellArrowImageView];
        [self addSubview:self.shopNameLabel];
        [self addSubview:self.timeLabel];
        
        [self addSubview:starImg0];
        [self addSubview:starImg1];
        [self addSubview:starImg2];
        [self addSubview:starImg3];
        [self addSubview:starImg4];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

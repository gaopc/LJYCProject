//
//  ShopForPublicCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForPublicCell.h"

@implementation ShopForPublicCell
@synthesize _heartArr;

- (void)dealloc
{
    self._heartArr = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        starImg0 = [UIImageView ImageViewWithFrame:CGRectMake(185, 30, 14, 14)];
        starImg1 = [UIImageView ImageViewWithFrame:CGRectMake(185 + 20, 30, 14, 14)];
        starImg2 = [UIImageView ImageViewWithFrame:CGRectMake(185 + 40, 30, 14, 14)];
        starImg3 = [UIImageView ImageViewWithFrame:CGRectMake(185 + 60, 30, 14, 14)];
        starImg4 = [UIImageView ImageViewWithFrame:CGRectMake(185 + 80, 30, 14, 14)];
    }
    return self;
}

- (void)setStar:(float)count
{
    if (count == -1) {
        return;
    }
    
    int stateNum = count * 10;
    NSArray *array = [NSArray arrayWithObjects:starImg0, starImg1, starImg2, starImg3, starImg4, nil];
    
    for (int i = 0; i < 5; i++) {
        UIImageView *starImg = [array objectAtIndex:i];
        
        if (count > i) {
            
            if (stateNum % 10 > 0 && stateNum / 10 == i) {
                starImg.image = [UIImage imageNamed:@"星星半色.png"];
            }
            else {
                starImg.image = [UIImage imageNamed:@"星星彩色.png"];
            }
        }
        else {
            starImg.image = [UIImage imageNamed:@"星星灰色.png"];
        }
    }
}

- (void)setHeartFrame:(CGRect)frame withView:(UIView *)supView
{
    self._heartArr = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        
        CGRect imgFrame = frame;
        imgFrame.origin.x += (imgFrame.size.width*6/5*(i + 1));
        
        UIImageView *imageView = [UIImageView ImageViewWithFrame:imgFrame];
        [self._heartArr addObject:imageView];
        [supView addSubview:imageView];
    }
}

- (void)setHeartCount:(NSInteger)count
{
    if (count == 0) {
        return;
    }
    
    for (int i = 0; i < 5; i++) {
        UIImageView *starImg = [self._heartArr objectAtIndex:i];
        
        if (count > i) {
            starImg.image = [UIImage imageNamed:@"红心-00.png"];
        }
        else {
            starImg.image = [UIImage imageNamed:@"红心-01.png"];
        }
    }
}
@end

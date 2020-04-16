//
//  ShopForPublicCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-28.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopForPublicCell : UITableViewCell
{
    UIImageView *starImg0;
    UIImageView *starImg1;
    UIImageView *starImg2;
    UIImageView *starImg3;
    UIImageView *starImg4;
}
@property (nonatomic, retain) NSMutableArray *_heartArr;

- (void)setStar:(float)count;
- (void)setHeartCount:(NSInteger)count;
- (void)setHeartFrame:(CGRect)frame withView:(UIView *)supView;
@end

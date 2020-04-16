//
//  UserReviewCell.h
//  LJYCProject
//
//  Created by xiemengyue on 13-11-13.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopForPublicCell.h"

@interface UserReviewCell : ShopForPublicCell
@property (nonatomic, retain) UISubLabel *_name;
@property (nonatomic, retain) UISubLabel *_date;
@property (nonatomic, retain) UISubLabel *_content;

@property (nonatomic, retain) UIImageView *verticalView1;
@property (nonatomic, retain) UIImageView *horizontalView1;
@property (nonatomic, retain) UIImageView *verticalView2;
@property (nonatomic, retain) UIImageView *horizontalView2;

@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UISubLabel *label;
@property (nonatomic, retain) UISubLabel *reViewContentLabel;
@property (nonatomic, retain) UISubLabel *reViewTimeLabel;
@end


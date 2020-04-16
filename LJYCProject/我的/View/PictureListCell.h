//
//  PictureListCell.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-22.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface PictureListCell : UITableViewCell
@property (nonatomic, retain) AsyncImageView *_shopImageLeftView;
@property (nonatomic, retain) AsyncImageView *_shopImageRightView;
@property (nonatomic, retain) UIButton *_leftBut;
@property (nonatomic, retain) UIButton *_rightBut;
@property (nonatomic ,retain) UISubLabel *_rightLab;
@property (nonatomic, retain) UIImageView *_leftView;
@property (nonatomic, retain) UIImageView *_rightView;
@end
